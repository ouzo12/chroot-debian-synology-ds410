sh /etc/profile

if tput colors >&-
then
   export PS1='$(tput bold)$(tput setab 1)$(tput setaf 7)DEBIAN (\w)#$(tput sgr0) '
else
   export PS1='DEBIAN (\w)# '
fi

export LS_OPTIONS='--color=auto'
eval "$(dircolors)"
alias ls='ls $LS_OPTIONS'
alias ll='ls $LS_OPTIONS -l'
alias l='ls $LS_OPTIONS -lA'
