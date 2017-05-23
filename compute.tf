resource "baremetal_core_instance" "bosh_cli" {
    availability_domain = "${lookup(data.baremetal_identity_availability_domains.ADs.availability_domains[var.bastion_ad - 1], "name")}"
    compartment_id = "${baremetal_identity_compartment.bosh_compartment.id}"
    display_name = "bosh_cli"
    hostname_label = "bosh-cli"
    # TODO: Use variables for OS / OS Version.
    image = "${var.bastion_image_id}"
    shape = "${var.bastion_instance_shape}"
    subnet_id = "${baremetal_core_subnet.bastion_subnet_ad1.id}"
    metadata {
        ssh_authorized_keys = "${file(var.bosh_ssh_public_key)}"
        user_data = "${base64encode(file(var.bastion_bootstrap_file))}"
    }
}
