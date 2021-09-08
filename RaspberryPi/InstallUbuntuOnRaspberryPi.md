# How to install Ubuntu Server on a Raspberry Pi

This article documents the manual build process I use to commission a new Raspberry Pi running Ubuntu Server

## Outline

1. Physically prepare device
    1. Build device and case as necessary
1. [Prepare Micro SD Card with image](#prepare-micro-sd-card)
1. [First boot device](#first-boot)
1. [First login](#first-login)
1. Rename default [user](#rename-user)/[group](#rename-group)
1. [Rename hostname](#rename-host)
1. [Apply updates](#apply-updates)

## Prepare Micro SD Card

- Steps are documented in (https://ubuntu.com/tutorials/how-to-install-ubuntu-on-your-raspberry-pi)
    - I typically use an LTS build of Ubuntu Server but choose as required
- Download Raspberry Pi Imager
    - [Windows](https://downloads.raspberrypi.org/imager/imager_latest.exe)
    - [Ubuntu](https://downloads.raspberrypi.org/imager/imager_latest_amd64.deb)
    - [MacOS](https://downloads.raspberrypi.org/imager/imager_latest.dmg)
- Follow steps in tool to build image
- Ensure that the Micro SD is formatted FAT32
    - Not exFAT if on Windows and using larger SDs

## First Boot

- I typically use PoE
- Ensure you have
    - Power
    - Network
    - See [Ubuntu docs on WiFi or Ethernet](https://ubuntu.com/tutorials/how-to-install-ubuntu-on-your-raspberry-pi#3-wifi-or-ethernet) if necessary
- Connect display if needed

## First Login

- Connect using **ssh** unless you have directly connected console
    - May need to check router for IP address of device if no display is attached
- Username: **ubuntu**
- Password: **ubuntu**
- Change password when prompted
    - If not prompted run `passwd`

## Rename User

1. Create a temp user with `sudo` privileges

        sudo adduser temp
        sudo usermode -aG sudo

1. Log out
1. Log back in as *temp*
1. See [Rename a user](..\Linux\RenameUser.md)
## Rename Group

1. Without logging out from temp having renamed the default user now rename the group
    - See [Rename a group](..\Linux\RenameGroup.md)

1. Now you can log out and back in with the new username

## Rename Host

- Use hostnamectl to rename host without a reboot
    - See [Rename a host](..\Linux\RenameHostMachine.md)
## Apply Updates

A simple command to update repo list and apply all applicable updates while also cleaning up any old packages

        sudo apt update -y && sudo apt upgrade -y && sudo apt autoremove -y
