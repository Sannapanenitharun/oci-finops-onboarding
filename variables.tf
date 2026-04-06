variable "tenancy_ocid" {
  description = "OCI Tenancy OCID"
}

variable "region" {
  default = "us-ashburn-1"
}

variable "bucket_name" {
  description = "Object Storage bucket name"
}

variable "user_name" {
  default = "finops-user"
}

variable "group_name" {
  default = "finops-group"
}

variable "public_key" {
  description = "Public key for API key authentication"
}
