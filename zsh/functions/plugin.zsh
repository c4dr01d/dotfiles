: ${ZPLUGHOME:=${XDG_CACHE_HOME:-~/.cache}/zplugins}
: ${ZPLUGDIR:=${ZSH_CUSTOM:-${ZDOTDIR:-${XDG_CONFIG_HOME:-$HOME/.config}/zsh}}/plugins}
typeset -gHa _plugin_zopts=(extended_glob glob_dots no_monitor)

function plugin-clone {
  emulate -L zsh; setopt local_options $_plugin_zopts
  local repo plugdir; local -Ua repos

  for repo in ${${(M)@:#*/*}:#/*}; do
    repo=${(@j:/:)${(@s:/:)repo}[1,2]}
    [[ -e $ZPLUGHOME/$repo ]] || repos+=$repo
  done

  for repo in $repos; do
    plugdir=$ZPLUGHOME/$repo
    if [[ ! -d $plugdir ]]; then
      echo "Cloning $repo..."
      (
        command git clone -q --depth 1 --recursive --shallow-submodules \
          ${ANTIDOTE_LITE_GITURL:-https://github.com/}$repo $plugdir
        plugin-compile $plugdir
      ) &
    fi
  done
  wait
}

function plugin-load {
  source <(plugin-script $@)
}

function plugin-script {
  emulate -L zsh; setopt local_options $_plugin_zopts

  local kind
  while (( $# )); do
    case $1 in
      -k|--kind)  shift; kind=$1 ;;
      -*)         echo >&2 "Invalid argument '$1'." && return 2 ;;
      *)          break ;;
    esac
    shift
  done

  local plugin src="source" inits=()
  (( ! $+functions[zsh-defer] )) || src="zsh-defer ."
  for plugin in $@; do
    if [[ -n "$kind" ]]; then
      echo "$kind=(\$$kind $ZPLUGHOME/$plugin)"
    else
      inits=(
        {$ZPLUGDIR,$ZPLUGHOME}/$plugin/${plugin:t}.{plugin.zsh,zsh-theme,zsh,sh}(N)
        $ZPLUGHOME/$plugin/*.{plugin.zsh,zsh-theme,zsh,sh}(N)
        $ZPLUGHOME/$plugin(N)
        ${plugin}/*.{plugin.zsh,zsh-theme,zsh,sh}(N)
        ${plugin}(N)
      )
      (( $#inits )) || { echo >&2 "No plugin init found '$plugin'." && continue }
      plugin=$inits[1]
      echo "fpath=(\$fpath $plugin:h)"
      echo "$src $plugin"
      [[ "$plugin:h:t" == zsh-defer ]] && src="zsh-defer ."
    fi
  done
}

function plugin-update {
  emulate -L zsh; setopt local_options $_plugin_zopts
  local plugdir oldsha newsha
  for plugdir in $ZPLUGHOME/*/*/.git(N/); do
    plugdir=${plugdir:A:h}
    echo "Updating ${plugdir:h:t}/${plugdir:t}..."
    (
      oldsha=$(command git -C $plugdir rev-parse --short HEAD)
      command git -C $plugdir pull --quiet --ff --depth 1 --rebase --autostash
      newsha=$(command git -C $plugdir rev-parse --short HEAD)
      [[ $oldsha == $newsha ]] || echo "Plugin updated: $plugdir:t ($oldsha -> $newsha)"
    ) &
  done
  wait
  plugin-compile
  echo "Update complete."
}

function plugin-compile {
  emulate -L zsh; setopt local_options $_plugin_zopts
  autoload -Uz zrecompile
  local zfile
  for zfile in ${1:-ZPLUGHOME}/**/*.zsh{,-theme}(N); do
    [[ $zfile != */test-data/* ]] || continue
    zrecompile -pq "$zfile"
  done
}
