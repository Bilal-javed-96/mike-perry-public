output "vpc_p_id" {
  value = var.vpc_id
}

output "vpc_cidr" {
  value = data.aws_vpc.selected.cidr_block
}