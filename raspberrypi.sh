#!/bin/sh
# Script for Monitoring a Raspberry Pi with Zabbix
# original from Bernhard Linz 2013 (Bernhard@znil.de / http://znil.net)
# modified 2018 Jan Schoefer
case "$1" in
        boardrevision)
                # get the Hardware Revision
                cat /proc/cpuinfo | grep Revision | tr -d " " | cut -d ":" -f 2
                ;;
        boardserialnumber)
                # get the Board unique Serial Number
                cat /proc/cpuinfo | grep Serial | tr -d " " | cut -d ":" -f 2
                ;;
        boardversion)
                # get the Hardware Version
                cat /proc/cpuinfo | grep Hardware | tr -d " " | cut -d ":" -f 2
                ;;
        coreclock)
                # Core Clock Speed in Hz
                /opt/vc/bin/vcgencmd measure_clock core | tr -d "frequency(1)="
                ;;
        cpuclock)
                # ARM Clock Speed in Hz
                /opt/vc/bin/vcgencmd measure_clock arm | tr -d "frequency(45)="
                ;;
        cpumem)
                # CPU Memory in MByte
                vcgencmd get_mem arm | tr -d "arm=" | tr -d "M"
                ;;
        cpuvoltage)
                # CPU Voltage in Volt
                /opt/vc/bin/vcgencmd measure_volts | tr -d "volt=" | tr -d "V"
                ;;
        firmwareversion)
                # Just the naked String of the firmware Version
                vcgencmd version | grep version | cut -d " " -f 2
                ;;
        gpumem)
                # Graphics memeory in MByte
                vcgencmd get_mem gpu | tr -d "gpu=" | tr -d "M"
                ;;
        sdcardfree)
                # free Diskspace in Byte
                df -P -B1| grep /dev/root | tr -s " " " " | cut -d " " -f 4
                ;;
        sdcardtotalsize)
                # Size of SD-Card in Byte
                df -P -B1 | grep /dev/root | tr -s " " " " | cut -d " " -f 2
                ;;
        sdcardusedpercent)
                # Used Diskspace in Percent
                df -P -B1| grep /dev/root | tr -s " " " " | cut -d " " -f 5 | tr -d "%"
                ;;
        sdcardused)
                # Used Diskspace in Byte
                df -P -B1| grep /dev/root | tr -s " " " " | cut -d " " -f 3
                ;;
        sdramcvoltage)
                # sdram_c Voltage in Volt
                /opt/vc/bin/vcgencmd measure_volts | tr -d "volt=" | tr -d "V"
                ;;
        sdramivoltage)
                # sdram_i Voltage in Volt
                /opt/vc/bin/vcgencmd measure_volts | tr -d "volt=" | tr -d "V"
                ;;
        sdrampvoltage)
                # sdram_p Voltage in Volt
                /opt/vc/bin/vcgencmd measure_volts | tr -d "volt=" | tr -d "V"
                ;;
        temperature)
                # Temperature in 1/1000 centigrade
                cat /sys/class/thermal/thermal_zone*/temp
                ;;
        *)
                echo "Usage: $N {boardrevision|boardversion|boardserialnumber|coreclock|cpuvoltage|cpuclock|cpumem|firmwareversion|gpumem|sdcardtotalsize|sdcardused|sdcardusedpercent|sdcardfree|sdramcvoltage|sdramivoltage|sdrampvoltage|temperature}" >&2
esac
exit 0