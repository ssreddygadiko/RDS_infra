#Aws config

variable "aws_access_key" {
default = "XXXXXXXXXXXXXXXX"
}

variable "aws_secret_key" {
default = "XXXXXXXXXXXXXXXXXXXXXXXXXXX"
}

variable "aws_region" {
default = "ap-south-1"
}

variable "cidr" {
default = "10.0.0.0/16"
}

variable "instance_tenancy" {
default = "dedicated"
}

variable "name" {
default = "rds"
}

variable "subnet1_cidr" {
default = "10.0.5.0/24"
}

variable "av_zone_1" {
default = "ap-south-1a"
}

variable "sub_name_1" {
default = "rds"
}

variable "subnet2_cidr" {
default = "10.0.9.0/24"
}

variable "av_zone_2" {
default = "ap-south-1b"
}

variable "sub_name_2" {
default = "rds"
}


variable "db_subnet_group_name" {
default = "rds"
}

variable "ingress_cidr_mysql" {
default = "0.0.0.0/0"
}

variable "ingress_ip_protocol_type_mysql" {
default = "tcp"
}

variable "ingress_from_port_mysql" {
default = "3306"
}

variable "ingress_to_port_mysql" {
default = "3306"
}


variable "egress_cidr" {
default = "0.0.0.0/0"
}

variable "egress_from_port-1" {
default = "0"
}

variable "egress_to_port-1" {
default = "0"
}

variable "egress_ip_protocol_type" {
default = "-1"
}

variable "db_security_group_name" {
default = "rds"
}

variable "rds_pg_family" {
default = "mysql5.7"
}

variable "db_storage" {
default = "20"
}

variable "db_backup_retention_period" {
default = "7"
}

variable "db_engine" {
default = "mysql"
}

variable "db_engine_version" {
default = "5.7.26"
}

variable "db_name" {
default = "mydb1"
}

variable "db_password" {
default = "crimsoncloud"
}

variable "db_instance_type" {
default = "db.m4.large"
}

variable "db_multi_az" {
default = "false"
}

variable "db_port" {
default = "3306"
}

variable "db_publicy_accessible" {
default = "false"
}

variable "db_stroage_encrypted" {
default = "false"
}

variable "db_storage_type" {
default = "gp2"
}

variable "db_skip_final_snapshot" {
default = "true"
}

