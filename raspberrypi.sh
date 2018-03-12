#!/bin/bash
# Script for Monitoring a Raspberry Pi with Zabbix
# 2013 Bernhard Linz
# Bernhard@znil.de / http://znil.net
# modifiziert 2018 Jan Schoefer
#
case "$1" in
        boardversion)
                # get the Hardware Version
                cat /proc/cpuinfo | grep Hardware | tr -d " " | cut -d ":" -f 2
                ;;
        boardrevision)
                # get the Hardware Revision
                cat /proc/cpuinfo | grep Revision | tr -d " " | cut -d ":" -f 2
                ;;
        boardserialnumber)
                # get the Board unique Serial Number
                cat /proc/cpuinfo | grep Serial | tr -d " " | cut -d ":" -f 2
                ;;
        cpuvoltage)
                # Voltage in Volt
                /opt/vc/bin/vcgencmd measure_volts | tr -d "volt=" | tr -d "V"
                ;;
        cpuclock)
                # CPU Clock Speed in Hz
                /opt/vc/bin/vcgencmd measure_clock arm | tr -d "frequency(45)="
                ;;
        cpumem)
                # CPU Memory in MByte
                vcgencmd get_mem arm | tr -d "arm=" | tr -d "M"
                ;;
        firmwareversion)
                # Just the naked String of the firmware Version
                vcgencmd version | grep version | cut -d " " -f 2
                ;;
        gpumem)
                # Graphics memeory in MByte
                vcgencmd get_mem gpu | tr -d "gpu=" | tr -d "M"
                ;;
        sdcardtotalsize)
                # Size of SD-Card in KByte
                df -P -B1 | grep rootfs | tr -s " " " " | cut -d " " -f 2
                ;;
        sdcardused)
                # Used Diskspace in KByte
                df -P -B1| grep rootfs | tr -s " " " " | cut -d " " -f 3
                ;;
        sdcardusedpercent)
                # Used Diskspace in Percent
                df -P -B1| grep rootfs | tr -s " " " " | cut -d " " -f 5
                ;;
        sdcardfree)
                # free Diskspace in KByte
                df -P -B1| grep rootfs | tr -s " " " " | cut -d " " -f 4
                ;;
        temperature)
                # Temperature in 1/1000 centigrade
                cat /sys/class/thermal/thermal_zone*/temp
                ;;
        *)
                echo "Usage: $N {boardversion|boardrevision|boardserialnumber|cpuvoltage|cpuclock|cpumem|firmwareversion|gpumem|sdcardtotalsize|sdcardused|sdcardusedpercent|sdcardfree|temperature}" >&2
esac
exit 0
