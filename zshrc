[ -f "$XDG_CONFIG_HOME/zsh/aliases" ] && . "$XDG_CONFIG_HOME/zsh/aliases"

autoload -Uz colors && colors

autoload -Uz compinit && compinit
zstyle ':completion:*' menu select # 菜单风格
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*' # 大小写敏感
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS} # 补全时显示颜色
zstyle ':completion:*' rehash true # 自动刷新补全列表
zstyle ':completion::complete:*' use-cache true # 使用补全缓存

set -o emacs # 使用Emacs按键绑定
bindkey '^[[Z' reverse-menu-complete
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search
bindkey "^P" up-line-or-search
bindkey "^N" down-line-or-search

HISTSIZE=1000
SAVEHIST=1000
export HISTFILE="$XDG_DATA_HOME"/zsh/history
setopt SHARE_HISTORY # 不同Zsh会话间共享历史
setopt APPEND_HISTORY # 历史添加行为
setopt HIST_EXPIRE_DUPS_FIRST # 存储历史记录时先删除Duplicates
setopt HIST_IGNORE_DUPS # 不存储Duplicates
setopt HIST_FIND_NO_DUPS # 搜索时忽略Duplicates
setopt HIST_REDUCE_BLANKS # 删除历史记录内的空行

# 提示符必要设定
setopt PROMPT_PERCENT
setopt PROMPT_SUBST

PROMPT='%b%F{#0b98de}%~ %f
%? %F{#fd9014}%(!.#.>) %f'
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
RPROMPT='$vcs_info_msg_0_'

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr '%F{yellow}●%f'
zstyle ':vcs_info:*' unstagedstr '%F{red}●%f'
zstyle ':vcs_info:git:*' formats '[%F{green}%b%f%c%u]'
zstyle ':vcs_info:git:*' actionformats '[%F{cyan}%b (%a)%f%c%u]'
