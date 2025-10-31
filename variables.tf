### All Modules Varibales folder listed below///


// provider Config

variable "region" {
  type = string
  default = "ap-south-1"
  description = "Default region is mumbai"
}

variable "access_key" {
  type = string
}

variable "secret_key" {
  type = string
}

#------------------------------------- Modules --> ec2-server #-------------------------------------

// AWS EC2 Instances Config

variable "server_ami" {
  type = string
  default = "ami-07f07a6e1060cd2a8"
  description = "This ami is ubuntu 24.04"
}

variable "server_type" {
  type = string
  default = "t2.micro"
  description = "Instance config default is vCPU: 1 and RAM: 1"

}

variable "server_name"{
  type = string
  default = "demo_server_terra"
  description = "Default server name"
}

variable "server_owner"{
  type = string
  default = "atul_terraform"

}

variable "server_can_be_deleted"{
  type = string
  default = "Ask Owner"

}

// user_data

variable "user_data_script_file"{
  type = string
  description = "Put your custom bash script file"

}


// storage config


variable "volume_type"{
  type = string
  default = "gp2"
}

variable "volume_storage_size"{
  type = string
  default = "29"
}

variable "delete_on_termination"{
  type = string
  default = "true"
}

// AWS Key Pair

variable "aws_create_key_pair_name"{
  type = string
  default = "atul_terraform_KP"
  description = "Name for the AWS key pair"
}

// Security group

variable "aws_security_group_name"{
  type = string
  default = "atul_terraform_SG"
}

variable "aws_security_group_description"{
  type = string
  default = "Security group for terraform Server check tags"
}

variable "allowed_ports"{
  type = list(number)
  description = "List of inbound(incoming) TCP ports to allow"
  
}



#------------------------------------- Modules 2 --> Server_snapshot #-------------------------------------

variable "snapshot_name" {
  type = string
  default = "EC2-Root-Volume-Snapshot-terraform"
}

#------------------------------------- Modules 3 --> new_snapshot #-------------------------------------


// SSH key pair
variable "snapshot_aws_create_key_pair_name"{
  type = string
  default = "snapshot_atul_terraform_KP"
  description = "Name for the AWS key pair"
}