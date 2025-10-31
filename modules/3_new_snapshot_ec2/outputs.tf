output "snapshot_server_public_ip" {
  description = "This is a snapshot server public ip address"
  value = aws_instance.from_snapshot_instance.public_ip
}