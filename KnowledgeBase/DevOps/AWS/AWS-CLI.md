# AWS Command Line Interface (CLI)

AWS provides a command line interface (CLI) to interact with AWS services. The CLI is a unified tool to manage your AWS services. With minimal configuration, you can start using all of the functionality provided by AWS. You can use the AWS CLI to perform the same tasks that you can perform in the AWS Management Console. You can use the AWS CLI to create and manage AWS resources, such as Amazon EC2 instances and Amazon S3 buckets.

<https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html>

## Installation

### Windows

There are several options you may use to install the AWS CLI including the Windows Package Manager (winget), Chocolatey, and the MSI installer.

#### Windows Package Manager (winget)

The Windows Package Manager (winget) is a command-line utility for installing and updating Windows applications. The Windows Package Manager is available for Windows 10 and Windows 11. The Windows Package Manager is not available for Windows 7 or Windows 8.

To install the AWS CLI using winget, open a PowerShell window and run the following command:

```powershell
winget install Amazon.AWSCLI
```

#### Chocolatey

Chocolatey is a software management solution similar to apt-get for Linux or Homebrew for macOS. Chocolatey is available for Windows 7 and later.

To install the AWS CLI using Chocolatey, open a PowerShell window and run the following command:

```powershell
choco install awscli
```

#### MSI Installer

The MSI installer is available for download from the [AWS CLI download page](https://awscli.amazonaws.com/AWSCLIV2.msi). The MSI installer is available for Windows 7 and later.

### macOS

The AWS CLI is available for macOS 10.7 and later. The AWS CLI is available as a standalone package or as a Homebrew package.

#### Standalone Package

The standalone package is available for download from the [AWS CLI download page](https://awscli.amazonaws.com/AWSCLIV2.pkg). The standalone package is available for macOS 10.7 and later.

#### Homebrew

Homebrew is a free and open-source software package management system that simplifies the installation of software on Apple's macOS operating system. Homebrew is available for macOS 10.7 and later.

To install the AWS CLI using Homebrew, open a Terminal window and run the following command:

```bash
brew install awscli
```

### Linux

The AWS CLI is available for Linux by way of a zipped package of binaries that can be downloaded directly from AWS and installed using the provided script.

```bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
```

This install can be updated with the `--update` flag as follows:

```bash
sudo ./aws/install --bin-dir /usr/local/bin --install-dir /usr/local/aws-cli --update
```

## Configuration

The AWS CLI requires that you configure your credentials before you can use it to interact with AWS services. Access Keys can be be created as part of an existing user, or new user, via the AWS Management Console.  Once create the Access Keys can be used to configure the AWS CLI.

### Creating Keys With The AWS Management Console

#### Existing User

To configure your credentials using the AWS Management Console, open a web browser and navigate to the [AWS Management Console](https://console.aws.amazon.com/iam/home?region=us-east-1#/users). Select **Users** from the left-hand menu. Select the user you wish to configure. Select **Security credentials**. Select **Create access key**. You will be prompted to download a CSV file containing your AWS Access Key ID and AWS Secret Access Key. Save the file to a secure location.

#### Create a New User

To configure your credentials using the AWS Management Console, open a web browser and navigate to the [AWS Management Console](https://console.aws.amazon.com/iam/home?region=us-east-1#/users). Select **Users** from the left-hand menu. Select **Add user**. Enter a user name and select **Programmatic access**. Select **Next: Permissions**. Select **Attach existing policies directly**. Select **AdministratorAccess**. Select **Next: Tags**. Select **Next: Review**. Select **Create user**. You will be prompted to download a CSV file containing your AWS Access Key ID and AWS Secret Access Key. Save the file to a secure location.

### AWS CLI

To configure your credentials using the AWS CLI, open a Terminal window and run the following command:

```bash
aws configure
```

You will be prompted to enter your AWS Access Key ID and AWS Secret Access Key. You can find your AWS Access Key ID and AWS Secret Access Key in the AWS Management Console. For more information, see [Creating an IAM User in Your AWS Account](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_users_create.html).

**Example**

```powershell
PS C:\Users\Graham> aws configure
AWS Access Key ID [None]: <access_key_id>
AWS Secret Access Key [None]: <access_key>
Default region name [None]: us-east-1 # or your preferred region
Default output format [None]: json # or your preferred format, e.g. text, yaml
```

### Named Profiles

The AWS CLI supports the use of named profiles. Named profiles allow you to configure multiple sets of credentials and switch between them as needed. To configure a named profile, open a Terminal window and run the following command:

```bash
aws configure --profile <profile_name>
```

As with the default profile, you will be prompted to enter your AWS Access Key ID and AWS Secret Access Key. You can find your AWS Access Key ID and AWS Secret Access Key in the AWS Management Console. For more information, see [Creating an IAM User in Your AWS Account](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_users_create.html).

**Example**

```powershell
PS C:\Users\Graham> aws configure --profile test
AWS Access Key ID [None]: <access_key_id>
AWS Secret Access Key [None]: <access_key>
Default region name [None]: us-east-1
Default output format [None]: json
```

### Listing Profiles

To list the profiles configured on your system, open a Terminal window and run the following command:

```bash
aws configure list-profiles
```

**Example**

```powershell
PS C:\Users\Graham> aws configure list-profiles
default
profile1
profile2
```

### Using Profiles

To use a named profile, open a Terminal window and run the following command:

```bash
aws --profile <profile_name> <command>
```

Alternatively, you can set the `AWS_PROFILE` environment variable to the name of the profile you wish to use. For example:

```bash
export AWS_PROFILE=<profile_name>
```

Or for Windows:

```powershell
Set-Variable -Name AWS_PROFILE -Value <profile_name>
```
