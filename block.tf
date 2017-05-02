resource "baremetal_core_volume" "bosh-cli-vol" {
  availability_domain = "${lookup(data.baremetal_identity_availability_domains.ADs.availability_domains[var.AD - 1],"name")}"
  compartment_id = "${var.compartment_ocid}"
  display_name = "bosh-cli-vol"
  size_in_mbs = "${var.256GB}"
}

resource "baremetal_core_volume_attachment" "bosh-cli-vol-attach" {
    attachment_type = "iscsi"
    compartment_id = "${var.compartment_ocid}"
    instance_id = "${baremetal_core_instance.bosh-cli.id}"
    volume_id = "${baremetal_core_volume.bosh-cli-vol.id}"
}

