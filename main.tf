provider "aws" {
  region = "us-east-1"
  access_key = "..."
  secret_key = "..."
}

resource "aws_vpc" "vpc-project4" {
    cidr_block = "10.2.0.0/16"
    tags = {
    Name = "vpc-project4"
    }
}

resource "aws_subnet" "pub-subnet" {
    vpc_id = aws_vpc.vpc-project4.id
    cidr_block = "10.2.254.0/24"
    tags = {
    Name = "pub-subnet"
    }
}

resource "aws_internet_gateway" "igw-vpc-project4" {
    vpc_id = aws_vpc.vpc-project4.id
    tags = {
    Name = "igw-vpc-project4"
    }
}

resource "aws_route_table" "rt-pub-project4" {
vpc_id = aws_vpc.vpc-project4.id
route {
cidr_block = "0.0.0.0/0"
gateway_id = aws_internet_gateway.igw-vpc-project4.id
}
tags = {
Name = "rt-pub-project4"
}
}

resource "aws_route_table_association" "rt-pub_association-project4" {
    subnet_id = aws_subnet.pub-subnet.id
    route_table_id = aws_route_table.rt-pub-project4.id
}

resource "aws_security_group" "sg_api_project4" {
  name        = "sg_api_project4"
  description = "sg_api_project4"
  vpc_id      = aws_vpc.vpc-project4.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }  

  tags = {
    Name = "sg_api_project4"
  }
}

resource "aws_instance" "project4" {
  ami           = "ami-0fc5d935ebf8bc3bc"
  instance_type = "t2.small"
  key_name      = "wcd-projects"
  subnet_id     = aws_subnet.pub-subnet.id
  vpc_security_group_ids = [
    aws_security_group.sg_api_project4.id
  ]
  associate_public_ip_address = true
  tags = {
    Name = "project4"
  }

  user_data = file("dockerinstall.sh")
}
