terraform {
  backend "s3" {
    bucket = "backend-bucket-project-001"
    key    = "test/terraform.tfstate"
    region = "us-east-1"
  }
}