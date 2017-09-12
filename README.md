AutoDrinkAdmin
==============
## Summary

This README was last updated based on an install on a Rasbperry Pi 3 running Raspbian Stretch, 
these instructions are not likely to get you up and running out of the box in any other scenario.

The program is started by calling the GUI.py which will start the daemon thread.

``` bash
$ python GUI.py
```

### Before You Start
Download the **Raspbian Stretch with Desktop** image from the 
[official downloads page](https://www.raspberrypi.org/downloads/raspbian/), and copy the image to 
an SD card using the `dd` tool on Linux or Mac, or [Win32 Disk Imager](https://sourceforge.net/projects/win32diskimager/) 
on Windows

## Files:
- Daemon.py: Runs in the background and takes data from the arduino and GUI to update users' 
balances. This listens for input from Serial from the arduino and input from 
the GUI from the user. 

- GUI.py: Uses wxPython to create a GUI for the touch screen. This is updated by the daemon
to display the user's name and balance.

- connector.py:	Deals with all the IO calls. Calls out to the drink API to get user
information and update user's credits. This also deals with all the logging.


## Required Python Libaries:
- wxPython
- configParser
- pyserial 
- requests
- python-ldap

On rasbian, wxPython is provided by `python-wxgtk3.0` and the others are avaliable as-is on pip.

## System Setup

These commands will install dependencies and other needed tools:
``` bash
$ sudo apt-get install vim ntpdate arduino matchbox-keyboard
$ sudo apt-get install python-dev libsasl2-dev libldap2-dev libssl-dev python-wxgtk3.0 libcanberra-gtk-module
$ sudo apt-get install --no-install-recommends packagekit-gtk3-module #gnome and all of its tools are reccomened 
$ sudo ntpdate ntp.rit.edu
$ sudo pip install --upgrade python-ldap configParser pyserial requests
```

#### Build xinput_calibrator

Install xinput_calibrator dependencies and build tools
```bash
$ sudo apt-get install dh-autoreconf libx11-dev libxi-dev x11proto-input-dev
```

Clone xinput_calibrator and build. Only use 3 cores because it doesn't take that long and the pi is slow.
```bash
$ git clone https://github.com/tias/xinput_calibrator.git
$ cd xinput_calibrator
$ ./autogen.sh
$ make -j3 
$ sudo make install
$ DISPLAY=:0.0 xinput_calibrator
```
#### Making the calibration permenant

Copy the "Section ... End Section" from the output and put it in a file at `/etc/X11/xorg.conf.d/99-calibration.conf`, delete whatever is there already, and restart.

##### Troubleshooting:
**On the most recent setup of AutoDrinkAdmin (Raspbain stretch) using the most recent version of `xinput_calibrator`, 
the calibration rules seem to be loaded by X after it loads the device driver, but they're not actually applied.**
This problem is a real sticky one, and the only real solution we managed to find was running
```bash
$ xinput <touchscreen_id> <coordinate_transformation_matrix_id> -1 0 1 0 1 0 0 0 1
```
replacing `<touchscreen_id>` with the id of the touchscreen as shown by the command `xinput list` and `<coordinate_transformation_matrix_id>` with the id of the 
coordinate transformation matrix prop id as shown by `xinput list-props <touchscreen_id>`

This doesn't get us a perfect calibration, but it at least gets the machine in a usable state

#### Test the GUI once 
First, make sure that the Arduino is mounted at the correct device name, `ACM0`. 
``` bash
$ arduino
```
Check through the devices menu to ensure that the arduino mega is at `ACM0`
If all is well, run

```bash
$ cd AutoDrinkAdmin
$ ./launcher
```
