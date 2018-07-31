# Daily Shells Stroparo

## Clone this & provision environment

```bash
mv -f ~/.ds-stroparo ~/.ds-stroparo.$(date '+%Y-%m-%d-%OH-%OM-%OS')
git clone --depth=1 "https://stroparo@bitbucket.org/stroparo/ds-stroparo.git" ~/.ds-stroparo \
  || git clone --depth=1 "https://stroparo@github.com/stroparo/ds-stroparo.git" ~/.ds-stroparo
bash ~/.ds-stroparo/recipes/provision-ds-stroparo.sh

```

## As a Daily Shells plugin

```bash
bash -c "$(curl -LSf "https://raw.githubusercontent.com/stroparo/ds/master/setup.sh" \
  || curl -LSf "https://bitbucket.org/stroparo/ds/raw/master/setup.sh")"
${DS_LOADED:-false} || . ~/.ds/ds.sh
dsplugin.sh "stroparo@bitbucket.org/stroparo/ds-stroparo" \
  || dsplugin.sh "stroparo@github.com/stroparo/ds-stroparo"
dsload

```

