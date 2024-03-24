variable "vpc_cidr" {
  description = "VPC CIDR"
}
variable "subnet_id_a" {
  description = "subnet to deploy DB"
}
variable "subnet_id_b" {
  description = "subnet to deploy DB"
}
variable "vpc_id" {
  description = "VPC ID"
}
variable "db_name" {
  description = "DB Identifier"
}
variable "snapshot_id" {
  description = "DB snapshot ID"
}
variable "instance_class" {
  description = "DB Instance Type"
  default = "db.t2.micro"
}
variable "db_pass" {
}
variable "user_name" {
  
}