import json
from pathlib import Path
import shutil
import subprocess
import tempfile
import tomllib
import unittest


SOURCE = Path(__file__).resolve().parents[1] / "home"


class AgentConfigTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        root = Path(self.temp.name)
        source = root / "source"
        self.destination = root / "destination"
        source.mkdir()
        self.destination.mkdir()
        config = root / "chezmoi.toml"
        config.write_text("")
        for directory in ("dot_codex", "dot_claude"):
            shutil.copytree(SOURCE / directory, source / directory)
        self.command = [
            "chezmoi", "--config", str(config), "--source", str(source),
            "--destination", str(self.destination),
            "--persistent-state", str(root / "state.boltdb"),
            "apply", "--force",
        ]

    def apply(self):
        return subprocess.run(self.command, capture_output=True, text=True)

    def write(self, name, content):
        path = self.destination / name
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_text(content)
        return path

    def test_fresh_install_and_repeat_apply(self):
        result = self.apply()
        self.assertEqual(result.returncode, 0, result.stderr)
        codex = self.destination / ".codex/config.toml"
        claude = self.destination / ".claude/settings.json"
        self.assertEqual(tomllib.loads(codex.read_text())["model"], "gpt-6-astra")
        self.assertEqual(len(json.loads(claude.read_text())["hooks"]["PreToolUse"]), 1)
        self.assertEqual(codex.stat().st_mode & 0o777, 0o600)
        self.assertEqual(claude.stat().st_mode & 0o777, 0o600)
        before = (codex.read_bytes(), claude.read_bytes())
        result = self.apply()
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(before, (codex.read_bytes(), claude.read_bytes()))

    def test_codex_preserves_local_fields(self):
        path = self.write(".codex/config.toml", '''model = "old-model"
[projects."/tmp/local-project"]
trust_level = "trusted"
[mcp_servers.local]
url = "http://localhost:1234/mcp"
[features]
local_feature = true
''')
        result = self.apply()
        self.assertEqual(result.returncode, 0, result.stderr)
        data = tomllib.loads(path.read_text())
        self.assertEqual(data["projects"]["/tmp/local-project"]["trust_level"], "trusted")
        self.assertEqual(data["mcp_servers"]["local"]["url"], "http://localhost:1234/mcp")
        self.assertTrue(data["features"]["local_feature"])
        self.assertEqual(data["model"], "gpt-6-astra")

    def test_claude_preserves_hooks_permissions_and_env(self):
        custom = {"matcher": "Read", "hooks": [{"type": "command", "command": "custom-hook"}]}
        path = self.write(".claude/settings.json", json.dumps({
            "env": {"LOCAL_SETTING": "keep"},
            "permissions": {"deny": ["Read(private/*)"]},
            "hooks": {"PreToolUse": [custom], "Stop": []},
            "enabledPlugins": {"local-plugin": True},
        }))
        result = self.apply()
        self.assertEqual(result.returncode, 0, result.stderr)
        data = json.loads(path.read_text())
        self.assertEqual(data["env"], {"LOCAL_SETTING": "keep"})
        self.assertEqual(data["permissions"], {"deny": ["Read(private/*)"]})
        self.assertEqual(data["hooks"]["PreToolUse"][0], custom)
        self.assertEqual(len(data["hooks"]["PreToolUse"]), 2)
        self.assertEqual(data["hooks"]["Stop"], [])
        self.assertTrue(data["enabledPlugins"]["local-plugin"])
        before = path.read_bytes()
        result = self.apply()
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(path.read_bytes(), before)

    def test_invalid_existing_configs_fail_without_replacement(self):
        for name in (".codex/config.toml", ".claude/settings.json"):
            with self.subTest(name=name):
                path = self.write(name, "not valid { config")
                result = self.apply()
                self.assertNotEqual(result.returncode, 0)
                self.assertEqual(path.read_text(), "not valid { config")
                path.unlink()


if __name__ == "__main__":
    unittest.main()
