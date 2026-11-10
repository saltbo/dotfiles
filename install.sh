#!/bin/bash
set -eufo pipefail

echo "🚀  Setting up @saltbo dotfiles."

if xcode-select -p &>/dev/null; then
    echo "✅  Xcode command line tools are already installed."
else
    echo "🔧  Installing Xcode command line tools..."
    xcode-select --install &>/dev/null

    while ! xcode-select -p &>/dev/null; do
        sleep 5
    done
    echo "✅  Xcode command line tools installed successfully."
fi

if which -s "brew"; then
    echo "✅  Homebrew is already installed."
else
    echo "🍺  Installing Homebrew"
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo "✅  Homebrew installed successfully."
fi

if [ -f ~/.oh-my-zsh/oh-my-zsh.sh ]; then
    echo "✅  oh-my-zsh is already installed."
else
    echo "💻  Installing oh-my-zsh"
    yes | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended
    echo "✅  oh-my-zsh installed successfully."
fi

if which -s "chezmoi"; then
    echo "✅  Chezmoi is already installed."
else
    echo "⚪️  Installing Chezmoi"
    eval "$(/opt/homebrew/bin/brew shellenv)"
    brew install chezmoi
fi

if [ -d "$HOME/.local/share/chezmoi/.git" ]; then
    echo "ℹ️  Chezmoi already initialized, pulling latest changes..."
    chezmoi update
    echo "✅  Chezmoi updated"
else
    chezmoi init saltbo --branch main
    chezmoi apply
    echo "✅  Chezmoi initialized"
fi
