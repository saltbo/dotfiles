# Shared by zsh and POSIX login shells. Keep all personal PATH policy here.
# Existing directories inherited from applications are retained after these
# explicit priorities. Missing and duplicate entries are omitted.
export VOLTA_HOME="$HOME/.volta"
export GOPATH="${GOPATH:-/opt/data/go}"
if [ "$(/usr/bin/uname -m)" = arm64 ]; then
    export HOMEBREW_PREFIX=/opt/homebrew
else
    export HOMEBREW_PREFIX=/usr/local
fi
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_INSTALL_UPGRADE=1

_saltbo_build_path() (
    # Language-managed commands take precedence; Homebrew is the fallback.
    remaining="$HOME/.local/bin:$VOLTA_HOME/bin:$GOPATH/bin:$HOME/.cargo/bin"
    remaining="$remaining:$HOMEBREW_PREFIX/opt/ruby/bin:$HOMEBREW_PREFIX/bin:$HOMEBREW_PREFIX/sbin:$HOME/.docker/bin"
    remaining="$remaining:${PATH:-/usr/bin:/bin:/usr/sbin:/sbin}"
    result=
    while [ -n "$remaining" ]; do
        directory=${remaining%%:*}
        case "$remaining" in
            *:*) remaining=${remaining#*:} ;;
            *) remaining= ;;
        esac
        [ -n "$directory" ] && [ -d "$directory" ] || continue
        # Also drop retired installer entries inherited from an older terminal.
        case "$directory" in
            "$HOME/.openclaw/bin"|"$HOME/.orbstack/bin"|"$HOME/Library/pnpm") continue ;;
        esac
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
