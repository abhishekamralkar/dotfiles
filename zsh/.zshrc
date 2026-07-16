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
# Plugins (Order: completions -> suggestions -> tab -> highlight)
# ============================================================================
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
zinit light zsh-users/zsh-syntax-highlighting

# ============================================================================
# Oh-My-Zsh Plugins (Snippets)
# ============================================================================
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx

# ============================================================================
# Completions & Styling
# ============================================================================
autoload -U compinit && compinit
zinit cdreplay -q

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/compcache"
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza -1 --color=always $realpath'

# ============================================================================
# Keybindings
# ============================================================================
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# ============================================================================
# Environment & Path
# ============================================================================
export GOPATH=$HOME/go
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin:~/bin:~/.local/bin:~/.opencode/bin:~/.local/bin/claude
export AWS_CLI_AUTO_PROMPT=on

# History (Atuin will take over, but we keep these for fallback)
HISTSIZE=100000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
setopt appendhistory sharehistory hist_ignore_space hist_ignore_all_dups
setopt inc_append_history extended_history hist_expire_dups_first hist_verify

# Default editor
export EDITOR='vim'
export VISUAL="$EDITOR"

# ============================================================================
# --- Modern Rust Replacements & Aliases ---
# ============================================================================

# eza (Modern ls)
if command -v eza >/dev/null; then
  alias ls='eza --icons --group-directories-first'
  alias ll='eza -lh --icons --git --group-directories-first'
  alias lt='eza --tree --level=2 --icons'
  alias tree="eza --tree --icons"
fi

# bat (Modern cat)
if command -v bat >/dev/null; then
  alias cat='bat --style=plain'
  alias bathelp='bat --plain --language=help'
  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
fi

# Search & Disk (rg, fd, dust)
alias find='fd'
alias grep='rg'
alias du='dust'

# System Monitoring & Utilities
alias k="kubectl"
alias man="tldr"
alias ping="gping"
alias top="btm"
alias htop="btm"

# ============================================================================
# Shell Integrations (Initializations)
# ============================================================================

# Cargo (Rust)
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

# Zoxide (Smarter cd)
if command -v zoxide >/dev/null; then
  eval "$(zoxide init zsh)"
  alias cd='z'
  alias zi='z -i'
fi

# Atuin (Magic Shell History)
if command -v atuin >/dev/null; then
  eval "$(atuin init zsh)"
fi

# FZF
if command -v fzf >/dev/null; then
  if fzf --zsh >/dev/null 2>&1; then
    eval "$(fzf --zsh)"
  else
    [ -f /usr/share/doc/fzf/examples/key-bindings.zsh ] && source /usr/share/doc/fzf/examples/key-bindings.zsh
    [ -f /usr/share/doc/fzf/examples/completion.zsh ] && source /usr/share/doc/fzf/examples/completion.zsh
  fi
fi

# Oh My Posh (Prompt) - Keep this at the very end
eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh/base.toml)"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
eval "$(direnv hook zsh)"
