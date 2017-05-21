resource "baremetal_core_virtual_network" "CloudFoundryVCN" {
    cidr_block = "${var.VPC-CIDR}"
    compartment_id = "${baremetal_identity_compartment.bosh_compartment.id}"
    display_name = "CloudFoundryVCN"
    dns_label = "cfvcn"
}

resource "baremetal_core_internet_gateway" "CloudFoundryIG" {
    compartment_id = "${baremetal_identity_compartment.bosh_compartment.id}"
    display_name = "CloudFoundryIG"
    vcn_id = "${baremetal_core_virtual_network.CloudFoundryVCN.id}"
}

resource "baremetal_core_route_table" "CloudFoundryRouteTable" {
    compartment_id = "${baremetal_identity_compartment.bosh_compartment.id}"
    vcn_id = "${baremetal_core_virtual_network.CloudFoundryVCN.id}"
    display_name = "CloudFoundryRouteTable"
    route_rules {
        cidr_block = "0.0.0.0/0"
        network_entity_id = "${baremetal_core_internet_gateway.CloudFoundryIG.id}"
    }
}

resource "baremetal_core_security_list" "PublicSubnet" {
    compartment_id = "${baremetal_identity_compartment.bosh_compartment.id}"
    display_name = "Public"
    vcn_id = "${baremetal_core_virtual_network.CloudFoundryVCN.id}"
    egress_security_rules = [{
        destination = "0.0.0.0/0"
        protocol = "6"
    }]
    ingress_security_rules = [{
        tcp_options {
            "max" = 80
            "min" = 80
        }
        protocol = "6"
        source = "0.0.0.0/0"
    },
    {
        tcp_options {
            "max" = 443
            "min" = 443
        }
        protocol = "6"
        source = "0.0.0.0/0"
    },
    {
        tcp_options {
            "max" = 4443
            "min" = 4443
        }
        protocol = "6"
        source = "0.0.0.0/0"
    },
    # TODO: Is this needed? Seems like this is covered by PrivateSubnet.
    {
        protocol = "6"
        source = "${var.VPC-CIDR}"
    }]
}

resource "baremetal_core_security_list" "PrivateSubnetAD1" {
    compartment_id = "${baremetal_identity_compartment.bosh_compartment.id}"
    display_name = "Private"
    vcn_id = "${baremetal_core_virtual_network.CloudFoundryVCN.id}"
    egress_security_rules = [{
        protocol = "6"
        destination = "${var.VPC-CIDR}"
    }]
    # TODO: Does this cover ICMP as well? Seems so.
    ingress_security_rules = [{
        protocol = "6"
        source = "${var.PrivateSubnetAD1-CIDR}"
    },
    {
        tcp_options {
            "max" = 22
            "min" = 22
        }
        protocol = "6"
        source = "${var.BastionSubnetAD1-CIDR}"
    },
    {
        tcp_options {
            "max" = 6868
            "min" = 6868
        }
        protocol = "6"
        source = "{var.BastionSubnetAD1-CIDR}"
    },
    {
        tcp_options {
            "max" = 25555
            "min" = 25555
        }
        protocol = "6"
        source = "{var.BastionSubnetAD1-CIDR}"
    }]
}

resource "baremetal_core_security_list" "PrivateSubnetAD2" {
    compartment_id = "${baremetal_identity_compartment.bosh_compartment.id}"
    display_name = "Private"
    vcn_id = "${baremetal_core_virtual_network.CloudFoundryVCN.id}"
    egress_security_rules = [{
        protocol = "6"
        destination = "${var.VPC-CIDR}"
    }]
    # TODO: Does this cover ICMP as well? Seems so.
    ingress_security_rules = [{
        protocol = "6"
        source = "${var.PrivateSubnetAD2-CIDR}"
    },
    {
        tcp_options {
            "max" = 22
            "min" = 22
        }
        protocol = "6"
        source = "${var.BastionSubnetAD2-CIDR}"
    },
    {
        tcp_options {
            "max" = 6868
            "min" = 6868
        }
        protocol = "6"
        source = "{var.BastionSubnetAD2-CIDR}"
    },
    {
        tcp_options {
            "max" = 25555
            "min" = 25555
        }
        protocol = "6"
        source = "{var.BastionSubnetAD2-CIDR}"
    }]
}

