resource "baremetal_identity_compartment" "bosh_compartment" {
    name = "${var.bosh_compartment_name}"
    description = "${var.bosh_compartment_name}"
}

resource "baremetal_identity_group" "bosh_group" {
    name = "${var.bosh_group_name}"
    description = "${var.bosh_group_name}"
}

resource "baremetal_identity_user" "bosh_user" {
    name = "${var.bosh_user_name}"
    description = "${var.bosh_user_name}"
}

resource "baremetal_identity_user_group_membership" "bosh_user_group_membership" {
    compartment_id = "${baremetal_identity_compartment.bosh_compartment.id}"
    user_id = "${baremetal_identity_user.bosh_user.id}"
    group_id = "${baremetal_identity_group.bosh_group.id}"
}

resource "baremetal_identity_api_key" "bosh_api_key" {
    user_id = "${baremetal_identity_user.bosh_user.id}"
    key_value = "${file(var.bosh_api_public_key)}"
}
