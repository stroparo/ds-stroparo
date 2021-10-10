# DRYSL plugin - Stroparo

## Install scripting library and this plugin

Follow [the DRYSL installation as well as the plugin installation section in its readme instructions](https://github.com/stroparo/ds/blob/master/README.md).

Commands in such sections are also here for convenience but might be outdated (resort to the document linked to above, in this case):

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



