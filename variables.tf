# Authentication
variable "oracle_bmcs_tenancy_ocid" {}
variable "oracle_bmcs_user_ocid" {}
variable "oracle_bmcs_fingerprint" {}
variable "oracle_bmcs_private_key_path" {}

# Identity
variable "bosh_compartment_name" {
    default = "bosh"
}
variable "bosh_user_name" {
    default = "bosh"
}
variable "bosh_group_name" {
    default = "bosh"
}

variable "bosh_api_public_key" {
    default = "./keys/bosh-api-public-key.pem"
}

variable "bosh_api_private_key" {
    default = "./keys/bosh-api-private-key.pem"
}

variable "bosh_api_fingerprint" {
    default = "./keys/bosh-api-fingerprint"
}

variable "bosh_ssh_public_key" {
    default = "./keys/bosh-ssh.pub"
}
variable "bosh_ssh_private_key" {
    default = "./keys/bosh-ssh.pem"
}
variable "bosh_ssh_username" {
    default = "ubuntu"
}

# Dyn
variable "dyn_customer_name" {}
variable "dyn_username" {}
variable "dyn_password" {}

variable "VPC-CIDR" {
    default = "10.0.0.0/16"
}

# Networking

# TODO: Use consistent case convention for network configuration
variable "PublicSubnetAD1-CIDR" {
    default = "10.0.1.0/24"
}

variable "PrivateSubnetAD1-CIDR" {
    default = "10.0.2.0/24"
}

variable "BastionSubnetAD1-CIDR" {
    default = "10.0.3.0/24"
}

variable "PublicSubnetAD2-CIDR" {
    default = "10.0.4.0/24"
}

variable "PrivateSubnetAD2-CIDR" {
    default = "10.0.5.0/24"
}

variable "BastionSubnetAD2-CIDR" {
    default = "10.0.6.0/24"
}

variable "PublicSubnetAD3-CIDR" {
    default = "10.0.7.0/24"
}

variable "PrivateSubnetAD3-CIDR" {
    default = "10.0.8.0/24"
}

variable "BastionSubnetAD3-CIDR" {
    default = "10.0.9.0/24"
}

# Bastion VM

# Choose an Availability Domain for the Bastion instance.
variable "bastion_ad" {
    default = "1"
}

variable "bastion_image_id" {
    default = "ocid1.image.oc1.phx.aaaaaaaaxsufrpzn72dvhry5swbuwnuldcn3eko3cx6g7z4tw4qfwkq2zkra"
}

variable "timeout_minutes" {
    default = 5
}

variable "InstanceShape" {
    default = "VM.Standard1.2"
}

variable "InstanceOS" {
    default = "Ubuntu"
}

variable "InstanceOSVersion" {
    default = "16.04"
}

variable "2TB" {
    default = "2097152"
}

variable "256GB" {
    default = "262144"
}

variable "BootStrapFile" {
    default = "./userdata/bootstrap"
}
