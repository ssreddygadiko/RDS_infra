#Launching the RDS instance by using new vpc with 2 subnets
#AWS access keys
provider "aws" {
access_key = "${var.aws_access_key}"
secret_key = "${var.aws_secret_key}"
region = "${var.aws_region}"
}

#Creating the vpc
resource "aws_vpc" "vpc" {
cidr_block = "${var.cidr}"
instance_tenancy = "${var.instance_tenancy}"
tags {
Name = "${var.name}"
}
}

#Creating subnet-1
resource "aws_subnet" "subnet1" {
vpc_id = "${aws_vpc.vpc.id}"
cidr_block = "${var.subnet1_cidr}"
availability_zone = "${var.av_zone_1}"
tags{
Name = "${var.sub_name_1}"
}
}

#Creating subnet-2
resource "aws_subnet" "subnet2" {
vpc_id = "${aws_vpc.vpc.id}"
cidr_block = "${var.subnet2_cidr}"
availability_zone = "${var.av_zone_2}"
tags{
Name = "${var.sub_name_2}"
}
}


#Creating DBSubnetgroup
resource "aws_db_subnet_group" "subnetgroup" {
subnet_ids = ["${aws_subnet.subnet1.id}", "${aws_subnet.subnet2.id}"]
name = "${var.db_name}"
}


resource "aws_security_group" "rds" {
  name = "${var.db_name}"

  description = "RDS mysql servers (terraform-managed)"
  vpc_id = "${aws_vpc.vpc.id}"

  # Only mysql in
  ingress {
    from_port = "${var.ingress_from_port_mysql}"
    to_port = "${var.ingress_to_port_mysql}"
    protocol = "${var.ingress_ip_protocol_type_mysql}"
    cidr_blocks = ["${var.ingress_cidr_mysql}"]
  }
  # Allow all outbound traffic.
  egress {
    from_port = "${var.egress_from_port-1}"
    to_port = "${var.egress_to_port-1}"
    protocol = "${var.egress_ip_protocol_type}"
    cidr_blocks = ["${var.egress_cidr}"]
  }
tags{
Name = "${var.db_security_group_name}"
}
}

#Resource to create the db parameter group
resource "aws_db_parameter_group" "parametergroup" {
name = "${var.db_name}"
family = "${var.rds_pg_family}"

parameter {
    name  = "character_set_server"
    value = "utf8"
  }

  parameter {
    name  = "character_set_client"
    value = "utf8"
  }
}

#Resource to create the db instance
resource "aws_db_instance" "rds" {
  allocated_storage        = "${var.db_storage}" 
  backup_retention_period  = "${var.db_backup_retention_period}"   
  db_subnet_group_name     = "${aws_db_subnet_group.subnetgroup.id}"
  engine                   = "${var.db_engine}"
  engine_version           = "${var.db_engine_version}"
  identifier               = "${var.db_name}"
  instance_class           = "${var.db_instance_type}"
  multi_az                 = "${var.db_multi_az}"
  name                     = "${var.db_name}"
  parameter_group_name     = "${aws_db_parameter_group.parametergroup.id}" 
  password                 = "${var.db_password}"
  port                     = "${var.db_port}"
  publicly_accessible      = "${var.db_publicy_accessible}"
  storage_encrypted        = "${var.db_stroage_encrypted}"
  storage_type             = "${var.db_storage_type}"
  username                 = "${var.db_name}"
  vpc_security_group_ids   = ["${aws_security_group.rds.id}"]
  skip_final_snapshot	   = "${var.db_skip_final_snapshot}"
}

