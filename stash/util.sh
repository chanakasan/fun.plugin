is_endchar() {
  local str="$1"
  if [[ "$str" == "\`" ]]; then
    return 0
  else
    return 1
  fi
}

trim_str() {
  input="$1"
  input="${input#"${input%%[![:space:]]*}"}"
  input="${input%"${input##*[![:space:]]}"}"
  echo $input
}


ends_with_pathchar() {
  local str="$1"
  if [[ "${str: -1}" == "/" ]]; then
    return 0
  else
    return 1
  fi
}

ends_with_plus() {
  local str="$1"
  if [[ "${str: -1}" == "/" ]]; then
    return 0
  else
    return 1
  fi
}
