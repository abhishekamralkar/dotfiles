# ============================================================================
# Zinit Plugin Manager Setup
# ============================================================================
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname "$ZINIT_HOME")"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh" 


# ============================================================================
# Homebrew (macOS)
# ============================================================================
if [[ "$(uname)" == "Darwin" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# ============================================================================
# Plugins
# ============================================================================
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# ============================================================================
# Oh-My-Zsh Plugins (Snippets)
# ============================================================================
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found

# ============================================================================
# Completions
# ============================================================================
autoload -U compinit && compinit
zinit cdreplay -q

# ============================================================================
# Keybindings
# ============================================================================
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# ============================================================================
# History
# ============================================================================
HISTSIZE=100000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# ============================================================================
# Completion Styling
# ============================================================================
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# ============================================================================
# Environment Variables - Programming Languages
# ============================================================================
# Go
export GOPATH=$HOME/go
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin

# ============================================================================
# Environment Variables - User Paths
# ============================================================================
export PATH=$PATH:~/Bin
export PATH=$PATH:~/.local/bin
export PATH=$PATH:/home/aaa/.opencode/bin
export AWS_CLI_AUTO_PROMPT=on

# ============================================================================
# Aliases - Navigation & File Operations
# ============================================================================
alias ls="eza --color=always --long --git --icons=always"
alias tree="eza"
alias cat="bat"
alias grep="rg"
alias du="dust"

# ============================================================================
# Aliases - System
# ============================================================================
alias k="kubectl"
alias man="tldr"
alias ping="gping"
alias top="btm"
alias htop="btm"
alias cd="z"

# ============================================================================
# Shell Integrations
# ============================================================================
# Cargo (Rust)
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

# Zoxide (directory jumping)
eval "$(zoxide init zsh)"

# Oh My Posh (prompt)
eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh/base.toml)"

# FZF (fuzzy finder)
eval "$(fzf --zsh)" 2>/dev/null || true

# Atuin (shell history)
eval "$(atuin init zsh)"
