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
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_INSTALL_UPGRADE=1

# clang
export CPATH=$HOMEBREW_PREFIX/include  
export LIBRARY_PATH=$HOMEBREW_PREFIX/lib

# rust
if [ -f "$HOME/.cargo/env" ]; then
  source "$HOME/.cargo/env"
fi

# npm 
export NPM_CONFIG_OFFICIAL_REGISTRY_TOKEN=""
