# Daily Shells Stroparo

## Install Daily Shells and this plugin

```bash
bash -c "$(curl -LSf "https://raw.githubusercontent.com/stroparo/ds/master/setup.sh" \
  || curl -LSf "https://bitbucket.org/stroparo/ds/raw/master/setup.sh")"
${DS_LOADED:-false} || . ~/.ds/ds.sh
dsplugin.sh "stroparo@bitbucket.org/stroparo/ds-stroparo" \
  || dsplugin.sh "stroparo@github.com/stroparo/ds-stroparo"
if [ $? -eq 0 ] ; then dsload ; fi

```

