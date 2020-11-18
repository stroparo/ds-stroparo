#!/usr/bin/env bash

PROGNAME="bluetoothwinmouse.sh"

BT_DELL_MOUSE_MAC_ADDR="CA:16:1D:C2:FC:89"
BT_DELL_MOUSE_MAC_ADDR_CHNTPW="ca161dc2fc89"

WINDIR="$1"

cd "${WINDIR:=/mnt/c/Windows}/System32/config"
if [ "$PWD" != "${WINDIR}/System32/config" ] ; then
  echo "${PROGNAME:+$PROGNAME: }FATAL: Could not cd to '${WINDIR}/System32/config'." 1>&2
  exit 1
fi

# Try CurrentControlSet or ControlSet001
BT_MAC_KEY="$(chntpw -e SYSTEM <<EOF | grep '^  [<]............[>]' | grep -o '[0-9a-f]*'
ls \ControlSet001\Services\BTHPORT\Parameters\Keys
q
EOF
)"

echo
echo "Bluetooth MAC Address: '${BT_MAC_KEY}'"
echo

export BT_MAC_KEY_FILENAME="/var/lib/bluetooth/$(echo "${BT_MAC_KEY}" | tr '[[:lower:]]' '[[:upper:]]' | sed -e 's/../&:/g' -e 's/:$//')"


# #############################################################################
# Find composed key bluetooth device

btdevice="$(chntpw -e SYSTEM <<EOF | grep '^  [<]............[>]' | head -1 | grep -o '[0-9a-f]*'
ls \ControlSet001\Services\BTHPORT\Parameters\Keys\\${BT_MAC_KEY}
q
EOF
)"

if [ "${btdevice}" != "${BT_DELL_MOUSE_MAC_ADDR_CHNTPW}" ] ; then
  echo "${PROGNAME:+$PROGNAME: }FATAL: bluetooth device id not as expected. Please check the devices found..." 1>&2
  echo "${PROGNAME:+$PROGNAME: }FATAL: ...below and update this script's global variable accordingly." 1>&2
  # List bluetooth devices:
  chntpw -e SYSTEM <<EOF
ls \ControlSet001\Services\BTHPORT\Parameters\Keys\\${BT_MAC_KEY}
q
EOF
  exit 1
fi

echo "BT DEVICE: '$btdevice'"

export btdevicefilename="${BT_MAC_KEY_FILENAME}/$(echo "${btdevice}" | tr '[[:lower:]]' '[[:upper:]]' | sed -e 's/../&:/g' -e 's/:$//')"

# #############################################################################
# Get authorized BT sync keys

export BT_DELL_MOUSE_KEY_LTK="$(chntpw -e SYSTEM <<EOF | egrep -o '([0-9A-F]{2} ){16}' | tr -d ' '
hex \ControlSet001\Services\BTHPORT\Parameters\Keys\\${BT_MAC_KEY}\\${btdevice}\\LTK
q
EOF
)"

export BT_DELL_MOUSE_KEY_IRK="$(chntpw -e SYSTEM <<EOF | egrep -o '([0-9A-F]{2} ){16}' | tr -d ' '
hex \ControlSet001\Services\BTHPORT\Parameters\Keys\\${BT_MAC_KEY}\\${btdevice}\\IRK
q
EOF
)"

echo
sudo ls -l "${btdevicefilename}/info"
echo
echo "Substitute the following keys in '${btdevicefilename}/info':"
echo "LTK=${BT_DELL_MOUSE_KEY_LTK}"
echo "IRK=${BT_DELL_MOUSE_KEY_IRK}"
echo
echo 'Opening up bt info file for editing with the above keys...'
echo 'Press ENTER when ready...'
read dummy
sudo vi "${btdevicefilename}/info"

# TODO automate the above vi call with these but properly for each section (LTK and IRK) of the info file:
# sudo sed -i -e "s/^Key=.*$/Key=${BT_DELL_MOUSE_KEY_LTK}/" "${btdevicefilename}/info"
# sudo sed -i -e "s/^Key=.*$/Key=${BT_DELL_MOUSE_KEY_IRK}/" "${btdevicefilename}/info"

# #############################################################################
