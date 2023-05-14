resource "aws_s3_bucket" "website-bucket" {
  bucket        = "aliza-dileep-hasaan.com"
  force_destroy = true
}
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.website-bucket.id
  versioning_configuration {
    status = "Enabled"
  }
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
    # sid    = "AllowLegacyOAIReadOnly"
    effect = "Allow"
    actions = [
      "s3:GetObject",
    ]
    resources = [
      "${aws_s3_bucket.website-bucket.arn}/*",
    ]
    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.origin_access_identity.iam_arn]
    }
  }
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.website-bucket.id
  policy = data.aws_iam_policy_document.s3_policy.json
}


resource "aws_s3_bucket_website_configuration" "bucket_config" {
  bucket = aws_s3_bucket.website-bucket.id

  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "error.html"
  }
}


resource "aws_s3_bucket_lifecycle_configuration" "my_static_website_lifecycle_policy" {
  bucket = aws_s3_bucket.website-bucket.id

  rule {
    id     = "website-bucket"
    status = "Enabled"
    transition {
      days          = 30
      storage_class = "GLACIER"
    }
    expiration {
      days = 90
    }
  }
}


# data "aws_s3_bucket_objects" "objects" {
#   bucket = aws_s3_bucket.website-bucket.id
# }

# resource "aws_s3_bucket_object" "update_cache_control" {
#   count         = length(data.aws_s3_bucket_objects.objects.keys)
#   bucket        = aws_s3_bucket.website-bucket.id
#   key           = data.aws_s3_bucket_objects.objects.keys[count.index]
#   cache_control = "max-age=7200, public"
# }