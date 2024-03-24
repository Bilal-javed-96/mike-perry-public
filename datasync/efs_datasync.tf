data "aws_efs_file_system" "source-efs" {
  file_system_id = var.source_efs
}
data "aws_subnet" "source" {
  id = "${var.source_subnet_id}"
}
data "aws_subnet" "dest" {
  id = "${var.destination_subnet_id}"
}
resource "aws_datasync_location_efs" "destination" {
  # The below example uses aws_efs_mount_target as a reference to ensure a mount target already exists when resource creation occurs.
  # You can accomplish the same behavior with depends_on or an aws_efs_mount_target data source reference.
  efs_file_system_arn = var.dest_efs_arn

  ec2_config {
    #security_group_arns = [aws_security_group.allow_efs.arn]
    security_group_arns = ["${var.destination_efs_sg_id}"]
    #subnet_arn          = data.aws_subnet.selected.arn
    subnet_arn = data.aws_subnet.dest.arn
  }
}
resource "aws_datasync_location_efs" "source" {
  # The below example uses aws_efs_mount_target as a reference to ensure a mount target already exists when resource creation occurs.
  # You can accomplish the same behavior with depends_on or an aws_efs_mount_target data source reference.
  efs_file_system_arn = data.aws_efs_file_system.source-efs.arn
  ec2_config {
    security_group_arns = ["${var.source_efs_sg_id}"]
    subnet_arn          = data.aws_subnet.source.arn
  }
}
resource "aws_datasync_task" "example" {
  destination_location_arn = aws_datasync_location_efs.destination.arn
  name                     = "test-replication"
  source_location_arn      = aws_datasync_location_efs.source.arn

  options {
    bytes_per_second = -1
  }
  schedule {
    schedule_expression = "cron(${var.sync_cron_expression})"
  }
  depends_on = [aws_datasync_location_efs.destination]
}
