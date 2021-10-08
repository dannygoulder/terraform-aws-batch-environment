data "aws_subnet_ids" "subnet_id" {
  vpc_id = var.vpc_id
}
