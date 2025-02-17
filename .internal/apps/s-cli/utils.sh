print_usage() {
  echo " Usage: @ <1> <2> <3> ..."
  echo
}

show_not_found() {
  echo " not found: <$args.sh>"
}

exit_if_empty_args() {
  if [ -z "$1" ]; then
    echo " argument required"
    print_usage
    exit 1
  fi
}

log_line() {
  log "-------------------------------"
}

log() {
  if [ -z "$debug_on" ]; then
    return
  fi
  echo " $*"
}

dvar() {
  if [ -z "$debug_on" ]; then
    return
  fi
  echo " $1: <${!1}>"
}
