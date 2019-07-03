# Daily Shells Stroparo

## Install Daily Shells and this plugin

```bash
{
bash -c "$(curl -LSf "https://raw.githubusercontent.com/stroparo/ds/master/setup.sh" \
  || curl -LSf "https://bitbucket.org/stroparo/ds/raw/master/setup.sh")"
. ~/.ds/ds.sh
dsplugin.sh "stroparo@bitbucket.org/stroparo/ds-stroparo" \
  || dsplugin.sh "stroparo@github.com/stroparo/ds-stroparo"
dsload
}

```

