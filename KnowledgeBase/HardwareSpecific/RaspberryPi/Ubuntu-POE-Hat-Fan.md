# Ubuntu 20.04 Raspberry Pi PoE+ Hat Fan

By default the PoE+ Hat is only supported in Raspian.  Running Ubuntu server may result in the fan not starting and temperatures becoming critical on the Raspberry Pi CPU.

## Boot Firmware User Config

1. Edit `/boot/firmware/usercfg.txt`
    - Requires `sudo` privileges

1. Add the following parameter changes

        # Place "config.txt" changes (dtparam, dtoverlay, disable_overscan, etc.) in
        # this file. Please refer to the README file for a description of the various
        # configuration files on the boot partition.
        
        dtoverlay=pwm
        dtoverlay=gpio-fan
        dtoverlay=rpi-poe
        dtparam=poe_fan_temp0=40000,poe_fan_temp0_hyst=5000
        dtparam=poe_fan_temp1=50000,poe_fan_temp1_hyst=3000
        dtparam=poe_fan_temp2=60000,poe_fan_temp2_hyst=5000
        dtparam=poe_fan_temp3=70000,poe_fan_temp3_hyst=2000

1. Reboot
