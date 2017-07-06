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
