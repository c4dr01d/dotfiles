for file in ${XDG_CONFIG_HOME}/zsh/functions/{extract.zsh,plugin.zsh}; do
    . $file || { print "$file: cannot source file" && setopt warncreateglobal }
done
