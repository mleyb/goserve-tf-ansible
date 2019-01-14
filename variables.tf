variable "aws_access_key" {
  description = "AWS Access Key"
}

variable "aws_secret_key" {
  description = "AWS Secret Key"
}

variable "ssh_key_public" {
  default     = "~/.ssh/id_rsa.pub"
  description = "Path to the SSH public key for accessing cloud instances. Used for creating AWS keypair."
}

variable "ssh_key_private" {
  default     = "~/.ssh/id_rsa"
  description = "Path to the SSH public key for accessing cloud instances. Used for creating AWS keypair."
}

variable "aws_region" {
  default     = "eu-west-1"
  description = "AWS Region"
}

variable "instance_type" {
  default     = "t2.micro"
  description = "Instance type"
}
