// Create RSA key of size 4096 bits
resource "tls_private_key" "LTF_Key_Pair" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

// Save the private ssh key on local

resource "local_file" "LTF_private_key" {
  content         = tls_private_key.LTF_Key_Pair.private_key_pem
  filename        = "${path.module}/${var.snapshot_aws_create_key_pair_name}.pem"
  file_permission = "0600"
}

// Upload public key to AWS 
resource "aws_key_pair" "own_ssh_key" {
  key_name   = var.snapshot_aws_create_key_pair_name
  public_key = tls_private_key.LTF_Key_Pair.public_key_openssh
}
