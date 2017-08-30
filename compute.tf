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

resource "null_resource" "remote-exec" {
    depends_on = ["baremetal_core_instance.bosh_cli",
                  "baremetal_core_volume_attachment.bosh_cli_vol_attach"]
    provisioner "remote-exec" {
      connection {
        agent = false
        timeout = "30m"
        host = "${data.baremetal_core_vnic.InstanceVnic.public_ip_address}"
        user = "opc"
        private_key = "${var.bosh_ssh_private_key}"
    }
    inline = [
        "touch ~/IMadeAFile.Right.Here",
        "sudo iscsiadm -m node -o new -T ${baremetal_core_volume_attachment.bosh_cli_vol_attach.iqn} -p ${baremetal_core_volume_attachment.bosh_cli_vol_attach.ipv4}:${baremetal_core_volume_attachment.bosh_cli_vol_attach.port}",
        "sudo iscsiadm -m node -o update -T ${baremetal_core_volume_attachment.bosh_cli_vol_attach.iqn} -n node.startup -v automatic",
        "echo sudo iscsiadm -m node -T ${baremetal_core_volume_attachment.bosh_cli_vol_attach.iqn} -p ${baremetal_core_volume_attachment.bosh_cli_vol_attach.ipv4}:${baremetal_core_volume_attachment.bosh_cli_vol_attach.port} -l >> ~/.bashrc"]
    }
}
