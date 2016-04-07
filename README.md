AutoDrinkAdmin
==============

The program is started by calling the GUI.py which will start the daemon thread.

``` bash
$ python GUI.py
```

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

These commands will install dependencies:
``` bash
$ sudo apt-get install ntpdate python-dev libsasl2-dev python-dev libldap2-dev libssl-dev python-wxgtk3.0
$ sudo svstemctl disable ntpd && sudo systemctl stop ntpd
$ sudo ntpdate 
$ sudo pip install --upgrade python-ldap configParser pyserial requests
```

Next, the touch screen needs to be set up. It is not recomended to build from source. xinput_calibrator requires a specific version of gcc that is no longer distributed.
```bash
$ sudo dpkg -i xinput-calibrator_0.7.5+git20140201-1+b1_armhf.deb
```
I'm going to assume you've already cloned this repo.

Now, we should be ready to go.
``` bash
$ cd AutoDrinkAdmin
$ ./launcher
```
