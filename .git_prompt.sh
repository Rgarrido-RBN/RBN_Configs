#!/bin/bash

# COLORS #
NOCOLOR='\[\033[0m\]' # No Color
RED='\[\033[0;91m\]'
GREEN='\[\033[0;92m\]'
YELLOW='\[\033[0;93m\]'
DARK_YELLOW='\[\033[03;33m\]'
LIGHT_MARENGO='\[\033[01;36m\]'
MARENGO='\[\033[00;36m\]'
GRAY='\[\033[01;30m\]'
MAGENTA='\[\033[03;35m\]'


parse_git_branch() {
     branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
     if [ -n "$branch" ]; then     
       bool=false
       if [[ `git diff --name-only` ]]; then # changes
         if  [ "$bool" = false ]; then branch="${branch}|"; fi
          branch="${branch}*"
          bool=true
       fi
       if [[ `git diff --name-only --staged` ]]; then # staged
          if  [ "$bool" = false ]; then branch="${branch}|"; fi
          branch="${branch}+"
          bool=true
       fi
       if [[ `git ls-files --others --exclude-standar` ]]; then # non tracked
          if  [ "$bool" = false ]; then branch="${branch}|"; fi
          branch="${branch}."
          bool=true
       fi
       branch="(${branch})"
     fi
     
     echo $branch
}
