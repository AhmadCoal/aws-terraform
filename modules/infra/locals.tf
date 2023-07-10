locals {
  azs = data.aws_availability_zones.available.names

  public_subnets  = [
    for num in local.azs:
      cidrsubnet(lookup(var.vpc_cidr, var.environment), 8, index(local.azs, num))
  ]

  private_subnets = var.private_subnets
}

# ACL 
locals {
  public_acl_in_out_access = [
              #Get/Send traffic from/to internet. 80
              {
                "cidr_block": "0.0.0.0/0",
                "from_port": 80,
                "protocol": "tcp",
                "rule_action": "allow",
                "rule_number": 100,
                "to_port": 80
              },
              #Get/Send traffic from/to internet. 443
              {
                "cidr_block": "0.0.0.0/0",
                "from_port": 443,
                "protocol": "tcp",
                "rule_action": "allow",
                "rule_number": 101,
                "to_port": 443
              },
              #Get/Send icmp traffic from/to internet. 80
              {
                "cidr_block": "0.0.0.0/0",
                "from_port": 0,
                "protocol": "icmp",
                "rule_action": "allow",
                "rule_number": 119,
                "to_port": 0
              },
              {
                "cidr_block": "${var.private_subnets[0]}",
                "from_port": 0,
                "protocol": "icmp",
                "rule_action": "allow",
                "rule_number": 120,
                "to_port": 0
              },
              {
                "cidr_block": "${var.private_subnets[1]}",
                "from_port": 0,
                "protocol": "icmp",
                "rule_action": "allow",
                "rule_number": 121,
                "to_port": 0
              },
              #Get/Send traffic from/to wp/private. 443
              {
                "cidr_block": "${var.private_subnets[0]}",
                "from_port": 443,
                "protocol": "tcp",
                "rule_action": "allow",
                "rule_number": 102,
                "to_port": 443
              },
              #Get/Send traffic from/to wp. 80
              {
                "cidr_block": "${var.private_subnets[0]}",
                "from_port": 80,
                "protocol": "tcp",
                "rule_action": "allow",
                "rule_number": 103,
                "to_port": 80
              },
              # Let them all ssh for each other for time :)
              {
                "cidr_block": "${var.private_subnets[0]}",
                "from_port": 22,
                "protocol": "tcp",
                "rule_action": "allow",
                "rule_number": 104,
                "to_port": 22
              },
              {
                "cidr_block": "${var.private_subnets[1]}",
                "from_port": 22,
                "protocol": "tcp",
                "rule_action": "allow",
                "rule_number": 105,
                "to_port": 22
              },
              #Get/Send traffic from/to wp/private. 443
              {
                "cidr_block": "${var.private_subnets[1]}",
                "from_port": 443,
                "protocol": "tcp",
                "rule_action": "allow",
                "rule_number": 106,
                "to_port": 443
              },
              #Get/Send traffic from/to wp. 80
              {
                "cidr_block": "${var.private_subnets[1]}",
                "from_port": 80,
                "protocol": "tcp",
                "rule_action": "allow",
                "rule_number": 107,
                "to_port": 80
              }
    ]
 
    private_acl_in_out_access = [
              # Private/WP should be able to send/get traffic to/from db subnets on db port
              {
                "cidr_block": lookup("${var.private_db_subnets}", var.environment)[0]
                "from_port": "${var.database_port}",
                "protocol": "tcp",
                "rule_action": "allow",
                "rule_number": 108,
                "to_port": "${var.database_port}"
              },
              {
                "cidr_block": lookup("${var.private_db_subnets}", var.environment)[1]
                "from_port": "${var.database_port}",
                "protocol": "tcp",
                "rule_action": "allow",
                "rule_number": 109,
                "to_port": "${var.database_port}"
              },
              # Private/WP should be able to send/get traffic from/to public subnets 80.
              {
                "cidr_block": "${local.public_subnets[0]}"
                "from_port": "${var.application_port}",
                "protocol": "tcp",
                "rule_action": "allow",
                "rule_number": 110,
                "to_port": "${var.application_port}"
              },
              {
                "cidr_block": "${local.public_subnets[1]}"
                "from_port": "${var.application_port}",
                "protocol": "tcp",
                "rule_action": "allow",
                "rule_number": 111,
                "to_port": "${var.application_port}"
              },
              # Private/WP should be able to send/get traffic from/to public subnets 443.
              {
                "cidr_block": "${local.public_subnets[0]}"
                "from_port": "${var.application_secure_port}"
                "protocol": "tcp",
                "rule_action": "allow",
                "rule_number": 112,
                "to_port": "${var.application_secure_port}"
              },
              {
                "cidr_block": "${local.public_subnets[1]}"
                "from_port": "${var.application_secure_port}"
                "protocol": "tcp",
                "rule_action": "allow",
                "rule_number": 113,
                "to_port": "${var.application_secure_port}"
              },
              # Let them all ssh for each other for time :)
              {
                "cidr_block": "${local.public_subnets[0]}",
                "from_port": 22,
                "protocol": "tcp",
                "rule_action": "allow",
                "rule_number": 114,
                "to_port": 22
              },
              {
                "cidr_block": "${local.public_subnets[1]}",
                "from_port": 22,
                "protocol": "tcp",
                "rule_action": "allow",
                "rule_number": 115,
                "to_port": 22
              },
              {
                "cidr_block": "${local.public_subnets[0]}",
                "from_port": 0,
                "protocol": "icmp",
                "rule_action": "allow",
                "rule_number": 122,
                "to_port": 0
              },
              {
                "cidr_block": "${local.public_subnets[1]}",
                "from_port": 0,
                "protocol": "icmp",
                "rule_action": "allow",
                "rule_number": 123,
                "to_port": 0
              },
              {
                "cidr_block": "${var.private_subnets[0]}",
                "from_port": 22,
                "protocol": "tcp",
                "rule_action": "allow",
                "rule_number": 124,
                "to_port": 22
              },
              {
                "cidr_block": "${var.private_subnets[1]}",
                "from_port": 22,
                "protocol": "tcp",
                "rule_action": "allow",
                "rule_number": 125,
                "to_port": 22
              },
    ]

    db_acl_in_out_access = [
              # DB should be able to send/get traffic from/to wp/private subnets on database port.
              {
                "cidr_block": lookup("${var.private_wp_subnets}", var.environment)[0]
                "from_port": "${var.database_port}",
                "protocol": "tcp",
                "rule_action": "allow",
                "rule_number": 117,
                "to_port": "${var.database_port}"
              },
              {
                "cidr_block": lookup("${var.private_wp_subnets}", var.environment)[1]
                "from_port": "${var.database_port}",
                "protocol": "tcp",
                "rule_action": "allow",
                "rule_number": 118,
                "to_port": "${var.database_port}"
              }

    ]

  public_inbound_acl_rules     = local.public_acl_in_out_access
  public_outbound_acl_rules    = local.public_acl_in_out_access

  private_outbound_acl_rules   = local.private_acl_in_out_access
  private_inbound_acl_rules    = local.private_acl_in_out_access

  database_inbound_acl_rules   = local.db_acl_in_out_access
  database_outbound_acl_rules  = local.db_acl_in_out_access

}


