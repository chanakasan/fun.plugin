#!/bin/bash

h_cli_main() {
  cat ~/.bash_history | \
  nl | \
  tac | \
  fzf --height 1 \
  --prompt "search commands> " | \
  awk '{ $1=""; print substr($0,2) }' | \
  # xargs -I {} echo "<{}>"
  xargs -I {} bash -c "{}"
}
