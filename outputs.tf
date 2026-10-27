output "bucket" {
  value = aws_s3_bucket.site.bucket
}

output "s3_website_url" {
  value = "http://${aws_s3_bucket.site.bucket}.s3-website-ap-northeast-1.amazonaws.com"
}

output "ec2_public_ip" {
  value = aws_instance.web.public_ip
}

output "ec2_instance_id" {
  value = aws_instance.web.id
}