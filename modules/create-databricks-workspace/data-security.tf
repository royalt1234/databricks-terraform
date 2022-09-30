######## data ###
data "aws_availability_zones" "available" {
  state = "available"
}


data "aws_vpc" "vpc" {
  id = var.vpc_id
}

data "aws_subnets" "subnet" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }
}

##security group ###
resource "aws_security_group" "sg" {
  name = "databricks-workspace-sg"
  description = "security group for databricks workspace"

  egress {
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = data.aws_vpc.vpc.id
}

