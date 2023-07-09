module "db" {
  source = "terraform-aws-modules/rds/aws"

  identifier = "${var.environment}-postgres"

  engine                              = "postgres"
  engine_version                      = "11.16"
  instance_class                      = "db.t3.micro"
  allocated_storage                   = 5

  # hardcoded some vars for the sake of time.
  db_name                             = "RDS1"
  username                            = "rds1"
  port                                = "3306"
  manage_master_user_password         = true

  iam_database_authentication_enabled = true

  vpc_security_group_ids = [
    aws_security_group.db_internal.id,
    aws_security_group.ping_internal.id
    ]

  # Day 2 operations config
  # maintenance_window                = "Mon0000-Mon0300"
  # backup_window                     = "03:00-06:00"
  monitoring_interval                 = "30"
  monitoring_role_name                = "RDS1MonitoringRole"
  create_monitoring_role              = true

  tags = {
    Environment                       = "${var.environment}"
    type                              = "private"
  }

  create_db_subnet_group              = true
  db_subnet_group_name                = "${var.environment}-postgres"
  subnet_ids                          = module.vpc.database_subnets
  family                              = "postgres11"
  major_engine_version                = "11.16"
  deletion_protection                 = var.deletion_protection

  parameters = []
  options = []
}