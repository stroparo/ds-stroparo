# Custom DIFFPROG global:
if which meld >/dev/null 2>&1 ; then
  export DIFFPROG="meld"
elif which kdiff3 >/dev/null 2>&1 ; then
  export DIFFPROG="kdiff3"
elif (uname -a | egrep -i -q "cygwin|mingw|msys|win32|windows") ; then
  if [ -x "${MYOPT}/meld/meld" ] ; then
    export DIFFPROG="${MYOPT}/meld/meld"
  elif [ -x "${MYOPT}/kdiff3/kdiff3" ] ; then
    export DIFFPROG="${MYOPT}/kdiff3/kdiff3"
  elif [ -f "${MOUNTS_PREFIX}/c/Program Files (x86)/WinMerge/WinMergeU.exe" ] ; then
    export DIFFPROG="${MOUNTS_PREFIX}/c/Program Files (x86)/WinMerge/WinMergeU.exe"
  fi
fi
