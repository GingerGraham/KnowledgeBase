# SSH Keys and Apple Keychain

SSH keys can be saved on the user Apple Keychain and recalled from the keychain to avoid adding keys to each terminal session.  Once keys are added a single ssh-add command can be added to the terminal session file to load the keys.

## Adding keys to the keychain

```bash
ssh-add --apple-use-keychain <ssh_key_file>
```

## Loading keys from the keychain

This command can be added to the user shell rc file e.g. `.zshrc` or `.bashrc`

```bash
ssh-add --apple-load-keychain
```
