# dotfiles
⚠️本仓库仅供参考，不要直接clone下来用。因为我的习惯不一定适合你。

建议使用[yadm](https://github.com/TheLocehiliosan/yadm)自行维护自己的dotfiles。

# 使用

## 初始化

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install yadm && yadm clone --bootstrap git@github.com:saltbo/dotfiles.git
```

## 日常使用

```bash
# 更新Brewfile
brew bundle dump --global -f
yadm ci -am "refactor: update the .Brewfile"
```

# 待完善

## 秘钥
- bob
- wakatime

# 需要手动操作的
- 搜狗输入法
