#!/bin/bash
#git clone https://github.com/espressif/esptool
#sudo python setup.py install
#platformio run --environment generic32 --target upload --upload-port /dev/ttyUSB0

if ! [ $(id -u) = 0 ]; then
   echo "The script need to be run as root." >&2
   exit 1
fi

if [ $SUDO_USER ]; then
    real_user=$SUDO_USER
else
    real_user=$(whoami)
fi

echo "- [0] Detecting Chip"
echo "--------------------- ESP8266 ------------------------"
echo "- [1] Flash Generic Firmware"
echo "- [2] Flash Firmware for Official Hardware (v2)"
echo "- [3] Erase the Firmware on ESP8266 by flashing empty file"
echo ""
echo "--------------------- ESP32 ------------------------"
echo "- [4] Flash Generic Firmware"
echo "- [5] Flash Firmware for Official Hardware (v2)"
echo "- [6] Erase the Firmware on ESP32 by flashing empty file"

read KEY

case $KEY in
    0)
        echo "Flash mode entering: flash button or gpio0 to ground"
        esptool.py flash_id
        ;;
    1)
        ./esptool -vv -cd nodemcu -cb 921600 -cp /dev/ttyUSB0 -bz 16M -ca 0x00000 -cf firmware.bin
        ;;
    2)
        ./esptool -vv -cd nodemcu -cb 921600 -cp /dev/ttyUSB0 -bz 16M -ca 0x00000 -cf forV2Board.bin
        ;;
    3)
        ./esptool -vv -cd nodemcu -cb 921600 -cp /dev/ttyUSB0 -bz 16M -ca 0x000000 -cf blank4mb.bin
        ;;
    4)
        #esptool.py --port /dev/ttyUSB0 write_flash --flash_mode qio --flash_size 4MB 0x0 bootloader.bin 0x1000 firmware.bin
        esptool.py --port /dev/ttyUSB0 write_flash --flash_mode qio --flash_size 4MB 0x0 generic.bin
        ;;
    5)
        echo "seven or nine"
        ;;
    6)
        esptool.py --port /dev/ttyUSB0 erase_flash
        ;;

    *)
        echo "nincs ilyen opcio"
        ;;
esac
