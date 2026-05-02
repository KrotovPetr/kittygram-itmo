resource "yandex_vpc_network" "infra_network" {
  name = var.vpc_name
}

resource "yandex_vpc_subnet" "infra_subnet" {
  for_each       = { for n in var.net_cidr : n.name => n }
  name           = each.value.name
  zone           = each.value.zone
  v4_cidr_blocks = [each.value.prefix]
  network_id     = yandex_vpc_network.infra_network.id
}

resource "yandex_vpc_security_group" "infra_sg" {
  name       = "${var.vpc_name}-sg"
  network_id = yandex_vpc_network.infra_network.id

  egress {
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol       = "TCP"
    port           = 22
    v4_cidr_blocks = ["0.0.0.0/0"]
    description    = "SSH access"
  }

  ingress {
    protocol       = "TCP"
    port           = 80
    v4_cidr_blocks = ["0.0.0.0/0"]
    description    = "HTTP traffic"
  }
}