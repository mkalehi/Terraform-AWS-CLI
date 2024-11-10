resource "null_resource" "get-caller-identity" {
  provisioner "local-exec" {
    working_dir = path.module
    command     = file("hello.sh")
  }
}

data "aws_vpc" "this" {
  state = "available"
}

output "VPC_Details" {
  value = data.aws_vpc.this
}

