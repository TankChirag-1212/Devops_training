variable "aws_region" {
  description = "The AWS region to deploy resources in"
  default     = "us-west-2"
}

variable "ec2_ami_id" {
  default = "ami-id"

}
variable "ec2_instance_type" {
  default = "t2.micro"
}



# EC2 IAM Role ARN
variable "ec2_iam_role_arn" {
  description = "The ARN of the IAM role attached to the EC2 instance."
  default = "iam-role-arn"
  type = string
}

variable "db_instance_type" {
  default = "db.t3.micro"
}
variable "db_name" {
  default = "<db-name>"
}
variable "db_username" {
  default = "<username>"
}
variable "db_password" {
  default = "<db-pass>"
}
variable "bucket_name" {
  default = "<bucket-name>"
}