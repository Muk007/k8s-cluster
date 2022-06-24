variable "cidr" {
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  type        = string
  default     = "10.0.1.0/24"
}

variable "avail_zone" {
  type        = string
  default     = "us-east-1a"
}

variable "global_ip" {
  type        = string
  default     = "0.0.0.0/0"
}

variable "vpc_name" {
  type        = string
  description = "Customer or Your name"
}

variable "namespace" {
  type        = string
  default     = "local"
  description = "Namespace"
}

variable "stage" {
  description = "Stage"
  default     = "sandbox"
  type        = string
}
