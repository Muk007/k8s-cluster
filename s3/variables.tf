variable "vpc_name" {
  type        = string
  description = "Customer or Your name"
}

variable "namespace" {
  type        = string
  default     = "local"
  description = "Namespace for labels"
}
