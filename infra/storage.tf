resource "yandex_storage_bucket" "tf_state" {
  bucket = "itmo-test"

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

  force_destroy = false
}

resource "yandex_storage_bucket_acl" "tf_state_acl" {
  bucket = yandex_storage_bucket.tf_state.bucket
  acl    = "private"
}