resource "baremetal_core_security_list" "PrivateSubnetAD3" {
    compartment_id = "${baremetal_identity_compartment.bosh_compartment.id}"
    display_name = "Private"
    vcn_id = "${baremetal_core_virtual_network.CloudFoundryVCN.id}"
    egress_security_rules = [{
        protocol = "6"
        destination = "${var.VPC-CIDR}"
    }]
    # TODO: Does this cover ICMP as well? Seems so.
    ingress_security_rules = [{
        protocol = "6"
        source = "${var.PrivateSubnetAD3-CIDR}"
    },
    {
        tcp_options {
            "max" = 22
            "min" = 22
        }
        protocol = "6"
        source = "${var.BastionSubnetAD3-CIDR}"
    },
    {
        tcp_options {
            "max" = 6868
            "min" = 6868
        }
        protocol = "6"
        source = "{var.BastionSubnetAD3-CIDR}"
    },
    {
        tcp_options {
            "max" = 25555
            "min" = 25555
        }
        protocol = "6"
        source = "{var.BastionSubnetAD1-CIDR}"
    }]
}

resource "baremetal_core_security_list" "BastionSubnet" {
    compartment_id = "${baremetal_identity_compartment.bosh_compartment.id}"
    display_name = "Bastion"
    vcn_id = "${baremetal_core_virtual_network.CloudFoundryVCN.id}"
    egress_security_rules = [{
        protocol = "6"
        destination = "0.0.0.0/0"
    }]
    ingress_security_rules = [{
        tcp_options {
            "max" = 22
            "min" = 22
        }
        protocol = "6"
        source = "0.0.0.0/0"
    },
    {
        protocol = "6"
        source = "${var.VPC-CIDR}"
    }]
}

# TODO: Make whitespace consistent
resource "baremetal_core_subnet" "PublicSubnetAD1" {
  availability_domain = "${lookup(data.baremetal_identity_availability_domains.ADs.availability_domains[0], "name")}"
  cidr_block = "${var.PublicSubnetAD1-CIDR}"
  display_name = "PublicSubnetAD1"
  dns_label = "cfwebad1"
  compartment_id = "${baremetal_identity_compartment.bosh_compartment.id}"
  vcn_id = "${baremetal_core_virtual_network.CloudFoundryVCN.id}"
  route_table_id = "${baremetal_core_route_table.CloudFoundryRouteTable.id}"
  security_list_ids = ["${baremetal_core_security_list.PublicSubnet.id}"]
  provisioner "local-exec" {
    command = "echo Sleeping for 120 seconds...; sleep 120"
  }
}

resource "baremetal_core_subnet" "PrivateSubnetAD1" {
  availability_domain = "${lookup(data.baremetal_identity_availability_domains.ADs.availability_domains[0], "name")}"
  cidr_block = "${var.PrivateSubnetAD1-CIDR}"
  display_name = "PrivateSubnetAD1"
  dns_label = "cfprvad1"
  compartment_id = "${baremetal_identity_compartment.bosh_compartment.id}"
  vcn_id = "${baremetal_core_virtual_network.CloudFoundryVCN.id}"
  route_table_id = "${baremetal_core_route_table.CloudFoundryRouteTable.id}"
  security_list_ids = ["${baremetal_core_security_list.PrivateSubnetAD1.id}",
                       "${baremetal_core_security_list.PrivateSubnetAD2.id}",
                       "${baremetal_core_security_list.PrivateSubnetAD3.id}"]
  provisioner "local-exec" {
    command = "echo Sleeping for 120 seconds...; sleep 120"
  }
}

resource "baremetal_core_subnet" "BastionSubnetAD1" {
  availability_domain = "${lookup(data.baremetal_identity_availability_domains.ADs.availability_domains[0], "name")}"
  cidr_block = "${var.BastionSubnetAD1-CIDR}"
  display_name = "BastionSubnetAD1"
  dns_label = "cfbstad1"
  compartment_id = "${baremetal_identity_compartment.bosh_compartment.id}"
  vcn_id = "${baremetal_core_virtual_network.CloudFoundryVCN.id}"
  route_table_id = "${baremetal_core_route_table.CloudFoundryRouteTable.id}"
  security_list_ids = ["${baremetal_core_security_list.BastionSubnet.id}"]
  provisioner "local-exec" {
    command = "echo Sleeping for 120 seconds...; sleep 120"
  }
}

resource "baremetal_core_subnet" "PublicSubnetAD2" {
  availability_domain = "${lookup(data.baremetal_identity_availability_domains.ADs.availability_domains[1], "name")}"
  cidr_block = "${var.PublicSubnetAD2-CIDR}"
  display_name = "PublicSubnetAD2"
  dns_label = "cfwebad2"
  compartment_id = "${baremetal_identity_compartment.bosh_compartment.id}"
  vcn_id = "${baremetal_core_virtual_network.CloudFoundryVCN.id}"
  route_table_id = "${baremetal_core_route_table.CloudFoundryRouteTable.id}"
  security_list_ids = ["${baremetal_core_security_list.PublicSubnet.id}"]
  provisioner "local-exec" {
    command = "echo Sleeping for 120 seconds...; sleep 120"
  }
}

