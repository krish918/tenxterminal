export PATH="$PATH:/opt/nvim/bin"
export PATH="$PATH:$HOME/.fzf/bin/"
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Created by newuser for 5.8.1
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

zinit ice depth=1; zinit light romkatv/powerlevel10k

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab 

# Adding Oh My Zsh Plugins as snippet
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::kubectl
zinit snippet OMZP::command-not-found

autoload -Uz compinit && compinit
# trying to make case insensitive completion work - not working
zmodload -i zsh/complist

zinit cdreplay -q

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Setting Aliases
alias ls='ls --color'
alias ll='ls --color -l'
alias nv='nvim'
alias vim='nvim'
alias cl='clear'

# Setting keybindings for emacs
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# History Settings
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase

# Add options to seamlessly access history in any zsh terminal
setopt appendhistory
setopt sharehistory

# Do not put a command in history if started with a space
setopt hist_ignore_space

# Setting options to avoid duplicates
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_find_no_dups

# Updating Auto-Completion to be case-insensitive
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
# Remove the default completion window as we will use an fzf plugin
zstyle ':completion:*' menu no
# Show a stylized directory tree using fzf plugin while running completion using cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:ls:*' fzf-preview 'ls --color $realpath'

# Setting zsh-autosuggest configuration
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8,bold,underline"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)


# Setting edit and execute for a command
autoload -U edit-command-line
# Define a new widget for ZLE - Zsh Line Editor
zle -N edit-command-line
bindkey '^x^e' edit-command-line

# Binding keys for word forward and word backword
# Binding Alt + [ for going backword and Alt + ] for forward - one word at a time
bindkey '^[[' backward-word
bindkey '^[]' forward-word

# Shell Integration for fzf
# Fuzzy Finding Window (fzf) v0.48+ should be installed for this to work
eval "$(fzf --zsh)"

