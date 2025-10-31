output "ec2_server_public_ip" {
  description = "Public IP address of the EC2 instance created from 1_ec2-server module"
  value       = module.ec2-server_instances.server_public_ip
}

output "ec2_server_private_ip" {
  description = "Private IP address of the EC2 instance created from 1_ec2-server module"
  value       = module.ec2-server_instances.server_private_ip
}

output "ec2_server_instance_id" {
  description = "Instance ID of the EC2 instance created from 1_ec2-server module"
  value       = module.ec2-server_instances.server_instance_id
}

output "snapshot_name" {
  description = "Snapshot ID of the EC2 instance's root volume"
  value = module.ec2_snapshot_backup.snapshot_id
}

output "snapshot_server_public_ip" {
  description = "This is a snapshot server public ip address"
  value = module.new_ec2_snapshot_launch.snapshot_server_public_ip  
}