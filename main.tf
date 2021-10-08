/*
 * # terraform-batch-aws module
 *
 * This module creates compute environments for AWS Batch
 *
 * To use this module, you will need:
 * * an existing VPC with at least one subnet
 * * a valid job definition JSON file
 *
 * ## Example usage
 * ```
 * provider "aws" {
 *   region = "eu-west-2"
 * }
 *
 * resource "aws_vpc" "dannyvpc" {
 *   cidr_block = "10.0.0.0/16"
 * }
 *
 * resource "aws_subnet" "dannysubnet" {
 *   vpc_id     = aws_vpc.dannyvpc.id
 *   cidr_block = "10.0.0.0/24"
 * }
 *
 * module "batch" {
 *   source               = "."
 *   vpc_id               = aws_vpc.dannyvpc.id
 *   ce_name              = "dannytest"
 *   instance_type        = "t2.micro"
 *   max_vcpu             = 4
 *   min_vcpu             = 0
 *   desired_vcpu         = 0
 *   container_properties = file("./data/container_properties.json")
 * }
 * ```
 *
*/
resource "aws_security_group" "batch_sg" {
  name = "batch_egress_any_any_sg"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_batch_compute_environment" "compute_env" {
  compute_environment_name = var.ce_name

  compute_resources {
    instance_role = aws_iam_instance_profile.ecs_instance_role.arn

    instance_type = [
      var.instance_type,
    ]

    max_vcpus = var.max_vcpu
    min_vcpus = var.min_vcpu
    desired_vcpus = var.desired_vcpu

    security_group_ids = [
      aws_security_group.batch_sg.id,
    ]

    subnets = [
      data.aws_subnet_ids.subnet_id.id,
    ]

    type = "EC2"
  }

  service_role = aws_iam_role.aws_batch_service_role.arn
  type         = "MANAGED"
  depends_on   = [aws_iam_role_policy_attachment.aws_batch_service_role]
}

resource "aws_batch_job_definition" "job_def" {
  name                 = "batch_job_def_${var.ce_name}"
  type                 = "container"
  container_properties = var.container_properties
}

resource "aws_batch_job_queue" "job_queue" {
  name     = "batch_job_queue_${var.ce_name}"
  state    = "ENABLED"
  priority = 1
  compute_environments = [
    aws_batch_compute_environment.compute_env.arn,
  ]
}
