    #     ___  ____     _    ____ _     _____
    #    / _ \|  _ \   / \  / ___| |   | ____|
    #   | | | | |_) | / _ \| |   | |   |  _|
    #   | |_| |  _ < / ___ | |___| |___| |___
    #    \___/|_| \_/_/   \_\____|_____|_____|
***

## Initializing a Cloud Foundry / BOSH deployment

This project exists to simplify the configuration and deployment of Cloud Foundry and BOSH on
Oracle Cloud Infrastructure. It will configure the following:
* VCN and Subnets
    * Public, Private and Bastion Subnets in 3 Availability Domains
* A Bastion server with BOSH CLI for deploying BOSH Director and Cloud Foundry.

### Configuring Terraform to work with OCI

First, install Terraform v0.11.10 or later.  On OSX, you can use HomeBrew:

    $ brew install terraform

Next, use `terraform init` to download Terraform OCI provider

    $ terraform init 


### Using this project

* Update env-var with the required information.
* Source env-var
  * `$ . env-var`

### Configuring the OCI API Key

In order to use Terraform with OCI, you will need to configure an API Key. You must
generate a public key in PEM format and obtain its fingerprint. Follow this guide here for more
information:

    https://docs.us-phoenix-1.oraclecloud.com/Content/API/Concepts/apisigningkey.htm

### Deploying the BOSH Bastion using Terraform

###### Create an API signing key, SSH key pair, and SSL certificates for Load Balancers.

First, you will want to run the included script `bosh-key-gen.sh`. This is a
separate key from the OCI API Key mentioned above, which is used by Terraform to communicate with
OCI. This script generates the keys that BOSH will use to communicate with OCI, as well as
an SSH key pair for shell access to the bastion instance, and SSL certificates that will be
installed for the Load Balancers.

As part of the process to create SSL certificates, you will be prompted for a passphrase.
You may enter what you like, but keep in mind it will ask you for the password again later
in the process.

Once all the steps above are completed your environment variables have been configured, you may run `terraform
apply` to have Terraform deploy the environment.

###### Login to the BOSH Bastion using SSH

The IP address of the instance will be output at the end of a successful `terraform apply`. Use this address
and the SSH key pair we generated earlier to access the instance:

`ssh -i keys/bosh-ssh ubuntu@<your IP address>`

###### Post Provisioning

The bastion VM will come a script to install the BOSH v2 CLI, and will also manage the iSCSI connection for the
block device.  In order to preserve data in case of a failure and subsequent `terraform apply` run, no effort
is taken to format the attached block device, which is at `/dev/sdb`.  Upon successful deployment of the bastion
VM, you may format and mount the block device manually.

```bash
$ ./install_deps.sh
$ sudo mkfs.ext4 /dev/sdb
$ sudo mount -a
```

In the home directory, the `bosh` folder points to the mounted block device, so you may keep your releases,
stemcells and deployments there for safe keeping.
