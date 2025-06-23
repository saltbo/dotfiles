#!/usr/bin/env python

import os
import subprocess
import sys


def push_charts(directory, repo):
    tgz_files = [f for f in os.listdir(directory) if f.endswith(".tgz")]
    total_files = len(tgz_files)

    for index, filename in enumerate(tgz_files, 1):
        chart_path = os.path.join(directory, filename)
        command = ["helm", "cm-push", chart_path, repo, "-f"]
        if repo.startswith("oci://"):
            command = ["helm", "push", chart_path, repo]

        print(f"↑ Pushing [{index}/{total_files}] {filename} to {repo}")
        try:
            subprocess.run(
                command, check=True, capture_output=True, text=True)
            print(f"✓ Successfully pushed {filename} to {repo}")
        except subprocess.CalledProcessError as e:
            print(f"✗ Failed to push {filename} to {repo}: {e}")
            print(f"Error output: {e.stderr}")


if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python charts-upload.py <directory> <repo>")
        sys.exit(1)

    directory = sys.argv[1]
    repo = sys.argv[2]

    push_charts(directory, repo)
