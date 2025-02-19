#!/bin/bash

debug_on=

a_cli_main () {
  echo "=> create alias"
  local alias_command="$(get_command_input)"
  local alias_value="$(get_alias_input)"
  dumpvar alias_value
  dumpvar alias_command
  loginfo alias "$alias_value"="$alias_command"
  alias "$alias_value"="$alias_command"
  echo done
}

get_command_input() {
  local output_str=""
  while [[ -z $output_str ]]; do
    read -e -p "command: " output_str
  done

  while ! ends_with_endchar "$output_str"; do
    # read new input
    read -e -p "command: $output_str: " input
    # append new input
    output_str="${output_str} ${input}"
  done

  cmd_str=$(format_cmd_str "$output_str")
  echo $cmd_str
}

get_alias_input() {
  local output_str="$1"
  while ! valid_user_input "$output_str"; do
    read -p "alias: " output_str
  done
  echo $output_str
}

format_cmd_str() {
  local output="$1"
  output="${output%\`}"
  output="${output%\\ \`}"
  echo $output
}

valid_user_input() {
  local invalid_chars=(a h c s)
  local input="$1"
  if [[ -z $input ]]; then
    return 1
  fi
  for char in "${invalid_chars[@]}"; do
    if [[ $input == *"$char"* ]]; then
      return 1
    fi
  done
  return 0
}

ends_with_endchar() {
  local str="$1"
  if [[ "${str: -1}" == "\`" ]]; then
    return 0
  else
    return 1
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

loginfo() {
  if [ -z "$debug_on" ]; then
    return
  fi
  echo "$*"
}
dumpvar() {
  if [ -z "$debug_on" ]; then
    return
  fi
  echo "$1: <${!1}>"
}