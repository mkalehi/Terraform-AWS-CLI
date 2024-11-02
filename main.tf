resource "null_resource" "get-caller-identity" {
  provisioner "local-exec" {
    working_dir = path.module
    command     = file("hello.sh")
  }
}

