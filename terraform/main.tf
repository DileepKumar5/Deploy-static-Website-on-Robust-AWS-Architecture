# resource "aws_s3_bucket" "backend-bucket"{
#   bucket = "backend-bucket-project-0001"
#  # force_destroy = true
#   acl = "private"
# }

resource "aws_s3_bucket" "website-bucket" {
  bucket = "aliza-dileep-hasaan.com"
}
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.website-bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

data "aws_iam_policy_document" "s3_policy" {
  statement {
    sid    = "PublicReadGetObject"
    effect = "Allow"
    actions = [
      "s3:GetObject",
    ]
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    resources = ["arn:aws:s3:::wwww.${website_bucket}/*"]
    
  }
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.website-bucket.id
  policy = data.aws_iam_policy_document.s3_policy.json
}

# resource "aws_cloudfront_origin_access_identity" "cf_origin_access_identity" {
#   comment = "CF origin access identity"
# }

resource "aws_s3_bucket_website_configuration" "bucket_config" {
  bucket = aws_s3_bucket.website-bucket.id

  index_document {
    suffix = "index.html"
  }
}
