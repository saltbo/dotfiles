# Shared by zsh and POSIX login shells. Keep all personal PATH policy here.
# Existing directories inherited from applications are retained after these
# explicit priorities. Missing and duplicate entries are omitted.
export VOLTA_HOME="$HOME/.volta"
export PNPM_HOME="$HOME/Library/pnpm"
export GOPATH="${GOPATH:-/opt/data/go}"
if [ "$(/usr/bin/uname -m)" = arm64 ]; then
    export HOMEBREW_PREFIX=/opt/homebrew
else
    export HOMEBREW_PREFIX=/usr/local
fi
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_INSTALL_UPGRADE=1

_saltbo_build_path() (
    remaining="$HOME/.local/bin:$PNPM_HOME:$HOMEBREW_PREFIX/opt/ruby/bin:$VOLTA_HOME/bin:$HOME/.openclaw/bin:$GOPATH/bin:$HOMEBREW_PREFIX/bin:$HOMEBREW_PREFIX/sbin:$HOME/.cargo/bin:$HOME/.krew/bin:$HOME/.docker/bin:$HOME/.orbstack/bin:$HOME/Develop/oss/flutter/bin:${PATH:-/usr/bin:/bin:/usr/sbin:/sbin}"
    result=
    while [ -n "$remaining" ]; do
        directory=${remaining%%:*}
        case "$remaining" in
            *:*) remaining=${remaining#*:} ;;
            *) remaining= ;;
        esac
        [ -n "$directory" ] && [ -d "$directory" ] || continue
        case ":$result:" in
            *":$directory:"*) continue ;;
        esac
        result="${result:+$result:}$directory"
    done
    printf '%s' "$result"
)
PATH=$(_saltbo_build_path)
export PATH
unset -f _saltbo_build_path
