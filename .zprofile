eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH="$HOME/.local/bin:$PATH"

# kubectl
KCD="$HOME/.kube/config.d"
if [ -d "$KCD" ]; then
    export KUBECONFIG="$(ls $KCD/*.yaml | tr '\n' ':')$HOME/.kube/config"
fi

# golang
export GOPATH="/opt/data/go"
export GOPRIVATE="*.chehejia.com"
export GOPROXY="https://goproxy.cn,https://mirrors.saltbo.cn/goproxy,direct"
export PATH=$PATH:$GOPATH/bin

# gpg
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
export GPG_TTY=$(tty)

# proxy
export ALL_PROXY=socks5://127.0.0.1:6666
export HTTP_PROXY=socks5://127.0.0.1:6666
export HTTPS_PROXY=socks5://127.0.0.1:6666


# alias for myself
alias sed=gsed
alias python=python3
alias pip=pip3
alias y=yadm
alias k=kubectl
alias ksw=kubectx
alias kns=kubens

