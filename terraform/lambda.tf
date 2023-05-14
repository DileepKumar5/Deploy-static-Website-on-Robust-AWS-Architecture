# # # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function

# data "aws_iam_policy_document" "assume_role" {
#   statement {
#     actions = ["sts:AssumeRole"]
#     principals {
#       type        = "Service"
#       identifiers = ["edgelambda.amazonaws.com","lambda.amazonaws.com"]
#     }
#   }
# }

# resource "aws_iam_role" "lambda_service_role" {
#   name               = "lambda_service_role"
#   assume_role_policy = data.aws_iam_policy_document.assume_role.json
# }

# data "archive_file" "lambda_zip" {
#   type        = "zip"
#   source_file  = "headers.js"
#   output_path = "headers.zip"
# }

# resource "aws_lambda_function" "web_lambda" {
#   filename      = "headers.zip"
#   function_name = "web_lambda"
#   role          = aws_iam_role.lambda_service_role.arn
#   handler       = "headers.handler"
#   source_code_hash = data.archive_file.lambda_zip.output_base64sha256
#   runtime = "nodejs18.x"
# }

# resource "aws_iam_role_policy_attachment" "st0_readonly_policy_attachment" {
#   role       = aws_iam_role.lambda_service_role.name
#   policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
# }


# resource "aws_lambda_permission" "allow_cloudwatch" {
#   statement_id  = "AllowExecutionFromCloudWatch"
#   action        = "lambda:InvokeFunction"
#   function_name = aws_lambda_function.web_lambda.function_name
#   principal     = "events.amazonaws.com"
# }

# resource "aws_cloudfront_function" "cf_function" {
#   name        = "cf_function"
#   comment     = "Associates Lambda@Edge function with CloudFront distribution"
#   code        = data.archive_file.lambda_zip.output_path
#   runtime     = "cloudfront-js-1.0"
# }


