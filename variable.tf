variable "vpc_cidr" {
  description = "VPC CIDR"
}
variable "subnet_a_cidr"{
    description = "Subnet A CIDR"
}
variable "subnet_b_cidr"{
    description = "Subnet B CIDR"
}
variable "subnet_c_cidr"{
    description = "Subnet C CIDR"
}
variable "subnet_d_cidr"{
    description = "Subnet D CIDR"
}
variable "creation_token"{
    description = "Token for EFS"
}
variable "ami_id" {
  description = ""
}
variable "key_name" {
  description = ""
}
variable "instance_type" {
  description = ""  
  default = "t2.micro"
}
variable "instance_class" {
  description = ""
  default = "db.t2.micro"
}
variable "snapshot_id" {
  description = ""
}
variable "db_name" {
  description = ""
  default = "web-mariadb-zeus"
}
variable "region" {
  
}
variable "profile_name" {
  
}
variable "vpc_id" {
  
}
variable "source_instance_id" {
  
}
variable "ec2_name" {
  
}
variable "sub_pub_a_id" {
}
variable "sub_pub_b_id" {
}
variable "sub_pri_a_id" {
}
variable "sub_pri_b_id" {
}
variable "user_name" {
}
variable "db_pass" {
}
variable "zone_id" {
  
}
