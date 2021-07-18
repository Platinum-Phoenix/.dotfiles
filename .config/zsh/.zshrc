fpath+="${XDG_CONFIG_HOME:-$HOME/.config}/zfunc"
autoload -U colors
colors

# My Prompt: [user@host ~/dir]$
PROMPT="%B%{$fg[magenta]%}[%{$fg[cyan]%}%n%{$fg[white]%}@%{$fg[green]%}%M %{$fg[blue]%}%~%{$fg[magenta]%}]%b%(?.%f.%B%{$fg[red]%})$%f%b " 
# cd into directories by typing their name
setopt autocd 
stty stop undef
setopt interactive_comments

HISTSIZE=10000
SAVEHIST=10000
HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history"

if [ -f "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/aliases" ]; then 
	source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/aliases"
fi

if [ -f "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/shortcuts" ]; then
	source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/shortcuts"
fi

if [ -f "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/profile" ]; then
	source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/profile"
fi

# Basic auto/tab complete:
if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
fi

autoload -Uz compinit
zstyle ':completion:*' completer _complete _ignored
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-/]=* r:|=*'
zstyle :compinstall filename '${XDG_CONFIG_HOME:-$HOME/.config/zsh/.zshrc'
zmodload zsh/complist
compinit

CASE_SENSITIVE="false"
# Include hidden files.
_comp_options+=(globdots)

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

source "${XDG_DATA_HOME:-$HOME/.local/share}/fsh/fast-syntax-highlighting.plugin.zsh"
