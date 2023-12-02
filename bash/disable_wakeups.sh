#!/bin/bash

for x in $(grep enabled /proc/acpi/wakeup | cut -f1 | grep -v PBTN)
do
  echo $x | sudo tee /proc/acpi/wakeup
done