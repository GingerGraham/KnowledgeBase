# Rename a group on Linux

When administering a Linux based system it is often useful to rename a group.  This can be done using the following commands.

- Rename a group named *ubuntu*

```bash
sudo groupmod -n <newname> ubuntu # <-- old groupname
```

**Example**

Rename the group *ubuntu* to *ubuntu2*

```bash
sudo groupmod -n ubuntu2 ubuntu
```
