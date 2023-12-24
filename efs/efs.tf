resource "aws_efs_file_system" "efs" {
   creation_token = var.creation_token
   performance_mode = "generalPurpose"
   throughput_mode = "bursting"
   #availability_zone_name = ["ca-central-1a","ca-central-1b","ca-central-1c","ca-central-1d"]
   encrypted = "true"
 tags = {
     Name = "EFS"
   }
 }


resource "aws_efs_mount_target" "efs-mt" {
   file_system_id  = aws_efs_file_system.efs.id
   subnet_id = "${var.subnet_ida}"
   security_groups = [aws_security_group.allow_efs.id]
 }
 resource "aws_efs_mount_target" "efs-mtb" {
   file_system_id  = aws_efs_file_system.efs.id
   subnet_id = "${var.subnet_idb}"
   security_groups = [aws_security_group.allow_efs.id]
 }

 resource "aws_efs_mount_target" "efs-mtd" {
   file_system_id  = aws_efs_file_system.efs.id
   subnet_id = "${var.subnet_idd}"
   security_groups = [aws_security_group.allow_efs.id]
 }
 resource "aws_security_group" "allow_efs" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description      = "DB access from VPC"
    from_port        = 2049
    to_port          = 2049
    protocol         = "tcp"
    cidr_blocks      = [var.vpc_cidr]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_efs"
  }
}