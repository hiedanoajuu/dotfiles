# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1500

setopt autocd extendedglob notify
bindkey -v

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/hiedanoajuu/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

PROMPT='[%F{green}%n@%m%f %F{blue}%~%f]$ '
LS_COLORS="di=1;34:ln=1;36:so=1;31:pi=1;33:ex=1;32:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43:or=01;31:mi=01;30;41"

# Environment
alias ll='ls -lha'
alias la='ls -a'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias mkdir='mkdir -p'

alias dogecoind='dogecoind -daemon -prune=2200'

lfcd() {
    lf -last-dir-path ~/.config/lf/last_dir
    cd "$(sed -n '1p' ~/.config/lf/last_dir)"
}

alias lf='lfcd'
alias vi='nvim'

# History
setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt share_history

# Completion
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' rehash true
zstyle ':completion:*' completer _expand _complete _correct

setopt correct
setopt auto_pushd
setopt pushd_ignore_dups
setopt interactive_comments

hash -d pro=~/Projects
hash -d doc=~/Documents
hash -d down=~/Downloads

# Security
setopt no_clobber

# Cursor toggle
function zle-keymap-select {
  case $KEYMAP in
    vicmd)
      echo -ne '\e[2 q'  # block
      ;;
    *)
      echo -ne '\e[6 q'  # beam
      ;;
  esac
}

function zle-line-init {
  echo -ne '\e[6 q'
}

preexec() {
  echo -ne '\e[2 q'
}

zle -N zle-keymap-select
zle -N zle-line-init

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone git@github.com:zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust \

### End of Zinit's installer chunk
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
zinit light agkozak/zsh-z

bindkey '^ ' autosuggest-accept

