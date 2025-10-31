# Root main.tf file

module "ec2-server_instances" {
  source = "./modules/1_ec2-server/"
  server_name = var.server_name
  server_ami = var.server_ami
  server_type = var.server_type
  server_owner = var.server_owner
  server_can_be_deleted = var.server_can_be_deleted
  volume_type = var.volume_type
  volume_storage_size = var.volume_storage_size
  delete_on_termination = var.delete_on_termination
  aws_create_key_pair_name = var.aws_create_key_pair_name
  user_data_script_file = var.user_data_script_file
  aws_security_group_name = var.aws_security_group_name
  allowed_ports = var.allowed_ports
  
}


module "ec2_snapshot_backup" {
  source = "./modules/2_ec2_snapshot_backup"
}

module "new_ec2_snapshot_launch" {
  source = "./modules/3_new_snapshot_ec2/"
  depends_on = [module.ec2_snapshot_backup]
  allowed_ports = var.allowed_ports
}
