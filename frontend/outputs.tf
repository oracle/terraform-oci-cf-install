output "cf_load_balancer_public_ip" {
  value = ["${baremetal_load_balancer.cf_load_balancer.ip_addresses}"]
}
