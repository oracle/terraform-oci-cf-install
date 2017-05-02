/*
output "CloudFoundryVCNID" {
    value = ["${data.baremetal_core_virtual_network.CloudFoundryVCN.id}"]
}
*/

output "InstancePrivateIP" {
    value = ["${data.baremetal_core_vnic.InstanceVnic.private_ip_address}"]
}

output "InstancePublicIP" {
    value = ["${data.baremetal_core_vnic.InstanceVnic.public_ip_address}"]
}
