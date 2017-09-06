output "CompartmentOCID" {
    value = ["${baremetal_identity_compartment.bosh_compartment.id}"]
}

output "InstancePrivateIP" {
    value = ["${data.baremetal_core_vnic.InstanceVnic.private_ip_address}"]
}

output "InstancePublicIP" {
    value = ["${data.baremetal_core_vnic.InstanceVnic.public_ip_address}"]
}