# opam configuration
if [ -f "$HOME/.opam/opam-init/init.zsh" ]; then
  source "$HOME/.opam/opam-init/init.zsh" #> /dev/null 2> /dev/null
else
  echo "please run 'opam init' to configure your environment"
fi
