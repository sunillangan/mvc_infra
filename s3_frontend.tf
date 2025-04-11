resource "aws_s3_bucket" "frontend" {
  bucket = "mvc-frontend-bucket-12345"
  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}
