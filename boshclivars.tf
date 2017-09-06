resource "local_file"  bosh-env-vars {
  depends_on = ["baremetal_core_instance.bosh_cli"]

  filename = "./bootstrap/my-env-vars.yml"
  content = <<EOF
tenancy: ${var.oracle_bmcs_tenancy_ocid}
user: ${baremetal_identity_user.bosh_user.id}
compartment: ${baremetal_identity_compartment.bosh_compartment.id}
apikey: |
${file(var.bosh_api_private_key)}
fingerprint: ${file(var.bosh_api_fingerprint)}
ssh_key: ${file(var.bosh_ssh_public_key)}
ad1: ${baremetal_core_subnet.private_subnet_ad1.availability_domain}
ad1: ${baremetal_core_subnet.private_subnet_ad2.availability_domain}
subnet1: ${baremetal_core_subnet.private_subnet_ad1.display_name}
subnet2: ${baremetal_core_subnet.private_subnet_ad2.display_name}
internal_cidr_n1: ${baremetal_core_subnet.private_subnet_ad1.cidr_block}
internal_cidr_n2: ${baremetal_core_subnet.private_subnet_ad2.cidr_block}

EOF

}

resource "null_resource" "copy-env-vars" {
  depends_on = ["local_file.bosh-env-vars"]

  provisioner "file" {
    connection {
      agent = false
      timeout = "30m"
      host = "${data.baremetal_core_vnic.InstanceVnic.public_ip_address}"
      user = "ubuntu"
      private_key = "${file(var.bosh_ssh_private_key)}"
    }
    source = "${local_file.bosh-env-vars.filename}"
    destination = "~/my-env-vars.yml"
  }
}