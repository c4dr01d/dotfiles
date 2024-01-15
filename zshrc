# History
HISTFILE=$XDG_DATA_HOME/zsh/history
HISTSIZE=10000
SAVEHIST=10000
setopt incappendhistory
setopt sharehistory
setopt appendhistory
setopt histignorespace

# Init and completion
zstyle :compinstall filename "$ZDOTDIR/.zshrc"
autoload -U zrecompile
autoload -U compinit && compinit
setopt no_completealiases
setopt autopushd
setopt pushdminus

autoload -U colors && colors


setopt correctall

# Colors
[[ -r $XDG_CONFIG_HOME/dircolors/dircolors ]] && {
    eval $(dircolors -b $XDG_CONFIG_HOME/dircolors/dircolors)
}

zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 2 numeric

zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}¬
zstyle ':completion:*:cache-path' $XDG_CACHE_HOME/zsh/zcompcache

zstyle ':completion:*:processes' command 'ps -ax'
zstyle ':completion:*:processes-names' command 'ps -aeo comm='
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:killall:*:processes-names' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:*:killall:*' menu yes select

zstyle ':completion:*:functions' ignored-patterns '_*'

autoload -U url-quote-magic
zle -N self-insert url-quote-magic

# Options
setopt extended_history
setopt hist_ignore_dups
setopt hist_find_no_dups
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt hist_verify
setopt share_history
setopt correct
setopt autocd
setopt extendedglob
setopt interactivecomments
setopt noclobber
setopt autoparamslash
setopt autoremoveslash

# Keybindings
bindkey -v
zmodload zsh/terminfo

# Source other files
for file in $XDG_CONFIG_HOME/zsh/{aliases,functions/init.zsh,prompt}; do
    . $file || { print "$file: cannot source file" && setopt warncreateglobal }
done

# Plugins
plugins=(
    romkatv/zsh-defer
    zsh-users/zsh-autosuggestions
    zdharma-continuum/fast-syntax-highlighting
)

plugin-clone $plugins
plugin-load $plugins
