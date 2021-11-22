#!/bin/sh

system_type=$(uname -s)

is_command() {
    command -v "$1" > /dev/null 2>&1
}

if [ ${system_type} = "Darwin" ]; then
    if ! is_command zsh; then
        echo "Installing zsh..."
        brew install zsh
        if [ $? -eq 0 ]; then
            echo "All packages are installed."
        else
            echo "Install zsh error."
        fi
    fi
fi
