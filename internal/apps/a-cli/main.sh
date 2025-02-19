#!/bin/bash

debug_on=1

a_cli_main () {
  echo "=> create alias"
  local alias_command="$(get_command_from_history)"
}

get_command_from_history() {
  cat ~/.bash_history | \
  nl | \
  tac | \
  fzf --tmux \
  --prompt "select from history> " | \
  awk '{ $1=""; print substr($0,2) }'
}