# zinit install
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
                mkdir -p "$(dirname $ZINIT_HOME)"
                git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"
zinit ice depth=1; 

# BREW PATH
if [ "$(uname)" = "Darwin" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)" # macOS Homebrew path
fi

# Add in zsh-plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found

# Load completions
autoload -U compinit && compinit

zinit cdreplay -q

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# History
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

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# GO
if [ "$(uname)" = "Darwin" ]; then
    export PATH=$PATH:/usr/local/go/bin
else
    export PATH=$PATH:/usr/local/go/bin
fi

export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

export PATH=$PATH:~/Bin
<<<<<<< HEAD
export AWS_CLI_AUTO_PROMPT=on
export PATH=$PATH:~/.local/bin

# Aliases
alias ls="eza --color=always --long --git --icons=always" # Removed duplicate alias for 'ls'
alias k="kubectl"
alias cat="bat"
alias man="tldr"
alias cd="z"
alias du="dust"
alias grep="rg"
alias ping="gping"
alias top="btm"
alias htop="btm"
alias tree="eza"

# Shell integrations
source <(fzf --zsh)
. "$HOME/.cargo/env"
eval "$(zoxide init zsh)"
eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh/base.toml)"

# Ensure fzf.zsh is sourced if it exists
[ -f ~/Bin/.fzf/.fzf.zsh ] && source ~/Bin/.fzf/.fzf.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(atuin init zsh)"
