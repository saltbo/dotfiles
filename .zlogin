# brew
UNAME_MACHINE="$(/usr/bin/uname -m)"
if [[ "${UNAME_MACHINE}" == "arm64" ]]
then
  # On ARM macOS, this script installs to /opt/homebrew only
  HOMEBREW_PREFIX="/opt/homebrew"
else
  # On Intel macOS, this script installs to /usr/local only
  HOMEBREW_PREFIX="/usr/local"
fi
export HOMEBREW_NO_INSTALL_UPGRADE=1

# zsh completions for brew
source ${HOMEBREW_PREFIX}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fpath=(${HOMEBREW_PREFIX}/share/zsh/site-functions $fpath)
compinit

# zplug
export ZPLUG_HOME=$HOMEBREW_PREFIX/opt/zplug
source $ZPLUG_HOME/init.zsh
zplug "zsh-users/zsh-syntax-highlighting", defer:2

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
zplug load

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "${HOMEBREW_PREFIX}/opt/nvm/nvm.sh" ] && \. "${HOMEBREW_PREFIX}/opt/nvm/nvm.sh"  # This loads nvm
[ -s "${HOMEBREW_PREFIX}/opt/nvm/etc/bash_completion.d/nvm" ] && \. "${HOMEBREW_PREFIX}/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# kubectl
KCD="$HOME/.kube/conf.d"
if [ -d "$KCD" ]; then
    export KUBECONFIG="$(ls $KCD/*.config | tr '\n' ':')$HOME/.kube/kubeconfig"
fi

# golang
export GOPATH="/opt/data/go"
export GOPRIVATE="*.chehejia.com"
export GOPROXY="https://mirrors.saltbo.cn,https://goproxy.cn,direct"
export PATH=$PATH:$GOPATH/bin

# gpg
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
export GPG_TTY=$(tty)

# proxy
export all_proxy=socks5://selftz.me:23456
