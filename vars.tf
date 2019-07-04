variable "AWS_ACCESS_KEY" {}

variable "AWS_SECRET_KEY" {}

variable "AWS_REGION" {
  default = "ap-southeast-2"
}

variable "AMI_ID" {
  type    = "string"
  default   = "ami-001dae151248753a2"
}

variable "INSTANCE_TYPE" {
  type    = "string"
  default   = "t3.micro"
}

variable "INSTANCE_USERNAME" {
  default = "ubuntu"
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "id_rsa"
}
variable "PATH_TO_PUBLIC_KEY" {
  default = "id_rsa.pub"
}