module "alb" {
  source                = "terraform-aws-modules/alb/aws"
  version               = "~> 8.0"

  name                  = "${var.environment}-alb"

  load_balancer_type    = "application"

  vpc_id                = module.vpc.vpc_id
  subnets               = local.public_subnets
  security_groups       = [aws_security_group.alb_external.name]

  target_groups = [
    {
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
      targets = {
        my_target = {
          # could be done better but for time sake.
          target_id    = "${aws_instance.wpserver[0].id}"
          port = 80
        }
        my_other_target = {
          target_id     = "${aws_instance.wpserver[1].id}"
          port = 80
        }
      }
    }
  ]

  # No time
  # https_listeners = [
  #   {
  #     port               = 443
  #     protocol           = "HTTPS"
  #     certificate_arn    = "arnawsiam:123456789012server-certificate/test_cert-123456789012"
  #     target_group_index = 0
  #   }
  # ]

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]

  tags = {
    Environment          = "${var.environment}"
  }
}