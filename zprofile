# Source global zprofile if it exists
if [ -z $PREFIX ]; then
    [ -f $PREFIX/etc/zsh/profile ] && . $PREFIX/etc/zsh/profile
else
    [ -f /etc/zsh/profile ] && . /etc/zsh/profile
fi

# Source global profile
if [ -z $PREFIX ]; then
    [ -f $PREFIX/etc/profile ] && . $PREFIX/etc/profile
else
    [ -f /etc/profile ] && . /etc/profile
fi

# Guix things
if [ -z $(command -v guix) ]; then
    eval "$(guix package --search-paths -p $HOME/.config/guix/current -p $HOME/.guix-profile -p /run/current-system/profile)"

    export PATH=/run/setuid-programs:$PATH
fi
