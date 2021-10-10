# Daily Shells Stroparo


## Install scripting library and this plugin

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



Follow [the DRYSL installation as well as the plugin installation section in its readme instructions](https://github.com/stroparo/ds/blob/master/README.md).
