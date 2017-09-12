resource "baremetal_load_balancer" "cf_load_balancer" {
    compartment_id = "ocid1.compartment.oc1..aaaaaaaaectl7xrrmv3sy5eyhn3bjw3rcogtphz5i2wzqms22k4olgfs6voa"
    display_name   = "cf_load_balancer"
    shape          = "${var.cf_load_balancer_shape}"
    subnet_ids     = [
      "${var.public_subnet_ad1_id}",
      "${var.public_subnet_ad2_id}"
    ]
}

# TODO: Do we need port 80 open for private subnets or only 8080?
# https://docs.cloudfoundry.org/adminguide/configure-lb-healthcheck.html
resource "baremetal_load_balancer_backendset" "cf_load_balancer_backendset" {
    name             = "cf_load_balancer_backendset"
    load_balancer_id = "${baremetal_load_balancer.cf_load_balancer.id}"
    policy           = "ROUND_ROBIN"

    health_checker {
        port     = "8080"
        protocol = "HTTP"
        response_body_regex = ".*"
        url_path = "/health"
    }
}

resource "baremetal_load_balancer_certificate" "cf_load_balancer_cert" {
  load_balancer_id   = "${baremetal_load_balancer.cf_load_balancer.id}"
  certificate_name   = "cf_load_balancer_cert"
  ca_certificate     = ""
  private_key        = "${file(var.cf_load_balancer_private_key)}"
  public_certificate = "${file(var.cf_load_balancer_public_cert)}"
}

#resource "baremetal_load_balancer_listener" "cf_load_balancer_listen_http" {
#  load_balancer_id   = "${baremetal_load_balancer.cf_load_balancer.id}"
#  name                     = "http"
#  default_backend_set_name = "${baremetal_load_balancer_backendset.lb-bes1.id}"
#  port                     = 80
#  protocol                 = "HTTP"
#}

#resource "baremetal_load_balancer_listener" "lb-listener2" {
#  load_balancer_id   = "${baremetal_load_balancer.cf_load_balancer.id}"
#  name                     = "https"
#  default_backend_set_name = "${baremetal_load_balancer_backendset.lb-bes1.id}"
#  port                     = 443
#  protocol                 = "HTTP"

#  ssl_configuration {
#    certificate_name        = "${baremetal_load_balancer_certificate.lb-cert1.certificate_name}"
#    verify_peer_certificate = false
#  }
#}

# TODO: Add port 4443

#resource "baremetal_load_balancer_backend" "lb-be1" {
#  load_balancer_id = "${baremetal_load_balancer.lb1.id}"
#  backendset_name  = "${baremetal_load_balancer_backendset.lb-bes1.id}"
#  ip_address       = "${baremetal_core_instance.instance1.private_ip}"
#  port             = 80
#  backup           = false
#  drain            = false
#  offline          = false
#  weight           = 1
#}

#resource "baremetal_load_balancer_backend" "lb-be2" {
#  load_balancer_id = "${baremetal_load_balancer.lb1.id}"
#  backendset_name  = "${baremetal_load_balancer_backendset.lb-bes1.id}"
#  ip_address       = "${baremetal_core_instance.instance2.private_ip}"
#  port             = 80
#  backup           = false
#  drain            = false
#  offline          = false
#  weight           = 1
#}

