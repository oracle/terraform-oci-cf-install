resource "local_file"  bosh_cli_env_vars {
  depends_on = ["baremetal_core_instance.bosh_cli"]

  filename = "./bootstrap/my-env-vars.yml"
  content = <<EOF
tenancy: ${var.oracle_bmcs_tenancy_ocid}
user: ${baremetal_identity_user.bosh_user.id}
compartment: ${baremetal_identity_compartment.bosh_compartment.id}
apikey: |${format("\n   %s",join("\n   ", split("\n", file(var.bosh_api_private_key))))}
fingerprint: ${file(var.bosh_api_fingerprint)}
ssh_key: ${file(var.bosh_ssh_public_key)}
ad1: ${baremetal_core_subnet.private_subnet_ad1.availability_domain}
ad1: ${baremetal_core_subnet.private_subnet_ad2.availability_domain}
subnet1: ${baremetal_core_subnet.private_subnet_ad1.display_name}
subnet2: ${baremetal_core_subnet.private_subnet_ad2.display_name}
internal_cidr_n1: ${baremetal_core_subnet.private_subnet_ad1.cidr_block}
internal_cidr_n2: ${baremetal_core_subnet.private_subnet_ad2.cidr_block}
internal_gw_n1: ${cidrhost(baremetal_core_subnet.private_subnet_ad1.cidr_block, 1)}
internal_gw_n2: ${cidrhost(baremetal_core_subnet.private_subnet_ad2.cidr_block, 1)}
EOF

}

resource "local_file"  bosh_cli_director_env_vars {
  depends_on = ["baremetal_core_instance.bosh_cli"]

  filename = "./bootstrap/director-env-vars.yml"
  content = <<EOF
tenancy: ${var.oracle_bmcs_tenancy_ocid}
user: ${baremetal_identity_user.bosh_user.id}
compartment: ${baremetal_identity_compartment.bosh_compartment.id}
apikey: |${format("\n   %s",join("\n   ", split("\n", file(var.bosh_api_private_key))))}
fingerprint: ${file(var.bosh_api_fingerprint)}
provisioned_username: ${var.bosh_ssh_username}
ssh_key: ${file(var.bosh_ssh_public_key)}
region: ${var.oracle_bmcs_region}
ad1: ${baremetal_core_subnet.director_subnet_ad1.availability_domain}
vcn: ${baremetal_core_virtual_network.cloudfoundry_vcn.display_name}
subnet: ${baremetal_core_subnet.director_subnet_ad1.display_name}
internal_cidr: ${baremetal_core_subnet.director_subnet_ad1.cidr_block}
internal_gw: ${cidrhost(baremetal_core_subnet.director_subnet_ad1.cidr_block, 1)}
internal_ip: ${cidrhost(baremetal_core_subnet.director_subnet_ad1.cidr_block, 2)}
admin_password: admin
blobstore_agent_password: agent1
blobstore_director_password: director1
director_name: bosh-director
hm_password: hm1
mbus_bootstrap_password: mbus-secret
nats_password: nats-secret
postgres_password: postgres
EOF
}

resource "null_resource" "copy-env-vars" {
  depends_on = ["local_file.bosh_cli_env_vars", "local_file.bosh_cli_director_env_vars"]

  connection {
    agent = false
    timeout = "2m"
    host = "${data.baremetal_core_vnic.InstanceVnic.public_ip_address}"
    user = "ubuntu"
    private_key = "${file(var.bosh_ssh_private_key)}"
  }

  provisioner "file" {
    source = "${local_file.bosh_cli_env_vars.filename}"
    destination = "~/${basename(local_file.bosh_cli_env_vars.filename)}"
  }

  provisioner "file" {
    source = "${local_file.bosh_cli_director_env_vars.filename}"
    destination = "~/${basename(local_file.bosh_cli_director_env_vars.filename)}"
  }
}