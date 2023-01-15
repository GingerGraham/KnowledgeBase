# Rename a host machine

When working with Linux based systems it may be required to rename a host machine.  This can be done using the following commands.

- Use hostnamectl to change the host name

```bash
hostnamectl set-hostname "new-hostname"
```

- Can also set the pretty, or display, name with the same tool

```bash
hostnamectl set-hostname "new pretty name" --pretty
```

**Example**

Rename the host machine *ubuntu* to *ubuntu2*

```bash
hostnamectl set-hostname "ubuntu2"
```

Taken from <https://phoenixnap.com/kb/ubuntu-20-04-change-hostname>
