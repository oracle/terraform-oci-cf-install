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

variable "bastion_subnet_ad3_cidr" {
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

variable "bastion_boot_timeout_minutes" {
    default = 5
}

variable "bastion_instance_shape" {
    default = "VM.Standard1.2"
}

variable "bastion_instance_os" {
    default = "Ubuntu"
}

variable "bastion_instance_os_version" {
    default = "16.04"
}

variable "256GB" {
    default = "262144"
}

variable "bastion_bootstrap_file" {
    default = "./userdata/bootstrap"
}

# Networking

# TODO: Use consistent case convention for network configuration
variable "public_subnet_ad1_cidr" {
    default = "10.0.1.0/24"
}

variable "private_subnet_ad1_cidr" {
    default = "10.0.2.0/24"
}

variable "bastion_subnet_ad1_cidr" {
    default = "10.0.3.0/24"
}

variable "public_subnet_ad2_cidr" {
    default = "10.0.4.0/24"
}

variable "private_subnet_ad2_cidr" {
    default = "10.0.5.0/24"
}

variable "bastion_subnet_ad2_cidr" {
    default = "10.0.6.0/24"
}

variable "public_subnet_ad3_cidr" {
    default = "10.0.7.0/24"
}

variable "private_subnet_ad3_cidr" {
    default = "10.0.8.0/24"
}

variable "bastion_subnet_ad3_cidr" {
    default = "10.0.9.0/24"
}
