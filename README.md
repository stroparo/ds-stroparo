# Scripting Library - Stroparo

## Install scripting library and this plugin

Follow [this scripting library installation as well as the plugin installation section in its readme instructions](https://github.com/stroparo/sidra/blob/master/README.md).

Commands in such sections are also here for convenience but might be outdated (resort to the document linked to above, in this case):

```bash
{
bash -c "$(curl -LSf "https://raw.githubusercontent.com/stroparo/sidra/master/setup.sh" \
  || curl -LSf "https://bitbucket.org/stroparo/sidra/raw/master/setup.sh")"
. ~/.zdra/zdra.sh
zdraplugin.sh "stroparo@bitbucket.org/stroparo/ds-stroparo" \
  || zdraplugin.sh "stroparo@github.com/stroparo/ds-stroparo"
zdraload
}

```



