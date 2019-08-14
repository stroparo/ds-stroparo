if (uname -a | grep -i -q linux) \
  && ((cd ; git config -l | grep -q 'cred.*store') \
      || (ssh-add -l 2>/dev/null | egrep -i -q -w 'dsa|rsa|ssh'))
then
  export GITR_PARALLEL=true
else
  export GITR_PARALLEL=false
fi
