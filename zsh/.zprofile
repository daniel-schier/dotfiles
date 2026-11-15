# Homebrew (sets HOMEBREW_PREFIX, used throughout .zshrc)
eval "$(/opt/homebrew/bin/brew shellenv zsh)"
export HOMEBREW_NO_ENV_HINTS=1

# Docker Desktop
export PATH="$PATH:$HOME/.docker/bin"
