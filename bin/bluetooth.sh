#!/bin/bash

dbus-send --system --type=method_call --print-reply --dest=org.bluez /org/bluez/hci0 org.bluez.Adapter.RemoveBonding string:00:13:17:04:AE:7A

sudo echo enable >  /proc/acpi/ibm/bluetooth
sudo /etc/init.d/bluetooth restart


/usr/bin/passkey-agent 0000 00:13:17:04:AE:7A
dbus-send --system --type=method_call --print-reply --dest=org.bluez /org/bluez/hci0 org.bluez.Adapter.CreateBonding string:00:13:17:04:AE:7A

#RemoveBonding

