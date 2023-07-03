## Project Structure

### Environments Folder
Host different environment folders which hosts environments specific variables.
Note: This is empty not completed for now. so to tun the terraform init/plan/apply you need to run it from the modules/ folder.

### Modules Folder
Hosts all terraform code to create aws resources per environments. defaults to dev env.

## Prereqs
- AWS Cloud Account
- AWS Cli
- Configured aws dev profile with access to aws cloud. RUN >  aws configure --profile dev 
- Terraform

## ARchitecture
- Already Provided via email

## Missing:
- ACL Access Configs
- ALB HTTPS Configs

## Usage
```
cd modules/infra
run > terraform init
run > terraform plan
run > terraform apply
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


