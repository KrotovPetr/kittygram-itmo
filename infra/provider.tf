terraform {
  required_version = ">= 1.3.0"

  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "~> 0.109"
    }
  }

  backend "s3" {
    endpoint = "https://storage.yandexcloud.net"

    bucket = "itmo-test"
    region = "ru-central1"
    key    = "tf-state.tfstate"

    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
  }
}

provider "yandex" {
  service_account_key_file = "${path.module}/sa.json"
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.zone
}
