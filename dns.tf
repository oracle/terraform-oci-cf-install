/*
resource "dyn_record" "cname" {
    zone  = "example.com"
    name  = "myapp"
    value = "other-name.example.com."
    type  = "CNAME"
    ttl   = 300
}

resource "dyn_record" "foobar" {
    zone  = "${var.dyn_zone}"
    name  = "terraform"
    value = "192.168.0.11"
    type  = "A"
    ttl   = 3600
}
*/
