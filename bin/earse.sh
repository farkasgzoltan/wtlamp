#!/bin/sh
./esptool -vv -cd nodemcu -cb 921600 -cp /dev/ttyUSB0 -bz 16M -ca 0x000000 -cf blank4mb.bin