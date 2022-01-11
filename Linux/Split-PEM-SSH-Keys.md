---
---
# Splitting PEM SSH Keys

Services such as Amazon AWS provide SSH keys as PEM (.pem) files.  While this can be consumed by the ssh command they do not work well with ssh-add and ssh-agents.

## User OpenSSL to reformat and split a PEM key

1. Convert the PEM file

    ```bash
    openssl pkey < *pem_file*.pem > *exported_key*
    ```

    ```bash
    openssl pkey < demo.pem > demo
    ```

1. Export public key

    ```bash
    openssl rsa -in *exported_key* -pubout > *public_key*.pub
    ```

    ```bash
    openssl rsa -in demo -pubout > demo.pub
    ```

1. Permissions

    Remember to set permissions on private key to 400

    ```bash
    chmod 600 *exported_key*
    ```

    ```bash
    chmod 600 demo
    ```

1. Apply a passphrase

    Secure the key with a passphrase

    ```bash
    ssh-keygen -p -f *exported_key*
    ```

    ```bash
    ssh-keygen -p -f demo
    Enter new passphrase (empty for no passphrase): 
    Enter same passphrase again: 
    Your identification has been saved with the new passphrase.
    ```
