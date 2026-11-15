# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=5000
setopt appendhistory
setopt sharehistory
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# local bin
export PATH="$HOME/.local/bin:$PATH"

# Go
export PATH="$HOME/go/bin:$PATH"

# Local secrets (not managed by this repository).
[[ -r ~/.config/zsh/secrets.zsh ]] && source ~/.config/zsh/secrets.zsh

# Aliases
alias vi="vim"
alias grep="grep --color=auto"
alias ls="ls --color"
alias ll="ls -l"
alias la="ls -la"

# Homebrew completions (must be before compinit)
fpath=("$HOMEBREW_PREFIX/share/zsh/site-functions" $fpath)

# Autocomplete
autoload -U compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Syntax highlighting (must be sourced after compinit)
_fsh="$HOMEBREW_PREFIX/opt/zsh-fast-syntax-highlighting/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"
[[ -r "$_fsh" ]] && source "$_fsh"
unset _fsh

# Mise
command -v mise >/dev/null && eval "$(mise activate zsh)"

# Starship
command -v starship >/dev/null && eval "$(starship init zsh)"

# Peep
command -v peep >/dev/null && peep
