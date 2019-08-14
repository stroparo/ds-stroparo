if [[ "$(uname -a)" = *[Ll]inux* ]] ; then

  if [ -e "${MNT_EXTRA:-/mnt/extra}"/Android ] ; then
    pathmunge -a -x "${MNT_EXTRA:-/mnt/extra}"/Android/Sdk/platform-tools
  fi

  if [ -e /opt/android-studio ] ; then
    pathmunge -a -x /opt/android-studio/bin
  fi

  if ! which studio >/dev/null 2>&1 \
    && [ -e /opt/android-studio/bin/studio.sh ]
  then
    sudo ln -s "studio.sh" "/opt/android-studio/bin/studio"
  fi
fi
