# Preparing an environment for specific version requirements

In some circumstances a build environment may not be on the latest version of available tools.  In this case doing a simple install of the tools required may end up with versions that cannot be used for managing and updating the environment due to old version dependancies.

In this case there are some approaches that can be taken

## Contents

1. [(Optional) Using a container](#using-a-container)
1. [Prepare the environment](#prepare-the-environment)
1. [Specific version of node.js](#specific-version-of-node)

## Using a container

This step is **optional**

If the host/workstation environment is not appropriate for changing to a specific set of tool versions a container can be prepared and used

```bash
docker run -dit --name <container_name> --hostname <container_hostname> <image>
docker exec -it <container_name> /bin/bash
```

**Example**

```bash
docker run -dit --name build-env --hostname build-env fedora
docker exec -it buildenv /bin/bash
```

**Notes**

- Alternative container technologies such as `podman` could also be used
- The `hostname` switch is optional but may be desired if retaining the container for repeated use

## Prepare the environment

Install any baseline tooling that might be generally needed, e.g. vim or wget etc.

```bash
<package_manager> install <required_tools>
```

**Example**

```bash
dnf install git vim wget curl zsh bat -y
```

## Specific version of node

Easiest way to specify a particular version is through [NVM](https://github.com/nvm-sh/nvm)

```bash
curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash 
source ~/.bashrc
nvm install v16.13.0 #Note: replace with required version as necessary
```

## Specific version of python

For Fedora/RHEL `dnf` allows the version required to be specified as part of the install command

```bash
dnf install python3.8 -y # Note: specify the version as required
```

Also may wish to install `pip`

```bash
dnf install python3-pip -y
```

## Specific version of AWS CDK

First install AWS CLI

```bash
<package_manager> awscli
```

**Example**

```bash
dnf install awscli -y
```

Use `npm` (see [specific version of node.js](#specific-version-of-node) if required) to then install a specify the specific version required

```bash
npm install --save-exact -g aws-cdk@1.91.0
```

**Notes**

- `--save-exact` tells npm to install the version specified and not update/upgrade
- `-g` is a global install flag
- Use `@<version_number>` to define the required verson

Then, as required use `pip` to install cdk elements as necessary using `==` to specify a required version

```bash
pip3 install aws-cdk.core==1.91.0
```
