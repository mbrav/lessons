# resource "random_pet" "lambda_rs_bucket_name" {
#   prefix = "lambda-rs"
#   length = 2
# }
#
# resource "aws_s3_bucket" "lambda_rs_bucket" {
#   bucket        = random_pet.lambda_bucket_name.id
#   force_destroy = true
#
#   tags = {
#     Application = "lambda-rs"
#   }
# }
#
# resource "aws_s3_bucket_versioning" "lambda_rs_bucket" {
#   bucket = aws_s3_bucket.lambda_rs_bucket.id
#   versioning_configuration {
#     status = "Enabled"
#   }
# }
#
# resource "aws_s3_bucket_public_access_block" "lambda_rs_bucket" {
#   bucket = aws_s3_bucket.lambda_rs_bucket.id
#
#   block_public_acls       = true
#   block_public_policy     = true
#   ignore_public_acls      = true
#   restrict_public_buckets = true
# }
