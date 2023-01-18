# Custom Forwarding on Pi-Hole

How to configure custom forwarding on Pi-Hole

By default, as of FTL 5.8.1, Pi-Hole has limited support for Conditional Forwarding in the web UI.  This limitation of only being able to add one conditional forward can restrict more advanced use where specific domains may need to be forwarded to other domain DNS servers, such as VPN to corporate resources.

## Custom DNS Configuration

PiHole leverages [DNSMasq](https://wiki.debian.org/dnsmasq).  Additional configuration can be added to `/etc/dnsmasq.d/` as conf files.

1. Create a new file such as `02-custom.conf` in `/etc/dnsmasq.d/`

        sudo touch /etc/dnsmasq.d/02-custom.conf

1. Add required configuration lines as follows using a text editor of your choice

        server=/<domain>/<DNS Server>

        e.g.

        server=/mydomain.com/192.168.1.1
