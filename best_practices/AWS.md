# Icalia Labs AWS Guides

# About Buckets and bucket access

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
