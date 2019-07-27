# Icalia Labs AWS Guides

**YOU SHOULD NEVER USE ROOT CREDENTIALS on apps!!!** 
See ["Creating an IAM user for the app](#creating-an-iam-user-for-the-app)

## Working with a customer's AWS Account

Whenever we'll be working with a customer's AWS account, we need to:

### Access the AWS console using "Identity and Access Management" (IAM)

- A nice touch will be to ensure an account alias is set up for the IAM
    sign-in (i.e. https://icalialabs.signin.aws.amazon.com/console)

- Use our work email address as the account username (i.e. vov@icalialabs.com)

- Have the proper permissions assigned to them:
  - The project's tech lead should at least have the "AdministratorAccess"
    policy attached to him/her, either via a group or directly to it's user.
  - Any other team member should have the proper policies attached to them,
    depending on the case (are they gonna deploy the app?)

### Check the Billing

The team's tech leads should be able to have access to the Billing console, so
we can watch the costs of our proposed solution.

## Creating an IAM user for the app

1: Create the user

Via AWS CLI (Please change "our-client-application-name"!):

```bash
aws iam create-user --user-name "the-customer-app-name"
```

2: Create an access key for the user - Please take note on the output of this
command, as we're going to use the values on it to configure the app:

```bash
aws iam create-access-key --user-name "the-customer-app-name"
```

3: Configure your app to access AWS using environment variables

We're going to use the standard environment variables used by the AWS SDKs to
set up the access key and secret key - be sure any configuration in your app uses these as well:

```bash
AWS_ACCESS_KEY_ID=[The "AccessKeyId" value from the output]
AWS_SECRET_ACCESS_KEY=[The "SecretAccessKey" value from the output]
```

## Simple Storage Service (S3)

The plan to follow when creating and using S3 buckets must be the following:

### 1. Creating a policy with permissions to access the S3 buckets

*Skip this step if the policy already exists*

We'll create a policy containing the required permissions to use S3 
buckets to upload files, read them and update them as needed. This policy can be
associated to IAM users or groups to grant them the included permissions.

We have a [media_management_policy.json](aws/iam/media_management_policy.json)
template with settings that provide a reasonable amount of security while being
compatible with popular app libraries such as Python's `boto3` and Ruby's
`activestorage`. This file can be used by the AWS CLI to create the policy:

```bash
aws iam create-policy \
 --policy-name "MediaManagement" \
 --description "Grants access to S3 buckets and objects" \
 --policy-document file://best_practices/aws/iam/media_management_policy.json
```

We can also create the policy using the AWS IAM console. These are the details
of the policy we use:

- Service: S3
- Actions to Allow:
  * `ListBucket`
  * `DeleteObjectTagging`
  * `GetBucketTagging`
  * `DeleteObjectVersion`
  * `GetObjectVersionTagging`
  * `PutObjectVersionTagging`
  * `DeleteObjectVersionTagging`
  * `GetBucketVersioning`
  * `GetBucketAcl`
  * `PutObject`
  * `GetObjectAcl`
  * `GetObject`
  * `GetBucketCORS`
  * `GetObjectVersionAcl`
  * `PutBucketAcl`
  * `PutObjectTagging`
  * `DeleteObject`
  * `GetBucketLocation`
  * `PutObjectAcl`
  * `GetObjectVersion`
- Specific Resources:
  * `arn:aws:s3:::*` - *All buckets in the account*
  * `arn:aws:s3:::*/*` - *All objects in every bucket in the account*

### 2: Attach the "MediaManagement" policy to the App IAM User

Follow [application IAM user](#creating-an-iam-user-for-the-app) if you haven't
created the IAM User for the app your'e working with!

You'll need the "MediaManagement" policy's ARN. You can get it by listing
the IAM policies via AWS CLI:

```bash
# The "--scope Local" option will show us our custom policies only
aws iam list-policies --scope Local 
```

Once you got the "MediaManagement" policy ARN, we'll attach it to the app's
user:

```bash
aws iam attach-user-policy \
 --policy-arn "replace-with-the-media-management-policy-arn" \
 --user-name "replace-with-our-customer-app-name"
```

After this, your application will have access to all buckets and the objects in
them.

### 3. Create the required S3 Buckets, with the necessary configuration

Create the bucket - add a `LocationConstraint` bucket configuration for
buckets created outside the `us-east-1` region:

```bash
# https://docs.aws.amazon.com/cli/latest/reference/s3api/create-bucket.html
aws s3api create-bucket \
 --bucket "the-bucket-name" \
 --region us-west-2 \
 --create-bucket-configuration LocationConstraint=us-west-2
 --acl private
```

Next, turn on the "Block Public Access" feature: *- See ["How Do I Block Public Access to S3 Buckets?"](https://docs.aws.amazon.com/console/s3/publicaccess)*

```bash
# https://docs.aws.amazon.com/cli/latest/reference/s3api/put-public-access-block.html
aws s3api put-public-access-block \
 --bucket "the-bucket-name" \
 --public-access-block-configuration file://best_practices/aws/s3/public_access_block_config.json
```

Then, we'll configure the bucket's CORS.

This CORS configuration will allow browsers to download objects from any domain,
but restrict uploads from anywhere else but the customer's app domain.

Save this as `cors.json`:

```json
{
  "CORSRules": [
    {
      "AllowedOrigins": ["*"],
      "AllowedHeaders": ["Authorization"],
      "AllowedMethods": ["GET"],
      "MaxAgeSeconds": 3000
    },
    {
      "AllowedOrigins": ["https://the-customer-app-name.herokuapp.com"],
      "AllowedHeaders": ["*"],
      "AllowedMethods": ["PUT", "POST", "DELETE"],
      "MaxAgeSeconds": 3000,
      "ExposeHeaders": ["x-amz-server-side-encryption"]
    }
  ]
}
```

Apply the bucket's CORS configuration:

```bash
# https://docs.aws.amazon.com/cli/latest/reference/s3api/put-bucket-cors.html
aws s3api put-bucket-cors \
 --bucket "the-bucket-name" \
 --cors-configuration "file://cors.json"
```

## Elastic Container Registry

We'll use ECR to store testing, builder and release images for some of our
projects. There would be used by our CI/CD pipelines to test & deliver our apps
to Heroku, Kubernetes, Swarm, etc.

### Lifecycle Policies

Since our CI/CD pipeline would run several times a day on active projects, the
list of images would increase to the hundreds. We'll apply a list of [lifecycle
policies](aws/ecr/lifecycle_policies.json) to keep the image list within a
manageable count, cleaning the image repository from images that:

- Doesn't have any tag (for example, previous `master`, `latest` or branch
  images)
- Images older than 3 days having the `testing`, `builder` or any
  "Git short sha" tags.

To apply these rules (19 in total) on the AWS Console is rather cumbersome, so
we'll use the AWS CLI instead:

```bash
aws ecr put-lifecycle-policy \
 --lifecycle-policy-text "file:///path/to/lifecycle_policies.json" \
 --repository-name "your-repo-name" \
 --region aws-region-where-the-repo-is
```

Ensure the `--lifecycle-policy-text` is pointing to your local copy of the
[lifecycle_policies.json](aws/ecr/lifecycle_policies.json) included in this repo.