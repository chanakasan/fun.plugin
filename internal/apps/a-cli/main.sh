#!/bin/bash

debug_on=1

source $nx_fun_cli_root/internal/apps/a-cli/utils.sh

a_cli_main () {
  echo "=> create alias"
  local alias_command="$(get_command_from_history)"
  

  read -p "alias? (d) " alias_value
  if [[ -z "$alias_value" ]]; then
    alias_value=$default_value
  fi

  while true; do
    if [[ -z $args ]]; then
      read -e -p "alias $alias_value: " input
    else
      read -e -p "alias $alias_value: $args " input
    fi

    if [[ "$input" == "\`" ]]; then
        break
    fi

    #<< append args
    if [[ -z $input ]]; then
      : # do nothing
    elif [[ -z $args ]]; then
      args="${input}"
    elif [[ "${input: -1}" == "/" ]]; then
      args="${args}${input}"
    elif [[ "${input: -1}" == "+" ]]; then
      args="${args}${input%+}"
    else
      args="${args} ${input}"
    fi
    #>>

    n=2
  done

  if [[ -n $args ]]; then
    alias $alias_value="${args}"
  else
    echo Aborted
  fi
}

get_command_from_history() {
  cat ~/.bash_history | \
  nl | \
  tac | \
  fzf --tmux \
  --prompt "select from history> " | \
  awk '{ $1=""; print substr($0,2) }'
}