#!/bin/sh

login() {
  ($(gpg -q --decrypt ~/.shell-secrets/$1.gpg) && SECRET_LOGIN="$SECRET_LOGIN$1 " bash -l)
}

_login() {
  SECRETS=$(basename -a -s .gpg ~/.shell-secrets/*.gpg)
  COMPREPLY=($(compgen -W "$SECRETS" -- ${COMP_WORDS[COMP_CWORD]}))
  return 0
}

complete -F _login login
