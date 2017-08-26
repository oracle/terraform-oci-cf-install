    #     ___  ____     _    ____ _     _____
    #    / _ \|  _ \   / \  / ___| |   | ____|
    #   | | | | |_) | / _ \| |   | |   |  _|
    #   | |_| |  _ < / ___ | |___| |___| |___
    #    \___/|_| \_/_/   \_\____|_____|_____|
***

## Initializing a Cloud Foundry / BOSH deployment

This project exists to simplify the configuration and deployment of Cloud Foundry and BOSH on the
Oracle Bare Metal Cloud Service. It will configure the following:
* VCN and Subnets
    * Public, Private and Bastion Subnets in 3 Availability Domains
* A Bastion server with BOSH CLI for deploying MicroBOSH and Cloud Foundry.

### Configuring Terraform to work with Oracle BMC

First, install Terraform v0.9.8 or later.  On OSX, you can use HomeBrew:

    $ brew install terraform

Next, download the latest release of the Terraform Oracle Bare Metal Cloud Provider from GitHb:

    https://github.com/oracle/terraform-provider-baremetal/releases

Place the binary somewhere in your path (probably /usr/local/bin).

### Using this project

* Update env-var with the required information.
* Source env-var
  * `$ . env-var`

### Configuring the BMCS API Key

In order to use Terraform with the Oracle BMC, you will need to configure an API Key. You must
generate a public key in PEM format and obtain its fingerprint. Follow this guide here for more
information:

    https://docs.us-phoenix-1.oraclecloud.com/Content/API/Concepts/apisigningkey.htm

### Deploying the BOSH Bastion using Terraform

###### Create an API signing key
First, you will want to run the included script `bosh-api-key-gen.sh`.  Confusingly, this is a
separate key from the BMC API Key mentioned above, which is used by Terraform to communicate with
BMC.  This script generates the keys that BOSH will use to communicate with BMC.

###### Create an ssh key pair 

Second, create a ssh-key pair.  The public key from that pair will be copied 
to the bastion instance allowing you to ssh into hat instance later. 

```bash
$ ssh-keygen -f keys/bosh-ssh
```
 
Once all the steps above are completed your environment variables have been configured, you may run `terraform
apply` to have Terraform deploy the environment.
