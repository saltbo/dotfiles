eval "$($HOMEBREW_PREFIX/bin/brew shellenv)"

# zplug
export ZPLUG_HOME=$HOMEBREW_PREFIX/opt/zplug
source $ZPLUG_HOME/init.zsh
zplug "plugins/encode64", from:oh-my-zsh
zplug "plugins/gpg-agent", from:oh-my-zsh
zplug "plugins/extract", from:oh-my-zsh
zplug "plugins/direnv", from:oh-my-zsh
zplug "plugins/history", from:oh-my-zsh
zplug "plugins/direnv", from:oh-my-zsh
#zplug "plugins/nvm", from:oh-my-zsh
#zplug "plugins/pip", from:oh-my-zsh
zplug "plugins/sudo", from:oh-my-zsh
zplug "plugins/transfer", from:oh-my-zsh
zplug "plugins/z", from:oh-my-zsh
zplug "plugins/history-substring-search", from:oh-my-zsh
zplug "zsh-users/zsh-autosuggestions", defer:2
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "NoahTheDuke/vim-just", defer:2

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    zplug install
fi
zplug load

# langs
# golang
export CGO_ENABLED=0
export GOPATH="/opt/data/go"
export GOPRIVATE="*.chehejia.com"
export GOPROXY="https://goproxy.cn,direct"
export GOTOOLCHAIN=local
export PATH=$GOPATH/bin:$PATH
# clang
export CPATH=$HOMEBREW_PREFIX/include
export LIBRARY_PATH=$HOMEBREW_PREFIX/lib
# rust
if [ -f "$HOME/.cargo/env" ]; then
    source "$HOME/.cargo/env"
fi
# ruby
export PATH=$PATH:$(gem env gemdir)/bin

# tools
# proxy
PROXY_ADDR="http://proxy.internal:6666"
export http_proxy=$PROXY_ADDR
export https_proxy=$PROXY_ADDR
export all_proxy=$PROXY_ADDR
export no_proxy="chehejia.com,chj.cloud,localtest.rs,localtest.me,localtest,localhost,127.0.0.1"
# kubectl
KCD="$HOME/.kube/conf.d"
if [ -d "$KCD" ]; then
    export KUBECONFIG="$HOME/.kube/config:$(find $HOME/.kube/conf.d -name "*.conf" -type f | paste -s -d : -)"
fi
# ko
export KO_DOCKER_REPO=saltbo
# gpg
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
export GPG_TTY=$(tty)
# npm
export NPM_CONFIG_OFFICIAL_REGISTRY_TOKEN=""
# istio
export HUB="docker.io/saltbo"
export TAG=istio-testing
export ISTIO=$HOME/develop/oss/istio

# alias for myself
source $HOME/.env
alias ls='lsd'
alias sed=gsed
#alias python=python3
#alias pip=pip3
alias y=yadm
alias k=kubectl
alias ic=istioctl
alias lc=limactl
alias ksw=kubectx
alias kns=kubens
alias argorollouts=kubectl-argo-rollouts
alias frpc="frpc -c $HOME/.config/frp/frpc.ini"
alias frpchttp="frpc http -s frps.saltbo.fun -P 32700 -n local -t $FRP_TOKEN"
alias nbox="nerdctl run --network host -it --rm saltbo/netshoot"
alias cc-goporject='cookiecutter https://github.com/saltbo/goproject'
alias brewfileup="brew bundle dump --global -f"
alias netstatnlp='netstat -na | grep LISTEN'
alias web='python3 -m http.server'
alias nclk="nc -lk"

# bindkey
bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down

# Added by OrbStack: command-line tools and integration
source ~/.orbstack/shell/init.zsh 2>/dev/null || :
