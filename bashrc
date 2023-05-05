# 终端类型判断
if [[ "$TERM" == "dumb" ]]; then
    return
fi

# 别名
alias vim="nvim"

# 函数
if command -v guix &> /dev/null; then
    system-reconfig() {
        if [ -z $1 ]; then
            echo "Need configuration name to reconfigure system."
            return 1
        fi
        sudo guix system reconfigure -L $HOME/config $HOME/config/$USER/system/$1.scm
    }
    home-reconfig() {
        guix home reconfigure -L $HOME/config $HOME/config/$USER/home.scm
    }
    deploy-machine() {
        guix deploy -L $HOME/config $HOME/config/deploy.scm
    }
fi
