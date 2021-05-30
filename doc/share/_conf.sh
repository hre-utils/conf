#!/bin/bash
# CLI completion for `conf`.

DATABASE="${XDG_CONFIG_HOME:-$HOME/.config}/hre-utils/conf/database"

function _CONF_COMP_TAGS {
   local cur="${COMP_WORDS[$COMP_CWORD]}"
   local prev="${COMP_WORDS[$COMP_CWORD - 1]}"

   local -a tags=( $(awk '{print $3}' "$DATABASE") )
   COMPREPLY=( $(compgen -W "${names[*]//,/ }" -- "$cur") )
}


function _CONF_COMP_NAMES {
   local cur="${COMP_WORDS[$COMP_CWORD]}"
   local prev="${COMP_WORDS[$COMP_CWORD - 1]}"

   local -a names=( $(awk '{print $2}' "$DATABASE") )
   COMPREPLY=( $(compgen -W "${names[*]//,/ }" -- "$cur") )
}


function _CONF_COMP_MAIN {
   local cur="${COMP_WORDS[$COMP_CWORD]}"
   local prev="${COMP_WORDS[$COMP_CWORD - 1]}"

   local -a options=(
      --add
      --tag
      --debug
      --ls
      --lst
      --column
      --sort
      --edit
   )

   if [[ "$cur" =~ ^- ]] ; then
      COMPREPLY=( $(compgen -W "${options[*]}" -- "$cur") )
   else
      case $prev in
         --add)
               COMPREPLY=( $(compgen -f -- "$cur") )
               ;;

         --edit)
               COMPREPLY=( $(compgen -W 'config database' -- "$cur") )
               ;;

         --tag)
               _CONF_COMP_TAGS
               ;;

         --lst)
               _CONF_COMP_TAGS
               ;;

         --column|--debug|--ls|--sort)
               COMPREPLY=()
               ;;

         *)
               _CONF_COMP_NAMES
               ;;
      esac
   fi
}


complete -F _CONF_COMP_MAIN conf
