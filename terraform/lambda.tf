# # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function

# data "aws_iam_policy_document" "assume_role" {
#   statement {
#     effect = "Allow"
#     actions = ["sts:AssumeRole"]
#     principals {
#       type        = "Service"
#       identifiers = ["*"]
#     }
#   }
# }

# resource "aws_iam_policy" "iam_policy" {
#   policy = data.aws_iam_policy_document.s3_policy.json
# }

# resource "aws_iam_role_policy" "assume_role_policy" {
#   name   = "iam_for_lambda_assume_role_policy"
#   role   = aws_iam_role.iam_for_lambda.name
#   policy = data.aws_iam_policy_document.assume_role.json
# }

# resource "aws_iam_role" "iam_for_lambda" {
#   name               = "iam_lambda_role"
#   assume_role_policy = data.aws_iam_policy_document.assume_role.json
# }

# data "archive_file" "lambda_function" {
#   type        = "zip"
#   source_dir  = "../source_code"
#   output_path = "lambda_function.zip"
# }

# resource "aws_lambda_function" "web_lambda" {
#   # If the file is not in the current working directory you will need to include a
#   # path.module in the filename.
#   filename      = "lambda_function.zip"
#   function_name = "web_lambda"
#   role          = aws_iam_role.iam_for_lambda.arn
#   handler       = "index.html"
#   source_code_hash = data.archive_file.lambda_function.output_base64sha256
#   runtime = "nodejs18.x"
# }


# resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
#   role       = aws_iam_role.iam_for_lambda.name
#   policy_arn = aws_iam_policy.iam_policy.arn
# }


# resource "aws_lambda_permission" "allow_cloudfront" {
#   statement_id  = "AllowExecutionFromCloudFront"
#   action        = "lambda:InvokeFunction"
#   function_name = aws_lambda_function.web_lambda.function_name
#   principal     = "edgelambda.amazonaws.com"
#   source_arn    = aws_cloudfront_distribution.s3_distribution.arn
# }

# resource "aws_cloudfront_function" "cf_function" {
#   name        = "cf_function"
#   comment     = "Associates Lambda@Edge function with CloudFront distribution"
#   code        = data.archive_file.lambda_function.output_path
#   runtime     = "cloudfront-js-1.0"
# }

# # resource "aws_lambda_permission" "api_gateway_permission" {
# #   statement_id  = "AllowExecutionFromAPIGateway"
# #   action        = "lambda:InvokeFunction"
# #   function_name = aws_lambda_function.static_website_lambda.function_name
# #   principal     = "apigateway.amazonaws.com"
# # }

