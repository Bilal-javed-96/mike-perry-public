variable "source_efs" {
    description = "Source EFS Filesystem ID"
}
#variable "destination_efs" {
#    description = "Destination EFS Filesystem ID"
#}
variable "source_subnet_id"{
    description = "Source Subnet EFS Subnet ID"
}
variable "destination_subnet_id"{
    description = "Destination Subnet EFS Subnet ID"
}
variable "source_efs_sg_id" {
    description = "Source EFS Security Group ID"
}
variable "destination_efs_sg_id"{
    description = "Destination EFS Security Group ID"
}
variable "sync_cron_expression"{
    description = "Cron Expression for EFS Sync"
    default = "0/60 * * * ? *"
}
variable "dest_efs_arn" {
    description = "ARN of Destination Filesystem"
  
}
