variable "vpc_cidr" {
  description = "CIDR For VPC"
  default = "10.0.0.0/16"
}
variable "vpc_subnet_a_cidr" {
  description = "CIDR for Subnets"
  default = "10.0.0.0/24"
}
variable "vpc_subnet_b_cidr" {
  description = "CIDR for Subnets"
  default = "10.0.1.0/24"
}
variable "vpc_subnet_c_cidr" {
  description = "CIDR for Subnets"
  default = "10.0.2.0/24"
}
variable "vpc_subnet_d_cidr" {
  description = "CIDR for Subnets"
  default = "10.0.3.0/24"
}
variable "vpc_id" {
  
}