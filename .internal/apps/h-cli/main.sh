#!/bin/bash

h_cli_main2() {
  tac ~/.bash_history | \
  fzf --reverse --height 50% | \
  xargs -I {} bash -c "{}"
}

h_cli_main() {
  cat ~/.bash_history | \
  nl | \
  tac | \
  fzf --nth=2 --prompt "search commands> " | \
  awk '{ $1=""; print substr($0,2) }' | \
  xargs -I {} bash -c "{}"
}
