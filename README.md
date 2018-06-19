# terraform-aws-cloudfront-cdn

Terraform Module that implements a CloudFront Distribution (CDN) for a custom origin (e.g. website) 

A Terraform module containing typical AWS CloudFront distribution.

## Assumptions
* You've uploaded an SSL certificate to AWS/IAM
* Logging is created by default to separate S3 bucket

## Input Variables
* `name` - [mandatory] name you will see in i.e. in tags.
* `certificate_arn` - [mandatory] Existing certificate arn.
* `domains` - list of CNAME's to be associated with the CF (can be empty).
* `bucket_name` - S3 bucket name to be source for data served by CF.
* `compress` - Whether you want CloudFront to automatically compress content for web requests that include Accept-Encoding: gzip in the request header.
* `ipv6_enabled` - Whether the IPv6 is enabled for the distribution.
* `comment` - Comment used in both `aws_cloudfront_origin_access_identity` and `aws_cloudfront_distribution`.
* `log_include_cookies` - Specifies whether you want CloudFront to include cookies in access logs.
* `log_bucket` - Name of the bucket to place CF access logs.
* `log_prefix` - An optional string that you want CloudFront to prefix to the access log filenames for this distribution, for example, `cf_logs/.`.
* `price_class` - The price class for this distribution. One of PriceClass_All, PriceClass_200, PriceClass_100 (default).
* `viewer_protocol_policy` - Use this element to specify the protocol that users can use to access the files in the origin specified by TargetOriginId when a request matches the path pattern in PathPattern. One of allow-all, https-only, or redirect-to-https (default).
* `allowed_methods` - Controls which HTTP methods CloudFront processes and forwards to your Amazon S3 bucket or your custom origin.
* `cached_methods` - Controls whether CloudFront caches the response to requests using the specified HTTP methods.
* `min_ttl` - The minimum amount of time that you want objects to stay in CloudFront caches before CloudFront queries your origin to see whether the object has been updated.
* `max_ttl` - The maximum amount of time (in seconds) that an object is in a CloudFront cache before CloudFront forwards another request to your origin to determine whether the object has been updated. Only effective in the presence of Cache-Control max-age, Cache-Control s-maxage, and Expires headers.
* `default_ttl` - The default amount of time (in seconds) that an object is in a CloudFront cache before CloudFront forwards another request in the absence of an Cache-Control max-age or Expires header.
* `create_user_with_policy` - If enabled an IAM user will get created to enable highly granular S3 bucket operation. Disabled by default.
* `iam_policy` - 
* `pgp_key` - Base64 of gpg public key used to encrypt the password. Command to get the key: `gpg --export "Name or key id" | base64`. Please note that when you use this only the encrypted value will be available in terraform output.
* `tags` - A mapping of tags to assign to the resource. By default `Name` is set.

## Outputs
* `cdn_id` - The identifier for the distribution. For example: EDFDVBD632BHDS5.
* `cdn_arn` - The ARN (Amazon Resource Name) for the distribution. For example: arn:aws:cloudfront::123456789012:distribution/EDFDVBD632BHDS5, where 123456789012 is your AWS account ID.
* `cdn_status` - The current status of the distribution. Deployed if the distribution's information is fully propagated throughout the Amazon CloudFront system.
* `active_trusted_signers` - The key pair IDs that CloudFront is aware of for each trusted signer, if the distribution is set up to serve private content with signed URLs.
* `cdn_domain_name` - The domain name corresponding to the distribution. For example: d604721fxaaqy9.cloudfront.net.
* `cdn_etag` - The current version of the distribution's information. For example: E2QWRUHAPOMQZL.
* `cdn_hosted_zone_id` - The CloudFront Route 53 zone ID that can be used to route an Alias Resource Record Set to. This attribute is simply an alias for the zone ID Z2FDTNDATAQYW2.
* `s3_bucket_id` - S3 bucket id
* `s3_bucket_arn` - S3 bucket arn
* `iam_access_key_id` - The access key ID.
* `iam_access_user` - The IAM user associated with the access key.
* `iam_access_key_fingerprint` - The fingerprint of the PGP key used to encrypt the secret
* `iam_access_secret` - The secret access key. Note that this will be written to the state file. Please supply a pgp_key instead, which will prevent the secret from being stored in plain text.
* `iam_access_encrypted_secret` - The encrypted secret, base64 encoded. ~> NOTE: The encrypted secret may be decrypted using the command line, for example: `terraform output iam_access_secret | base64 --decode | keybase pgp decrypt` or you can use `terraform output iam_access_secret | base64 -D | gpg -d` if you don't use keybase.

## Usage example:
```
module "cdn" {
  source = "git::https://github.com/terraform-library/aws-cloudfront.git?ref=master"
  name = "tf-${terraform.env}-my-cf"
  domains = ["whatever-${terraform.env}.${var.domain}"]
  certificate_arn = "arn:aws:tjwl:eu-west-1:123456789123:certificate/11111111-2222-3333-4444-555555555555"

  bucket_name = "tjwlbe"
  comment = "Managed by Terraform"

  log_include_cookies = "false"
  log_bucket          = "dev-cdn-log"

  allowed_methods = ["GET", "HEAD"]

  tags = {
             environment = "dev"
  }
}
```