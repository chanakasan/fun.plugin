#!/bin/bash

debug_on=1

source $nx_fun_cli_root/.internal/apps/s-cli/utils.sh

s_cli_main() {
  local script_path=$nx_fun_cli_root/userland/script
  local main_cmd="run $*"
  local user_input="$*"
  local normalized_key=$(create_key "$user_input")
  log user_input: $user_input
  log normalized_key: $normalized_key
  exit_if_empty_args $1
  run_script_if_found $normalized_key
  show_not_found
}

create_key() {
  local key="$1"
  key=${key//_/}
  key=${key//-/}
  key=${key// /}
  echo $key
}

run_script_if_found() {
  local base_path=$nx_fun_cli_root/userland/script
  if [ ! -d $base_path ]; then
    return 1
  fi
  build_files_index $base_path
  local key="$1"
  local file="${files_index[$key]}"
  log input key: $key
  log matched file: $file
  log_line
  if [ -f "$file" ]; then
    bash "$file"
    exit $?
  else
    return
  fi
}

build_files_index() {
  local basepath="$1"
  exit_if_empty_args $basepath
  log "=> build_files_index"
  declare -g -A files_index
  while IFS= read -r -d '' file; do
    filename=$(basename -s.sh "$file")
    key=$(create_key "$filename")
    files_index["$key"]=$file
  done < <(find $basepath  -type f -name "*.sh" -print0)
  print_files_index
}

print_files_index() {
  if [ -z "$debug_on" ]; then
    return
  fi
  echo "---------------------------------"
  echo "files_index:"
  for key in "${!files_index[@]}"; do
    echo "$key => ${files_index[$key]}"
  done
  echo "---------------------------------"
}
