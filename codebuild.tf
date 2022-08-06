resource "aws_codebuild_project" "test-codebuild" {
  name          = "test-project-terra"
  description   = "test_codebuild_project"
  build_timeout = "5"
  service_role  = aws_iam_role.codebuild-role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  cache {
    type     = "S3"
    location = aws_s3_bucket.codepipeline_bucket.bucket
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:1.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"

    /* environment_variable {
      name  = "SOME_KEY1"
      value = "SOME_VALUE1"
    }

    environment_variable {
      name  = "SOME_KEY2"
      value = "SOME_VALUE2"
      type  = "PARAMETER_STORE"
    } */
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "terra-democodebuildproject-lg"
      stream_name = "terrademo-proj"
    }

    s3_logs {
      status   = "ENABLED"
      location = "${aws_s3_bucket.codepipeline_bucket.id}/build-log"
    }
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = "buildspec_terraform_plan.yml"
  }

  source_version = "master"
/* 
  vpc_config {
    vpc_id = aws_vpc.example.id

    subnets = [
      aws_subnet.example1.id,
      aws_subnet.example2.id,
    ]

    security_group_ids = [
      aws_security_group.example1.id,
      aws_security_group.example2.id,
    ]
  } */

  tags = {
    Environment = "Test"
  }
}
