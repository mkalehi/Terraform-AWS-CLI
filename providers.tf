provider "aws" {
  region = "eu-west-2"
  assume_role {
    role_arn     = "arn:aws:iam::${var.account_id}:role/${var.session_role_name}"
    session_name = "terraform-mkalehi"
  }
}