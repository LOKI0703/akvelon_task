variable "region" {
  type        = string
  default     = "ap-south-1"
  description = "default region for resources"
}
variable "cidr_block" {
  type    = list(any)
  default = ["0.0.0.0/0"]
}
variable "instance_type" {
  type    = string
  default = "t2.micro"

}
variable "aws_ami" {
  type    = string
  default = "ami-068257025f72f470d"
}
