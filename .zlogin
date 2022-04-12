# PATH
export PATH="/opt/soft/bin:$PATH"
export PATH="$HOME/.krew/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# zsh completions
source ${HOMEBREW_PREFIX}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fpath=(${HOMEBREW_PREFIX}/share/zsh/site-functions $fpath)
fpath=(${HOMEBREW_PREFIX}/share/zsh-completions $fpath)
fpath=($HOME/.local/share/zsh-completions $fpath)
fpath=(/opt/soft/site-functions $fpath)
autoload -Uz compinit
compinit

# zplug
export ZPLUG_HOME=$HOMEBREW_PREFIX/opt/zplug
source $ZPLUG_HOME/init.zsh
zplug "plugins/encode64",   from:oh-my-zsh
zplug "plugins/dotenv",     from:oh-my-zsh
zplug "plugins/history",    from:oh-my-zsh
zplug "plugins/pip",        from:oh-my-zsh
zplug "plugins/transfer",   from:oh-my-zsh
zplug "plugins/z",          from:oh-my-zsh
zplug "zsh-users/zsh-syntax-highlighting", defer:2

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    zplug install
fi
zplug load

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "${HOMEBREW_PREFIX}/opt/nvm/nvm.sh" ] && \. "${HOMEBREW_PREFIX}/opt/nvm/nvm.sh"  # This loads nvm
[ -s "${HOMEBREW_PREFIX}/opt/nvm/etc/bash_completion.d/nvm" ] && \. "${HOMEBREW_PREFIX}/opt/nvm/etc/bash_completion.d/nvm"
source <(npm completion)

# mcfly
eval "$(mcfly init zsh)"

