#!/bin/bash
COMPILED_PATH="./.compiled"

# Run script as super user
if [ $EUID != 0 ]; then
    sudo "$0" "$@"
    exit $?
fi

# Compile all scripts
rm -f $COMPILED_PATH || true
find ./scripts -maxdepth 1 -type f | while read SCRIPT_PATH; do
  printf "# START OF ${SCRIPT_PATH}\n$(cat $SCRIPT_PATH)\n# END OF ${SCRIPT_PATH}\n" >> $COMPILED_PATH
done

# Run compiled script
bash $COMPILED_PATH
BASH_RESULT=$?

# Clear
rm -f $COMPILED_PATH || true
exit $BASH_RESULT

# END OF FILE