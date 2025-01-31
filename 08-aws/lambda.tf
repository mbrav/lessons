

# # CloudWatch Log Group for Lambda
# resource "aws_cloudwatch_log_group" "lambda_rs" {
#   name              = "/aws/lambda/${aws_lambda_function.lambda_rs.function_name}"
#   retention_in_days = 3
# }
#
# # Lambda Function
# resource "aws_lambda_function" "lambda_rs" {
#   function_name    = "lambda-rs"
#   description      = "AWS Lambda in Rust with Terraform"
#   handler          = "bootstrap" # Handler for custom runtime
#   runtime          = "provided.al2023"
#   architectures    = ["arm64"]
#   timeout          = 1
#   memory_size      = 128
#   role             = aws_iam_role.lambda_role.arn
#   filename         = "./rust/target/lambda/lambda-rs/bootstrap.zip"
#   source_code_hash = filebase64sha256("./rust/target/lambda/lambda-rs/bootstrap.zip")
#
#   ephemeral_storage {
#     size = 512
#   }
#
#   environment {
#     variables = {
#       LAMBDA_RS = "Rust baby!"
#     }
#   }
#
#   logging_config {
#     log_format = "Text"
#   }
#
#   tags = {
#     Application = "lambda-rs"
#   }
# }
