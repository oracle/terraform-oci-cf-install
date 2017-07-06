provider "baremetal" {
    tenancy_ocid     = "${var.oracle_bmcs_tenancy_ocid}"
    user_ocid        = "${var.oracle_bmcs_user_ocid}"
    fingerprint      = "${var.oracle_bmcs_fingerprint}"
    private_key_path = "${var.oracle_bmcs_private_key_path}"
}
