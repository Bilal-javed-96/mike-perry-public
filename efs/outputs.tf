output "efs_id" {
  value = aws_efs_file_system.efs.id
}
output "efs_dns" {
  value = aws_efs_mount_target.efs-mt.dns_name
}
output "efs_mount_dns" {
  value = aws_efs_mount_target.efs-mt.mount_target_dns_name
}
output "efs_sg_id" {
  value = aws_security_group.allow_efs.id
}
output "efs_arn" {
  value = aws_efs_file_system.efs.arn
}