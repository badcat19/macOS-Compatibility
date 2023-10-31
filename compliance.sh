#!/bin/bash

# Determine the model and year:
DEIVCE_IDENTIFIER=$(sysctl hw.model | awk '{print $NF}')
DEVICE_MODEL_CURL=$(curl -s "https://raw.githubusercontent.com/badcat19/macOS-Compatibility/main/models.txt" | grep -w "$DEIVCE_IDENTIFIER")
if [[ $DEVICE_MODEL_CURL = *"("*")"* ]]; then
  DEVICE_MODEL=$( echo $DEVICE_MODEL_CURL | cut -f1 -d"|" )
  DEVICE_YEAR=$( echo "$DEVICE_MODEL" | grep -o -E '[0-9][0-9][0-9][0-9]' )
else
  DEVICE_MODEL="Unknown Mac"
  DEVICE_YEAR="N/A"
fi

#echo $DEVICE_MODEL

# Verify if device model is compatible with N-1
DEVICE_COMPAT=$(curl -s "https://raw.githubusercontent.com/badcat19/macOS-Compatibility/main/device_models.txt" | grep -w "$DEVICE_MODEL")

#echo $DEVICE_COMPAT

if [[ -z $DEVICE_COMPAT ]]; then
  echo "Device NOT compatible with macOS Ventura"
else
  echo "Device compatible with macOS Ventura"
fi

exit 0
