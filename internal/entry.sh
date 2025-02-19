nx_fun_root="$HOME/dotfiles/paks/fun-cli.pak"

export PATH=$nx_fun_root/bin:$PATH

for f in $nx_fun_root/internal/entrypoints/*.sh; do
  if [ -f "$f" ]; then
      source "$f"
  fi
done
