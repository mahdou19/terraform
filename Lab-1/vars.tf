variable "AWS_REGION" {
  default = "eu-west-1"
}

variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}

variable "AWS_AMIS" {
  default = {
    "eu-west-1" = "ami-062a49a8152e4c031"
    "us-east-2" = "ami-07c1207a9d40bc3bd"
  }

}
