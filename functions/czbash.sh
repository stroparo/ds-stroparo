czbash () {
  [[ $0 = *bash* ]] && set -b
  set -o vi
  export EDITOR=vim
  export PS1='[\u@\h \W $?]\$ '
}
