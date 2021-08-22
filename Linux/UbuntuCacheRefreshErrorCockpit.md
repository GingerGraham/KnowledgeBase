## Linux Cockpit Cache Refresh Error On Ubuntu

When using [Cockpit](https://cockpit-project.org/) with Ubuntu some aspects appear not to work, such as attempting to refresh software updates.  A `Failed to refresh cache` error appears.

To resolve change the network renderer to Network Manager (in place of networkd)

1. Determine the interface configuration file used by netplan
    - Filename will be similar to `50-cloud-int.yaml` or `00-install-config.yaml`

        ls /etc/netplan/

1. Using an editor of your choice edit the config yaml file
1. Add `renderer: NetworkManager` to the interface configuration

        network: 
            ethernets:
                eth0:
                    dhcp4: true
                    optional: true
            version: 2
            renderer: NetworkManager

1. Test and if successful apply the configuration with netplan

        sudo netplan try

1. Validate Cockpit now works as expected
