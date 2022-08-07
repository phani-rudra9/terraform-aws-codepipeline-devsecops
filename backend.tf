terraform {
  backend "s3" {
    bucket = "terra-phani"
    key    = "terraform/terraform.tfstate"
    region = "ap-south-1"
  }
}
