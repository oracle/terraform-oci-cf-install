provider "baremetal" {
  tenancy_ocid     = "${var.tenancy_ocid}"
  user_ocid        = "${var.user_ocid}"
  fingerprint      = "${var.fingerprint}"
  private_key_path = "${var.private_key_path}"
}

provider "dyn" {
  customer_name = "${var.dyn_customer_name}"
  username      = "${var.dyn_username}"
  password      = "${var.dyn_password}"
}
