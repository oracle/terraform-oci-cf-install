provider "baremetal" {
    tenancy_ocid     = "${var.oracle_bmcs_tenancy_ocid}"
    user_ocid        = "${var.oracle_bmcs_user_ocid}"
    fingerprint      = "${var.oracle_bmcs_fingerprint}"
    private_key_path = "${var.oracle_bmcs_private_key_path}"
}

provider "dyn" {
    customer_name = "${var.dyn_customer_name}"
    username      = "${var.dyn_username}"
    password      = "${var.dyn_password}"
}
