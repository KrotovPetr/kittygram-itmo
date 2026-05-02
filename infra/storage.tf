resource "yandex_storage_bucket" "tf_state" {
  bucket = "kittygram-tf-state"
  acl    = "private"

  versioning {
    enabled = true
  }

  lifecycle_rule {
    id      = "retain-all"
    enabled = true
    noncurrent_version_expiration {
      days = 180
    }
  }

  labels = {
    project = "kittygram"
    purpose = "terraform-state"
  }

  force_destroy = false
}