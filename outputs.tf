output "tenancy_ocid" {
  value = var.tenancy_ocid
}

output "user_ocid" {
  value = oci_identity_user.finops_user.id
}

output "fingerprint" {
  value = oci_identity_api_key.api_key.fingerprint
}

output "region" {
  value = var.region
}

output "bucket_name" {
  value = oci_objectstorage_bucket.finops_bucket.name
}
