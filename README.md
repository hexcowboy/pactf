# PaCTF

> Author: hexcowboy ([@hexcowboy](https://twitter.com/hexcowboy))

This repository will automate the build of an entire Ubuntu 20.04 VirtualBox machine that you can submit to your favorite Capture the Flag provider.


## VM Settings

- **Type**: VirtualBox OVA
- **OS**: Ubuntu 20.04
- **CPU**: 1 CPU
- **Memory**: 1GB
- **Disk**: 8GB

## Build Guide

### Production

#### Requirements:

- [Packer](https://github.com/hashicorp/packer)
- [VirtualBox](https://www.virtualbox.org/)

#### Steps

1. Build with packer
```bash
packer build -force packer/packer.json
```
2. Wait for the build process to complete (10+ minutes)
3. The VM will be output in `build/<machine>.ova`

### Testing on a VPS

1. Install Ubuntu 20.04 LTS
2. Enable network connectivity and export the VPS IP as a variable
```bash
export IP=<IP ADDRESS HERE>
```
3. Upload the skeleton directory
```bash
rsync -Pazh skel/ root@$IP:/
```
4. Run the build script
```bash
ssh "root@$IP" "bash -s" < packer/scripts/build.sh
```

## Structure

```bash
.
├── README.md                       # YOU ARE HERE
├── builds                          # Your VMs will be built here
│   └── machine.ova
├── exploit                         # Add your exploit scripts here
│   ├── cve-XXXX.py
│   └── www
│       └── enum-script.sh
├── htb                             # Information and writeup for HTB
│   ├── information.md
│   └── writeup.md
├── packer
│   ├── http                        # Don't touch these (for your own safety)
│   │   ├── meta-data               # ↵
│   │   └── user-data               # ↵
│   ├── packer.json                 # The VM config
│   └── scripts
│       ├── base.sh                 # Base Ubuntu install
│       ├── build.sh                # CTF build scripts
│       └── network.sh              # CTF network scripts
└── skel                            # Files that will be uploaded to the root directory tree
    └── home
        └── user
            └── webserver.zip
```

## Methodology

Here is how your workflow might look:

1. Edit the `packer/packer.json` to configure and set the name of the VM
1. Install vulnerable software in the `packer/scripts/build.sh` file
1. Add any files to the directory root in `skel/` where all files will get added to the VM in the respective file heirarchy
1. Configure the VM's network properties in `packer/scripts/network.sh`
1. Build the box (see above)
1. Test the box and add exploit tools to the `exploit/` folder
1. Once finished, create the writeup and information in `htb/`
