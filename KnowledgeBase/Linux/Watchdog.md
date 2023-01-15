# Linux Watchdog

Watchdog is a daemon that monitors the health of a system and its processes and can restart them if they are not responding.

## Hardware Device

- Applies to physical machines such as Raspberry Pi
- Steps below target Debian based systems such as Ubuntu using the `apt` package manager
  - Adjust as required for other package managers and distributions

1. Enable hardware watchdog

        sudo su
        echo 'dtparam=watchdog=on' >> /boot/config.txt
        reboot

2. Install watchdog service

        sudo apt-get install watchdog

3. Configure the watchdog
    - Edit `/etc/watchdog.conf`
    - Changes can be customer as required
        - Common base values I use

                # These values will hopefully never reboot your machine during normal use
                # (if your machine is really hung, the loadavg will go much higher than 25)
                max-load-1              = 24
                max-load-5              = 18
                max-load-15             = 12

                watchdog-device = /dev/watchdog
                watchdog-timeout = 15 # seconds

                temperature-sensor      = /sys/class/thermal/thermal_zone0/temp
                temperature-device      = /sys/class/thermal/thermal_zone0/temp
                max-temperature = 90
        - Add network interface monitoring

                # Check and ensure network is up
                interface               = eth0

        - Add memory monitoring

                # Note that this is the number of pages!
                # To get the real size, check how large the pagesize is on your machine.
                min-memory              = 50000 # 200 MB
                allocatable-memory      = 10000 # 40 MB

        - Example process/PID monitor

                # Monitoring system processes including PiHole related processes
                # Set by Graham Watts on 2021-05-27
                pidfile    = /var/run/pihole-FTL.pid
                pidfile    = /var/run/lighttpd.pid
                pidfile    = /var/run/sshd.pid

4. Enable the service

        sudo systemctl enable watchdog
        sudo systemctl start watchdog
        sudo systemctl status watchdog

Taken from: <https://diode.io/raspberry%20pi/running-forever-with-the-raspberry-pi-hardware-watchdog-20202/>
