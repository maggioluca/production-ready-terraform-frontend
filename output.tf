output "s3_aws_bucket_name" {
  value = local.bucket_name
}

output service_ip {
  value = aws_cloudfront_distribution.frontend.domain_name
}