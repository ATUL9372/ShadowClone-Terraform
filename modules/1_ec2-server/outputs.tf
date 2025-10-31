output "server_public_ip" {
  description = "This is a server public ip address"
  value = aws_instance.my_server.public_ip
}

output "server_private_ip" {
  description = "This is a server private ip address"
  value = aws_instance.my_server.private_ip
}

output "server_instance_id" {
  description = "This is a server instances id"
  value = aws_instance.my_server.id
}
