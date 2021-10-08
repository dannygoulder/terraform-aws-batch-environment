# terraform-batch-aws module

This module creates compute environments for AWS Batch

To use this module, you will need:
* an existing VPC with at least one subnet
* a valid job definition JSON file

## Example usage
```
provider "aws" {
  region = "eu-west-2"
}

resource "aws_vpc" "dannyvpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "dannysubnet" {
  vpc_id     = aws_vpc.dannyvpc.id
  cidr_block = "10.0.0.0/24"
}

module "batch" {
  source               = "."
  vpc_id               = aws_vpc.dannyvpc.id
  ce_name              = "dannytest"
  instance_type        = "t2.micro"
  max_vcpu             = 4
  min_vcpu             = 0
  desired_vcpu         = 0
  container_properties = file("./data/container_properties.json")
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_batch_compute_environment.compute_env](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/batch_compute_environment) | resource |
| [aws_batch_job_definition.job_def](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/batch_job_definition) | resource |
| [aws_batch_job_queue.job_queue](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/batch_job_queue) | resource |
| [aws_iam_instance_profile.ecs_instance_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_policy.aws_cloudwatch_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.aws_batch_service_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.ecs_instance_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.aws_batch_service_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ecs_instance_role_cloudwatch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ecs_instance_role_ec2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ecs_instance_role_s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_security_group.batch_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_subnet_ids.subnet_id](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet_ids) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ce_name"></a> [ce\_name](#input\_ce\_name) | Name of the CE to create | `string` | n/a | yes |
| <a name="input_container_properties"></a> [container\_properties](#input\_container\_properties) | A valid JSON [container properties](https://docs.aws.amazon.com/batch/latest/APIReference/API_ContainerProperties.html) file | `any` | n/a | yes |
| <a name="input_desired_vcpu"></a> [desired\_vcpu](#input\_desired\_vcpu) | The desired number of vCPUs for the CE. Actual usage will vary based on demand | `number` | `0` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Instance type to create in the CE | `string` | `"optimal"` | no |
| <a name="input_max_vcpu"></a> [max\_vcpu](#input\_max\_vcpu) | The maximum number of vCPUs for the CE to reach | `number` | `32` | no |
| <a name="input_min_vcpu"></a> [min\_vcpu](#input\_min\_vcpu) | The minimum number of vCPUs for the CE to maintain, even if disabled | `number` | `0` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC identifier in which to launch the CE | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_compute_environment_state"></a> [compute\_environment\_state](#output\_compute\_environment\_state) | State of the created CE |
| <a name="output_job_def_arn"></a> [job\_def\_arn](#output\_job\_def\_arn) | ARN of the created job definition |
| <a name="output_job_def_container_properties"></a> [job\_def\_container\_properties](#output\_job\_def\_container\_properties) | Container properties of the created job definition |
| <a name="output_job_queue_arn"></a> [job\_queue\_arn](#output\_job\_queue\_arn) | ARN of the created job queue |
| <a name="output_job_queue_state"></a> [job\_queue\_state](#output\_job\_queue\_state) | State of the created job queue |
