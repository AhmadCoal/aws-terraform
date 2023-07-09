# Project And Structure
Projects allow you to deploy aws resources using terraform modules defined under modules folder. Project follows enviornment based deployment workflow using below folders.
- Environments Folder Contains enviornments specific variables and files that will be passed down to modules being deployed in the enviornment.
- Modules Folder contains all the terraform modules that can be deployed into differnt enviornment.

## Prereqs
- AWS Cloud Account
- AWS Cli and configured locally to connect to aws.
- Configured aws dev profile with access to aws cloud. RUN >  aws configure --profile dev 
- Terraform

## Architecture
- Already Provided via email

## Missing:
- ALB HTTPS Configs

## Usage
- Example below to deploy the infra modules in the dev enviornment.
```
RUN > terraform -chdir=environments/dev init
RUN > terraform -chdir=environments/dev plan
run > terraform -chdir=environments/dev apply
```

#### Resources Used
- https://registry.terraform.io/providers/hashicorp/aws/latest/docs
- https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones.htmls
- https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest
- https://registry.terraform.io/modules/terraform-aws-modules/alb/aws/latest
- https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance
- https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group
- https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/usingsharedamis-finding.html
- https://dev.to/chefgs/create-apache-web-server-in-aws-using-terraform-1fpj
- https://cloudkatha.com/how-to-create-key-pair-in-aws-using-terraform-in-right-way/
- https://registry.terraform.io/providers/hashicorp/aws/3.9.0/docs/resources/key_pair
- https://registry.terraform.io/providers/hashicorp/aws/3.36.0/docs/data-sources/ami
- https://discuss.hashicorp.com/t/use-locals-to-loop-aws-instance-through-3-subnets/28593
- https://developer.hashicorp.com/terraform/language/functions/element
- https://www.youtube.com/watch?v=81rQ5KgETs0&ab_channel=AntonPutra
- https://registry.terraform.io/modules/terraform-aws-modules/rds/aws/latest
- https://developer.hashicorp.com/terraform/language/functions/cidrsubnet

