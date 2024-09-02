# output of public subnet id
output "pub_subnet_id" {
  value = aws_subnet.public_subnet.id
}

# output of vpc id
output "my_vpc_id" {
  value = aws_vpc.my_vpc.id
}