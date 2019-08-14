if ! (uname -a | egrep -i -q "cygwin|mingw|msys|win32|windows") ; then return ; fi

export CYGWIN="$CYGWIN winsymlinks:nativestrict"

alias exp='explorer "$(cygpath -w "$PWD")"'
alias sp='sumatrapdf'

# #############################################################################
# PATH for Windows applications

# Crypto
pathmunge -x "$(cygpath 'C:\Program Files')/TrueCrypt"
pathmunge -x "$(cygpath 'C:\Program Files')/VeraCrypt"

# Dev
pathmunge -x "${MYOPT}/opt/subl"

# Dev infra
pathmunge -x "$(cygpath 'C:')/HashiCorp/Vagrant/bin"
pathmunge -x "$(cygpath 'C:\Program Files')/Docker Toolbox/docker"
pathmunge -x "$(cygpath 'C:\Program Files')/Oracle/VirtualBox"

# Web
pathmunge -x "$(cygpath 'C:\Program Files (x86)')/Google/Chrome/Application"
pathmunge -x "$(cygpath 'C:\Program Files')/Mozilla Firefox"

# #############################################################################
