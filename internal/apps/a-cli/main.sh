#!/bin/bash

debug_on=

a_cli_main () {
  echo "=> create alias"
  local alias_command="$(get_command_from_history)"
  local alias_value="$(get_user_input)"
  dumpvar alias_value
  dumpvar alias_command
  loginfo alias "$alias_value"="$alias_command"
  alias "$alias_value"="$alias_command"
  echo done
}

loginfo() {
  if [ -z "$debug_on" ]; then
    return
  fi
  echo "$*"
}

get_user_input() {
  local output_str=""
  while [[ -z $output_str ]]; do
    read -p "alias: " output_str
  done
  echo $output_str
}

get_command_from_history() {
  cat ~/.bash_history | \
  nl | \
  tac | \
  fzf --tmux \
  --prompt "select from history> " | \
  awk '{ $1=""; print substr($0,2) }'
}

dumpvar() {
  if [ -z "$debug_on" ]; then
    return
  fi
  echo "$1: <${!1}>"
}