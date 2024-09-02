# variable for ec2 instance ami
variable "ami" {
    type = string
}

variable "region" {
  type = string
}

# variable for ec2 controller instance type
variable "controller_instance_type" {
    type = string
}

# variable for ec2 worker instance type
variable "worker_instance_type" {
    type = string
}

# variable for key-pair name
variable "key_pair_name" {
    type = string
}

# variable for ec2 controller instance name
variable "controller_instance_name" {
    type = string
}

# variable for ec2 worker instance name
variable "worker_instance_name" {
    type = string
}

variable "vpc_cidr_ip" {
    description = "var for vpc cidr and ip"
    type = string
}

# variable for public subnet cidr ip
variable "pub_subnet_cidr_ip" {
    description = "var for public subnet cidr and ip"
    type = string
}

# variable for s3 bucket name
variable "bucket_name" {
    type = string
}
