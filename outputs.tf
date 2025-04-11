output "ec2_public_ip" {
  value = module.ec2.public_ip
}

output "rds_endpoint" {
  value = module.rds.db_endpoint
}

output "s3_website_url" {
  value = module.s3_frontend.website_url
}
