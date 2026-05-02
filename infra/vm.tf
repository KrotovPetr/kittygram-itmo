data "yandex_compute_image" "os" {
  family = var.image_family
}

resource "yandex_compute_instance" "vm_1" {
  name        = var.vm_1_name
  hostname    = var.vm_1_name
  zone        = var.zone
  platform_id = var.platform_id

  labels = {
    project     = "kittygram"
    environment = var.environment
  }

  allow_stopping_for_update = true

  resources {
    cores         = var.cores
    memory        = var.memory
    core_fraction = var.core_fraction
  }

  boot_disk {
    initialize_params {
      type     = var.disk_type
      size     = var.disk_size
      image_id = data.yandex_compute_image.os.id
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.infra_subnet["infra-subnet-a"].id
    nat                = var.nat
    security_group_ids = [yandex_vpc_security_group.infra_sg.id]
  }

  metadata = {
    serial-port-enable = "1"
    user-data = templatefile("${path.module}/init/vm-install.yml", {
      SSH_KEY = var.ssh_key
    })
  }

  lifecycle {
    create_before_destroy = true
  }
}
