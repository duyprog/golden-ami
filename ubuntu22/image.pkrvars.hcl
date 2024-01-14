variable "vpc_id" {
  type = string 
  description = "VPC ID where to start EC2 for building AMI"
  default = "vpc-09e8f8956169b2bf9"
}

variable "subnet_id" {
  type    = string
  description = "AWS subnet id"
  default = "subnet-02ec01f644438972f"
}

variable "security_group_id" {
  type    = string
  description = "AWS security group id"
  default = "sg-046ba3f40685fee25"
}