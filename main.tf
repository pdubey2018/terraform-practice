
provider "aws" {
  region = "eu-west-2"
  profile = "personal"
}

variable "subnet-id" {
  description = "Variable for all development task"
}
variable "env" {
  description = "Name of env"
}
resource "aws_vpc" "dev-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name : var.env,
  }
}

resource "aws_subnet" "dev-subnet-1" {
  vpc_id            = aws_vpc.dev-vpc.id
  cidr_block        = var.subnet-id
  availability_zone = "eu-west-2a"
  tags = {
    Name : "development-subnet-1"
  }
}

data "aws_vpc" "existing_vpc" {
  id = "vpc-ce0353a6"
}

resource "aws_subnet" "dev-subnet-2" {
  vpc_id            = data.aws_vpc.existing_vpc.id
  cidr_block        = "172.31.48.0/20"
  availability_zone = "eu-west-2a"
}

output "dev-vpc-id" {
  value = aws_vpc.dev-vpc.id
}

output "dev-subnet-1" {
  value = aws_subnet.dev-subnet-1.id

}
