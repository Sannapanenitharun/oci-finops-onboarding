data "oci_objectstorage_namespace" "ns" {}

# Object Storage Bucket
resource "oci_objectstorage_bucket" "finops_bucket" {
  name           = var.bucket_name
  namespace      = data.oci_objectstorage_namespace.ns.namespace
  compartment_id = var.tenancy_ocid

  access_type  = "NoPublicAccess"
  storage_tier = "Standard"
}

# User
resource "oci_identity_user" "finops_user" {
  name           = var.user_name
  compartment_id = var.tenancy_ocid
}

# Group
resource "oci_identity_group" "finops_group" {
  name           = var.group_name
  compartment_id = var.tenancy_ocid
}

# Membership
resource "oci_identity_user_group_membership" "membership" {
  user_id  = oci_identity_user.finops_user.id
  group_id = oci_identity_group.finops_group.id
}

# API Key
resource "oci_identity_api_key" "api_key" {
  user_id   = oci_identity_user.finops_user.id
  key_value = var.public_key
}

# Policy
resource "oci_identity_policy" "finops_policy" {
  name           = "finops-read-policy-${var.user_name}"
  compartment_id = var.tenancy_ocid

  statements = [
    "Allow group ${var.group_name} to inspect all-resources in tenancy",
    "Allow group ${var.group_name} to read usage-report in tenancy",
    "Allow group ${var.group_name} to read compartments in tenancy",
    "Allow group ${var.group_name} to read tag-namespaces in tenancy",
    "Allow group ${var.group_name} to read metrics in tenancy"
  ]
}
