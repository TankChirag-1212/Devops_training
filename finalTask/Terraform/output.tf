# output of ec2 worker public ip
output "ec2_worker_instance_ip" {
  value = module.ec2_worker[*].instance_public_ip
}

# output of ec2 controller public ip
output "ec2_controller_instance_ip" {
  value = module.ec2_controller.instance_public_ip
}

# output of s3 bucket name
output "s3_bucket_arn" {
  value = module.s3.s3_arn
}