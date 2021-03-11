alias code=code-insiders
GITHUB=https://github.com/Platinum-Phoenix

# Disasemble an executable
dasm() {
    if [ $2 ]; then
        otool -tvVX $1 > $2 
    else
        otool -tvVX $1 > "$(basename $1).s"
    fi
}