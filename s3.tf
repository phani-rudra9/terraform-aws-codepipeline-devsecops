resource "aws_s3_bucket" "codepipeline_bucket" {
  bucket = "codepipeline-terra"
}

resource "aws_s3_bucket_acl" "codepipeline_bucket_acl" {
  bucket = aws_s3_bucket.codepipeline_bucket.id
  acl    = "private"
}


data "aws_kms_alias" "s3kmskey" {
  name = "alias/terra_key"
}