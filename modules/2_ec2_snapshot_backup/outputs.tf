output "snapshot_id" {
  value       = aws_ebs_snapshot.ec2_root_snapshot.id
  description = "Snapshot ID of the EC2 instance's root volume"
}
