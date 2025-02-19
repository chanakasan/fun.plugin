nx_fun_root="$HOME/dotfiles/paks/fun-cli.pak"

export PATH=$PATH:$nx_fun_root/bin

for f in $nx_fun_root/src/entrypoints/*.sh; do
  if [ -f "$f" ]; then
      source "$f"
  fi
done
