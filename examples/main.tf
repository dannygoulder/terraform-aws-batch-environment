provider "aws" {
  region = "eu-west-2"
}

resource "aws_vpc" "dannyvpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "compute" {
  vpc_id     = aws_vpc.dannyvpc.id
  cidr_block = "10.0.0.0/24"
}

module "batch" {
  source               = "./.."
  vpc_id               = aws_vpc.dannyvpc.id
  ce_name              = "dannytest"
  instance_type        = "optimal"
  max_vcpu             = 4
  min_vcpu             = 0
  desired_vcpu         = 0
  container_properties = file("./data/container_properties.json")
}
