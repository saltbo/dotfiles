# dotfiles
Private dotfiles for macos

# 使用

## 初始化

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install yadm
yadm clone git@github.com:saltbo/dotfiles.git
yadm bootstrap
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
