// Storage
variable "volume_storage_size"{
  type = string
  default = "29"
}

// Server type
variable "server_type" {
  type = string
  default = "t2.micro"
  description = "Instance config default is vCPU: 1 and RAM: 1"

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


// Tags

variable "server_owner"{
  type = string
  default = "atul_terraform"

}

variable "server_can_be_deleted"{
  type = string
  default = "Ask Owner"

}

// SSH key pair
variable "snapshot_aws_create_key_pair_name"{
  type = string
  default = "snapshot_atul_terraform_KP"
  description = "Name for the AWS key pair"
}