if which ag >/dev/null 2>&1 ; then
  export FZF_DEFAULT_COMMAND='ag --ignore .git --ignore "*.pyc" -g ""'
  export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"
fi
