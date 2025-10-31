#// provider Config

region          = "ap-south-1"
access_key      = "xxxxxxxxxxxxxxxxxxxxxxxxxxxx"
secret_key      = "yyyyyyyyyyyyyyyyyyyyyyyyyyyy"

#// EC2 Instances (server) Config

server_name     = "Atul-jk"
server_ami      = "ami-07f07a6e1060cd2a8"
server_type     = "t2.medium"
server_owner    = "atul-owner"                // EC2 Tags
server_can_be_deleted = "yes"


#// storage

volume_type             = "gp2"           //gp2, gp3, io1, io2, sc1, st1, standard
volume_storage_size     = "29"  
delete_on_termination   = "true"

#// SSH-Key Key Pair 

aws_create_key_pair_name = "atul_terraform_JK_KP"

#// user_data

user_data_script_file = "./new_bash_script_install.sh"

#// Security Group

aws_security_group_name  = "atul-sg"
allowed_ports            = [22, 80, 443, 8080]


#------------------------------------- Modules --> Server_snapshot #-------------------------------------

snapshot_name = "Terraform-snapshot-atul"

snapshot_aws_create_key_pair_name = "snapshot_atul_terraform_KP"