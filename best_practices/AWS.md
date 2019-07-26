# Icalia Labs AWS Guides

## About Buckets and bucket access

## Using & managing a client's AWS Account

Whenever we'll be working with a client's AWS account, we need to:

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


## Elastic Container Registry

We'll use ECR to store testing, builder and release images for some of our
projects. There would be used by our CI/CD pipelines to test & deliver our apps
to Heroku, Kubernetes, Swarm, etc.

### Lifecycle Policies

Since our CI/CD pipeline would run several times a day on active projects, the
list of images would increase to the hundreds. We'll apply a list of [lifecycle
policies](aws/ecr/lifecycle_policies.json) to keep the image list within a
manageable count, cleaning the image repository from images that:

- Doesn't have any tag (for example, previous `master`, `latest` or branch images)
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