variable "oracle_bmcs_tenancy_ocid" {}
variable "oracle_bmcs_user_ocid" {}
variable "oracle_bmcs_fingerprint" {}
variable "oracle_bmcs_private_key_path" {}

variable "bosh_compartment_id" {}
variable "public_subnet_ad1_id" {}
variable "public_subnet_ad2_id" {}

variable "loadbalancer_shape" {
    default = "400Mbps"
}

variable "cf_load_balancer_private_key" {
    default = "../keys/lb-ssl.key"
}

variable "cf_load_balancer_public_cert" {
    default = "../keys/lb-ssl.crt"
}
