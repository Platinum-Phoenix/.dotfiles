fpath+=$HOME/.zsh/pure
bindkey -v

export EDITOR='vim'

autoload -U promptinit; promptinit
prompt pure

alias code="cd ~/Documents/Code"
export GITHUB=https://github.com/Platinum-Phoenix

# Disasemble an executable
function dasm() {
    if [ $2 ]; then
        otool -tvVX $1 > $2 
    else
        otool -tvVX $1 > "$(basename $1).s"
    fi
}

function preview() {
	open -a Preview $*
}

# iTerm2 stuff
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# zsh syntax highlighting
source $HOME/.zsh/highlighting/zsh-syntax-highlighting.zsh
