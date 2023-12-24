resource "aws_db_instance" "default" {
  allocated_storage             = 20
  max_allocated_storage         = 50
  db_name                       = var.db_name
  engine                        = "mariadb"
  engine_version                = "10.6.14"
  instance_class                = var.instance_class
  username                      = var.user_name
  password                      = var.db_pass
  #manage_master_user_password   = true
  db_subnet_group_name          = aws_db_subnet_group.default.name
  snapshot_identifier           = var.snapshot_id
  publicly_accessible  = false  # Set to true if you want the RDS instance to be publicly accessible
  multi_az             = false
  vpc_security_group_ids = [aws_security_group.allow_db.id]
  skip_final_snapshot = true

}
resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = [var.subnet_id_a,var.subnet_id_b]

  tags = {
    Name = "My DB subnet group"
  }
}
resource "aws_security_group" "allow_db" {
  name        = "allow_db"
  description = "Allow TLS inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description      = "DB access from VPC"
    from_port        = 3306
    to_port          = 3306
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
    Name = "allow_db"
  }
}