resource "baremetal_core_subnet" "PrivateSubnetAD2" {
  availability_domain = "${lookup(data.baremetal_identity_availability_domains.ADs.availability_domains[1], "name")}"
  cidr_block = "${var.PrivateSubnetAD2-CIDR}"
  display_name = "PrivateSubnetAD2"
  dns_label = "cfprvad2"
  compartment_id = "${baremetal_identity_compartment.bosh_compartment.id}"
  vcn_id = "${baremetal_core_virtual_network.CloudFoundryVCN.id}"
  route_table_id = "${baremetal_core_route_table.CloudFoundryRouteTable.id}"
  security_list_ids = ["${baremetal_core_security_list.PrivateSubnetAD1.id}",
                       "${baremetal_core_security_list.PrivateSubnetAD2.id}",
                       "${baremetal_core_security_list.PrivateSubnetAD3.id}"]
  provisioner "local-exec" {
    command = "echo Sleeping for 120 seconds...; sleep 120"
  }
}

resource "baremetal_core_subnet" "BastionSubnetAD2" {
  availability_domain = "${lookup(data.baremetal_identity_availability_domains.ADs.availability_domains[1], "name")}"
  cidr_block = "${var.BastionSubnetAD2-CIDR}"
  display_name = "BastionSubnetAD2"
  dns_label = "cfbstad2"
  compartment_id = "${baremetal_identity_compartment.bosh_compartment.id}"
  vcn_id = "${baremetal_core_virtual_network.CloudFoundryVCN.id}"
  route_table_id = "${baremetal_core_route_table.CloudFoundryRouteTable.id}"
  security_list_ids = ["${baremetal_core_security_list.PrivateSubnetAD1.id}",
                       "${baremetal_core_security_list.PrivateSubnetAD2.id}",
                       "${baremetal_core_security_list.PrivateSubnetAD3.id}"]
  provisioner "local-exec" {
    command = "echo Sleeping for 120 seconds...; sleep 120"
  }
}

resource "baremetal_core_subnet" "PublicSubnetAD3" {
  availability_domain = "${lookup(data.baremetal_identity_availability_domains.ADs.availability_domains[2], "name")}"
  cidr_block = "${var.PublicSubnetAD3-CIDR}"
  display_name = "PublicSubnetAD3"
  dns_label = "cfwebad3"
  compartment_id = "${baremetal_identity_compartment.bosh_compartment.id}"
  vcn_id = "${baremetal_core_virtual_network.CloudFoundryVCN.id}"
  route_table_id = "${baremetal_core_route_table.CloudFoundryRouteTable.id}"
  security_list_ids = ["${baremetal_core_security_list.PublicSubnet.id}"]
  provisioner "local-exec" {
    command = "echo Sleeping for 120 seconds...; sleep 120"
  }
}
resource "baremetal_core_subnet" "PrivateSubnetAD3" {
  availability_domain = "${lookup(data.baremetal_identity_availability_domains.ADs.availability_domains[2], "name")}"
  cidr_block = "${var.PrivateSubnetAD3-CIDR}"
  display_name = "PrivateSubnetAD3"
  dns_label = "cfprvad3"
  compartment_id = "${baremetal_identity_compartment.bosh_compartment.id}"
  vcn_id = "${baremetal_core_virtual_network.CloudFoundryVCN.id}"
  route_table_id = "${baremetal_core_route_table.CloudFoundryRouteTable.id}"
  security_list_ids = ["${baremetal_core_security_list.PrivateSubnet.id}"]
  provisioner "local-exec" {
    command = "echo Sleeping for 120 seconds...; sleep 120"
  }
}

resource "baremetal_core_subnet" "BastionSubnetAD3" {
  availability_domain = "${lookup(data.baremetal_identity_availability_domains.ADs.availability_domains[2], "name")}"
  cidr_block = "${var.BastionSubnetAD3-CIDR}"
  display_name = "BastionSubnetAD3"
  dns_label = "cfbstad3"
  compartment_id = "${baremetal_identity_compartment.bosh_compartment.id}"
  vcn_id = "${baremetal_core_virtual_network.CloudFoundryVCN.id}"
  route_table_id = "${baremetal_core_route_table.CloudFoundryRouteTable.id}"
  security_list_ids = ["${baremetal_core_security_list.BastionSubnet.id}"]
  provisioner "local-exec" {
    command = "echo Sleeping for 120 seconds...; sleep 120"
  }
}
