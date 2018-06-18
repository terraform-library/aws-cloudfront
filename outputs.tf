#The identifier for the distribution. For example: EDFDVBD632BHDS5.
output "cdn_id" {
  value = "${aws_cloudfront_distribution.cdn.id}"
}

#The ARN (Amazon Resource Name) for the distribution. For example: arn:aws:cloudfront::123456789012:distribution/EDFDVBD632BHDS5, where 123456789012 is your AWS account ID.
output "cdn_arn" {
  value = "${aws_cloudfront_distribution.cdn.arn}"
}

#The current status of the distribution. Deployed if the distribution's information is fully propagated throughout the Amazon CloudFront system.
output "cdn_status" {
  value = "${aws_cloudfront_distribution.cdn.status}"
}

#active_trusted_signers - The key pair IDs that CloudFront is aware of for each trusted signer, if the distribution is set up to serve private content with signed URLs.
output "cdn_active_trusted_signers" {
  value = "${aws_cloudfront_distribution.cdn.active_trusted_signers}"
}

#The domain name corresponding to the distribution. For example: d604721fxaaqy9.cloudfront.net.
output "cdn_domain_name" {
  value = "${aws_cloudfront_distribution.cdn.domain_name}"
}

#The current version of the distribution's information. For example: E2QWRUHAPOMQZL.
output "cdn_etag" {
  value = "${aws_cloudfront_distribution.cdn.etag}"
}

#The CloudFront Route 53 zone ID that can be used to route an Alias Resource Record Set to. This attribute is simply an alias for the zone ID Z2FDTNDATAQYW2.
output "cdn_hosted_zone_id" {
  value = "${aws_cloudfront_distribution.cdn.hosted_zone_id}"
}

#S3 bucket id
output "s3_bucket_id" {
  value = "${aws_s3_bucket.bucket.id}"
}

#S3 bucket arn
output "s3_bucket_arn" {
  value = "${aws_s3_bucket.bucket.arn}"
}


#The access key ID.
output "iam_access_key_id" {
  value = "${aws_iam_access_key.access_key.id}"
}

#The IAM user associated with this access key.
output "iam_access_user" {
  value = "${aws_iam_access_key.access_key.user}"
}

#The fingerprint of the PGP key used to encrypt the secret
output "iam_access_key_fingerprint" {
  value = "${aws_iam_access_key.access_key.key_fingerprint}"
}

# The secret access key. Note that this will be written to the state file. Please supply a pgp_key instead, which will prevent the secret from being stored in plain text
output "iam_access_secret" {
  value = "${aws_iam_access_key.access_key.secret}"
}

# The encrypted secret, base64 encoded. ~> NOTE: The encrypted secret may be decrypted using the command line, for example: terraform output secret | base64 --decode | keybase pgp decrypt.
output "iam_access_encrypted_secret" {
  value = "${aws_iam_access_key.access_key.encrypted_secret}"
}