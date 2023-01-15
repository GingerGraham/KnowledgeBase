# Stress Testing Linux Systems

## Introduction

t may be required to run performance tests on a Linux server to either benchmark system performance or to validate monitoring systems work as intended. To do this we need to introduce stress testing.

## `stress` and `stress-ng`

There are 2 common packages available to run stress testing on individual compute components such as CPU, Memory, Disk or Network. These are `stress` and `stress-ng`. The `stress` package is available in the default CentOS 7 repositories and `stress-ng` is available in the [EPEL](https://docs.fedoraproject.org/en-US/epel/) repository.

### Installing `stress`

The following steps detail install `stress` on a Red Hat Enterprise Linux (RHEL) 7 server.  The same steps can be applied for Fedora, RHEL, Amazon Linux 2 or Oracle Linux (OL).

```bash
sudo yum install epel-release-latest-7.noarch.rpm. ## Install the repo file - note that the version of base RHEL is detailed in the package this package is for a RHEL 7 based system
sudo yum repolist ## List the configured repos and validate that EPEL is now listed
sudo yum install -y stress. ## Install the stress package and dependencies
```

## Running `stress`

The `stress` package provides a number of options to stress test the system.  The following example will stress test the CPU for 60 seconds across 4 cpu cores.

```bash
stress --cpu 4 --timeout 60s
```

Below will run a memory test using 8 worker vm nodes to consume 2GB each for a total of 16GB memory allocation load for a run time of 10 minutes (600 seconds)

```bash
stress --vm 8 --vm-bytes 2G --timeout 600s
```

## Links

- [Stress Test CPU and Memory (VM) On a Linux / Unix With Stress-ng - nixCraft (cyberciti.biz)](https://www.cyberciti.biz/faq/stress-test-linux-unix-server-with-stress-ng/#:~:text=Unix%20%2F%20Linux%20memory%20stress%20test.%20One%20can,calling%20mmap%2Fmunmap%20and%20writing%20to%20the%20allocated%20memory.)
- [Enabling or disabling a repository using Red Hat Subscription Management - Red Hat Customer Portal](https://access.redhat.com/solutions/265523)
