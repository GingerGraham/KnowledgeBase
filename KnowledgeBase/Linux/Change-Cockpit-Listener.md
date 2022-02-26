# Change Listener Port and Address for Cockpit

Where [Cockpit](https://cockpit-project.org/) is being run on a server with other web resources the default port of TCP 9090 may already be bound by another process.  A common example is where Cockpit and Prometheus are on the same server and trying to use their default ports.

## Change Cockpit Listener

1. Edit `/etc/systemd/system/cockpit.socket.d/listen.conf`
    - `cockpit.socket.d` may not exist as a directory create it if required
    - `listen.conf` may not exist as a file create it if required
1. Declare a *Socket*
    - Include port(s) and address(es) as required
    - The FreeBind option is highly recommended when defining specific IP addresses. 

            [Socket]
            ListenStream=
            ListenStream=443

            or
    
            [Socket]
            ListenStream=
            ListenStream=192.168.1.1:443
            FreeBind=yes

Taken from: <https://cockpit-project.org/guide/latest/listen>
