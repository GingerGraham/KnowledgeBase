# Rename a user on Linux

When working with Linux based systems it may be required to rename a user.  This can be done using the following commands.

1. Example to rename user named *ubuntu*

```bash
sudo usermod -l <newname> -d /home/<newname> -m ubuntu # <-- oldname
```

**Example**

Rename the user *ubuntu* to *ubuntu2*

```bash
sudo usermod -l ubuntu2 -d /home/ubuntu2 -m ubuntu
```

Taken from <https://www.codegrepper.com/code-examples/shell/rename+username+ubuntu+20.04>
