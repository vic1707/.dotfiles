#!/bin/sh

# opam configuration
if [ -f "$HOME/.opam/opam-init/init.sh" ]; then
  . "$HOME/.opam/opam-init/init.sh" #> /dev/null 2> /dev/null || true
else
  echo "please run 'opam init' to configure your environment"
fi
