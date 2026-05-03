# VPC Module

This module creates a Virtual Private Cloud (VPC) architecture in AWS, which includes public and private subnets, an internet gateway, a NAT gateway, route tables with proper routing configuration, and VPC flow logs enabled. The architecture is designed to secure resources while allowing internet access for public services and private services access through the NAT gateway.

## Inputs

variable "region" {
  description = "The AWS region to deploy the VPC in"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
}

## Resource Creation

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name    = "VPC"
    module  = "vpc"
    project = "Your_Project_Name"
  }
}

resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidrs)
  vpc_id = aws_vpc.main.id
  cidr_block = element(var.public_subnet_cidrs, count.index)
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name    = "Public Subnet ${count.index}"
    module  = "vpc"
    project = "Your_Project_Name"
  }
}

resource "aws_subnet" "private" {
  count = length(var.private_subnet_cidrs)
  vpc_id = aws_vpc.main.id
  cidr_block = element(var.private_subnet_cidars, count.index)
  availability_zone = element(data.aws_availability_zones.available.names, count.index)

  tags = {
    Name    = "Private Subnet ${count.index}"
    module  = "vpc"
    project = "Your_Project_Name"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name    = "Internet Gateway"
    module  = "vpc"
    project = "Your_Project_Name"
  }
}

resource "aws_route_table" "public_routes" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name    = "Public Route Table"
    module  = "vpc"
    project = "Your_Project_Name"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id = aws_subnet.public[0].id

  tags = {
    Name    = "NAT Gateway"
    module  = "vpc"
    project = "Your_Project_Name"
  }
}

resource "aws_eip" "nat" {
  vpc = true
}

resource "aws_route_table" "private_routes" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name    = "Private Route Table"
    module  = "vpc"
    project = "Your_Project_Name"
  }
}

resource "aws_vpc_flow_log" "example" {
  log_group_name         = "vpc-flow-logs"
  traffic_type           = "ALL"
  vpc_id                 = aws_vpc.main.id
  iam_role_arn          = aws_iam_role.flow_log_role.arn
}

# Note: The flow logs will help in monitoring the traffic for auditing and security purposes.

# Additional components like security groups can also be added to secure instances in the VPC.
