variable "oracle_bmcs_tenancy_ocid" {}
variable "oracle_bmcs_user_ocid" {}
variable "oracle_bmcs_fingerprint" {}
variable "oracle_bmcs_private_key_path" {}

variable "compartment_ocid" {}
variable "ssh_public_key" {}
variable "ssh_private_key" {}
variable "ssh_username" {
    default = "ubuntu"
}

variable "dyn_customer_name" {}
variable "dyn_username" {}
variable "dyn_password" {}

variable "VPC-CIDR" {
    default = "10.0.0.0/16"
}

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

# TODO: This can go away.
# Choose an Availability Domain
variable "AD" {
    default = "1"
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
