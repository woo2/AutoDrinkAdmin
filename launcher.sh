# AutoDrinkAdmin launcher script
# launcher.sh
#
# Launcher should be run from whatever rc script is being used
# to start ada on boot.
#
# Paul Ugolini <github.com/woo2>
# Marc Billow <github.com/mbillow> (Original Script)

#!/bin/bash

# if test is present, remove it. It is from the last run. 

# Enter test mode.
echo "test" > test

# cd to the ADA directory, since we may be operating in a different dir
cd /home/pi/AutoDrinkAdmin/

echo "Starting AutoDrinkAdmin GUI:"
echo  "-----------"
git pull
echo  "----------"
# Show the current version. git log only shows last commit (-1)
git log -1
echo -e "-----------\n"

# Run the python GUI script
python gui.py
