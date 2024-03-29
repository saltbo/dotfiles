# brew
UNAME_MACHINE="$(/usr/bin/uname -m)"
if [[ "${UNAME_MACHINE}" == "arm64" ]]; then
    # On ARM macOS, this script installs to /opt/homebrew only
    HOMEBREW_PREFIX="/opt/homebrew"
else
    # On Intel macOS, this script installs to /usr/local only
    HOMEBREW_PREFIX="/usr/local"
fi
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_INSTALL_UPGRADE=1

# zsh completions
fpath=(${HOMEBREW_PREFIX}/share/zsh/site-functions $fpath)
fpath=(${HOMEBREW_PREFIX}/share/zsh-completions $fpath)
fpath=($HOME/.local/share/zsh-completions $fpath)
fpath=(/opt/soft/site-functions $fpath)
autoload -Uz compinit
compinit

# PATH
export PATH="/opt/soft/bin:$PATH"
export PATH="$HOME/.krew/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
