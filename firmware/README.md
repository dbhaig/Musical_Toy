# Arduino Firmware

The firmware is written using the following libraries:

* ADCTouch by martin2250 - https://github.com/martin2250/ADCTouch 
* DFPlayer by DFRobot - https://github.com/DFRobot/DFRobotDFPlayerMini 

The firmware is fairly straight forward. The Arduino can be programmed using the IDE found here:
https://www.arduino.cc/en/main/software

The touch sensitivity of the toy can be adjusted by changing the value of the 
touch_ambient variable.

upload.sh - a script to compile the firmware on the linux command line using amake. (Developed by Pavel Milanes: https://github.com/pavelmc/amake)
The Arduino IDE still needs to be installed on the system.
