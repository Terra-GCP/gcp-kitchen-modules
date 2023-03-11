variable "bucket_name" {
  description = "Cloud storage bucket name"
  type        = string
}

variable "project_id" {
  description = "Bucket project id."
  type        = string
}

variable "gcs_location" {
  description = "Bucket location."
  type        = string
}

variable "storage_class" {
  description = "Bucket storage class."
  type        = string
  default     = "STANDARD"
}

variable "labels" {
  description = "Labels to be attached to the buckets"
  type        = map(string)
  default     = {}
}

variable "enable_versioning" {
  description = "Optional map of lowercase unprefixed name => boolean, defaults to false."
  type        = bool
  default     = true
}

variable "force_destroy" {
  description = "When deleting a bucket, this boolean option will delete all contained objects"
  type        = bool
}

variable "public_access_prevention" {
  description = "Prevents public access to a bucket"
  type        = string
}
