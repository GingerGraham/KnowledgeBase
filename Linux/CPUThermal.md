## Linux Check CPU Temp

## Index

## Quick and Dirty

Requires no add-on installed packages

        paste <(cat /sys/class/thermal/thermal_zone*/type) <(cat /sys/class/thermal/thermal_zone*/temp) | column -s $'\t' -t | sed 's/\(.\)..$/.\1°C/'
        
        e.g.
        
        gwatts@pr-monitor-01:~$ paste <(cat /sys/class/thermal/thermal_zone*/type) <(cat /sys/class/thermal/thermal_zone*/temp) | column -s $'\t' -t | sed 's/\(.\)..$/.\1°C/'
        cpu-thermal  79.3°C

## Using lm-sensors

1. Install lm-sensors

        sudo apt install hddtemp lm-sensors

1. Run sensors

        gwatts@pr-monitor-01:~$ sensors
        rpi_volt-isa-0000
        Adapter: ISA adapter
        in0:              N/A
        
        cpu_thermal-virtual-0
        Adapter: Virtual device
        temp1:        +67.7°C

1. Or, watch sensors

        watch sensors
        
        Every 2.0s: sensors                                            pr-monitor-01: Fri Aug 13 13:32:57 2021
        rpi_volt-isa-0000
        Adapter: ISA adapter
        in0:              N/A
        
        cpu_thermal-virtual-0
        Adapter: Virtual device
        temp1:        +69.6°C
