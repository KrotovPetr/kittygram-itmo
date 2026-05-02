variable "environment" {
  description = "Deployment environment tag (e.g. prod, stage, dev)"
  type        = string
  default     = "prod"
}

variable "vpc_name" {
  description = "VPC name"
  type        = string
  default     = "infra-network"
}

variable "net_cidr" {
  description = "List of subnets to create"
  type = list(object({
    name   = string
    zone   = string
    prefix = string
  }))
  default = [
    { name = "infra-subnet-a", zone = "ru-central1-a", prefix = "10.129.1.0/24" },
    { name = "infra-subnet-b", zone = "ru-central1-b", prefix = "10.130.1.0/24" },
    { name = "infra-subnet-d", zone = "ru-central1-d", prefix = "10.131.1.0/24" },
  ]
}

variable "vm_1_name" {
  description = "Name of the compute instance"
  type        = string
  default     = "vm-kittygram"
}

variable "ssh_key" {
  description = "Public SSH key to inject into the VM"
  type        = string
}

variable "cloud_id" {
  description = "Yandex Cloud ID"
  type        = string
}

variable "folder_id" {
  description = "Folder ID inside the cloud"
  type        = string
}

variable "sa_key_file" {
  description = "Path to service-account JSON key generated in workflow"
  type        = string
  default     = "authorized_key.json"
}

variable "platform_id" {
  description = "Instance platform"
  type        = string
  default     = "standard-v1"
}

variable "zone" {
  description = "Default availability zone"
  type        = string
  default     = "ru-central1-a"
}

variable "disk_type" {
  description = "Boot disk type"
  type        = string
  default     = "network-hdd"
}

variable "disk_size" {
  description = "Boot disk size in GiB"
  type        = number
  default     = 20
}

variable "cores" {
  description = "Number of vCPUs"
  type        = number
  default     = 2
}

variable "memory" {
  description = "RAM in GiB"
  type        = number
  default     = 2
}

variable "core_fraction" {
  description = "Guaranteed CPU percentage"
  type        = number
  default     = 20
  validation {
    condition     = var.core_fraction == 5 || var.core_fraction == 20 || var.core_fraction == 50 || var.core_fraction == 100
    error_message = "core_fraction must be 5, 20, 50 or 100."
  }
}

variable "nat" {
  description = "Whether to assign external IPv4 address"
  type        = bool
  default     = true
}

variable "image_family" {
  description = "Image family to use for the VM"
  type        = string
  default     = "ubuntu-2404-lts-oslogin"
}