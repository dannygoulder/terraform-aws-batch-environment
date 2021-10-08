variable "vpc_id" {
  description = "VPC identifier in which to launch the CE"
  type        = string
}

variable "ce_name" {
  description = "Name of the CE to create"
  type        = string
}

variable "instance_type" {
  description = "Instance type to create in the CE"
  type        = string
  default     = "optimal"
}

variable "max_vcpu" {
  description = "The maximum number of vCPUs for the CE to reach"
  type        = number
  default     = 32
}

variable "min_vcpu" {
  description = "The minimum number of vCPUs for the CE to maintain, even if disabled"
  type        = number
  default     = 0
}

variable "desired_vcpu" {
  description = "The desired number of vCPUs for the CE. Actual usage will vary based on demand"
  type        = number
  default     = 0
}

variable "container_properties" {
  description = "A valid JSON [container properties](https://docs.aws.amazon.com/batch/latest/APIReference/API_ContainerProperties.html) file"
}
