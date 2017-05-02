    #     ___  ____     _    ____ _     _____
    #    / _ \|  _ \   / \  / ___| |   | ____|
    #   | | | | |_) | / _ \| |   | |   |  _|
    #   | |_| |  _ < / ___ | |___| |___| |___
    #    \___/|_| \_/_/   \_\____|_____|_____|
***

## Initializing a Cloud Foundry / BOSH deployment

This project exists to simplify the configuration and deployment of Cloud Foundry and BOSH on the Oracle Bare Metal Cloud Service. It will configure the following:
* VCN and Subnets
    * Public, Private and Bastion Subnets in 3 Availability Domains
* A Bastion server with BOSH CLI for deploying MicroBOSH and Cloud Foundry.

### Configuring Terraform to work with Oracle BMC

TBD

### Using this project

* Update env-var with the required information.
* Source env-var
  * `$ . env-var`
* Update `variables.tf` with your instance options.

### Configuring the BMCS API Key

In order to use Terraform with the Oracle BMC, you will need to configure an API Key.

TBD

Getting the fingerprint of an API Public Key:

TBD

