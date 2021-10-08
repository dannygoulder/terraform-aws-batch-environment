output "job_def_arn" {
  description = "ARN of the created job definition"
  value       = aws_batch_job_definition.job_def.arn
}

output "job_def_container_properties" {
  description = "Container properties of the created job definition"
  value       = aws_batch_job_definition.job_def.container_properties
}

output "job_queue_arn" {
  description = "ARN of the created job queue"
  value       = aws_batch_job_queue.job_queue.arn
}

output "job_queue_state" {
  description = "State of the created job queue"
  value       = aws_batch_job_queue.job_queue.state
}

output "compute_environment_state" {
  description = "State of the created CE"
  value       = aws_batch_compute_environment.compute_env.state
}

