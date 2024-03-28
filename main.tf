module "vpc" {
  source     = "./vpc"
  vpc_id = var.vpc_id
  vpc_cidr = var.vpc_cidr
  vpc_subnet_a_cidr = var.subnet_a_cidr
  vpc_subnet_b_cidr = "10.0.2.0/24"
  vpc_subnet_c_cidr = "10.0.3.0/24"
  vpc_subnet_d_cidr = "10.0.4.0/24"

}
module "db" {
  source     = "./db"
  vpc_cidr = module.vpc.vpc_cidr
  vpc_id = module.vpc.vpc_p_id
  subnet_id_a = var.sub_pri_a_id
  subnet_id_b = var.sub_pri_b_id
  db_name = var.db_name
  db_pass = var.db_pass
  user_name = var.user_name
  snapshot_id= var.snapshot_id
  instance_class = var.instance_class
  depends_on = [ module.vpc ]
}

module "efs" {
  source     = "./efs"
  vpc_cidr = module.vpc.vpc_cidr
  subnet_ida = var.sub_pub_b_id
  subnet_idb = var.sub_pub_a_id
  subnet_idc = var.sub_pri_b_id
  subnet_idd = var.sub_pri_a_id
  creation_token = var.creation_token
  vpc_id = module.vpc.vpc_p_id
  #clesource_efs = var.source_efs
  #source_efs-sg=var.source_efs-sg

}
module "datasync" {
  source     = "./datasync"
  source_efs             =  var.source_efs 
  #destination_efs        =  module.efs.efs_id
  source_subnet_id       =  var.sub_pub_b_id
  destination_subnet_id  =  var.sub_pub_b_id
  source_efs_sg_id       =  "arn:aws:ec2:${var.region}:990779155717:security-group/${var.source_efs-sg}"
  destination_efs_sg_id  =  "arn:aws:ec2:${var.region}:990779155717:security-group/${module.efs.efs_sg_id}"
  dest_efs_arn           =  module.efs.efs_arn
  region = var.region
  profile_name = var.profile_name
  depends_on = [ module.efs]
}
  


module "instance-main" {
  source     = "./instance-main"
  source_instance_id = var.source_instance_id
  ec2_name = var.ec2_name
  db_password = var.db_pass
  db_username = var.user_name
  efs_ip = module.efs.efs_dns
  db_url = module.db.db-dns

  depends_on = [ module.efs,module.db ]
}

module "tg-alb" {
  source     = "./tg-alb"
  vpc_id = module.vpc.vpc_p_id
  subnet_a = var.sub_pub_a_id
  subnet_b = var.sub_pub_b_id  
  instance_id = module.instance-main.instance_id
  depends_on = [ module.instance-main ]
}
resource "aws_route53_record" "www" {
  zone_id = var.zone_id
  name    = "relaese.ozomatek.com"
  type    = "CNAME"
  ttl     = 300
  records = [module.tg-alb.elb_dns]
}
