module "zones" {
  source  = "terraform-aws-modules/route53/aws//modules/zones"
  version = "~> 2.0"

  zones = {
    "terraform-aws-${var.domain_name}" = {
      comment = "terraform-aws-${var.domain_name} ${var.environment}"
      tags = {
        env = "${var.environment}"
      }
    }

    "${var.domain_name}" = {
      comment = "${var.domain_name}"
    }
  }

  tags = {
    ManagedBy = "Terraform"
  }
}

module "records" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  version = "~> 2.0"

  zone_name = keys(module.zones.route53_zone_zone_id)[0]

  records = [
    {
      name    = "ALB1"
      type    = "A"
      alias   = {
        name    = module.alb.lb_dns_name
        zone_id = module.alb.lb_zone_id
      }
    }
  ]

  depends_on = [module.zones]
}
