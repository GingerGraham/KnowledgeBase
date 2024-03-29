# Adding sudo and adding users to sudo

sudo is often a vital tool when working with Linux based systems as it allows you to elevate your privileges to run commands as an administrator when required.

## Installing sudo

On some distros like Debian 10 (Buster) sudo may not be installed.  This means scripts leveraging sudo from regular users will fail and users must switch user to root before running elevated privilege commands

To install sudo:

1. Switch to **root** user

        su -

1. Install sudo using your appropriate package manager

        apt install sudo # Debian/Ubuntu
        
        yum install sudo # RHEL7 and earlier
        
        dnf install sudo # Fedora and RHEL8

## Adding user to sudo group

1. While still logged in as **root** run

        usermod -aG <username>

1. Exit *root*
1. Logout and back in as user
