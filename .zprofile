eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH="$HOME/.local/bin:$PATH"
export PATH="/opt/soft/bin:$PATH"

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
export http_proxy=http://127.0.0.1:6666 
export https_proxy=http://127.0.0.1:6666 
export all_proxy=socks5://127.0.0.1:6666
export no_proxy="localhost,localtest,127.0.0.1"

# alias for myself
alias sed=gsed
alias python=python3
alias pip=pip3
alias y=yadm
alias k=kubectl
alias ksw=kubectx
alias kns=kubens
alias frpc="frpc -c .frpc.ini"
