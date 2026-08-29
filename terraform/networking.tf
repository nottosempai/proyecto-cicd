resource "aws_vpc" "principal" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name     = "proyecto-cicd-vpc"
    Proyecto = "proyecto-cicd"
  }
}

resource "aws_internet_gateway" "principal" {
  vpc_id = aws_vpc.principal.id

  tags = {
    Name     = "proyecto-cicd-igw"
    Proyecto = "proyecto-cicd"
  }
}

resource "aws_subnet" "publica_1" {
  vpc_id                  = aws_vpc.principal.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name     = "proyecto-cicd-publica-1"
    Proyecto = "proyecto-cicd"
  }
}

resource "aws_subnet" "publica_2" {
  vpc_id                  = aws_vpc.principal.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name     = "proyecto-cicd-publica-2"
    Proyecto = "proyecto-cicd"
  }
}

resource "aws_route_table" "publica" {
  vpc_id = aws_vpc.principal.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.principal.id
  }

  tags = {
    Name     = "proyecto-cicd-publica"
    Proyecto = "proyecto-cicd"
  }
}

resource "aws_route_table_association" "publica_1" {
  subnet_id      = aws_subnet.publica_1.id
  route_table_id = aws_route_table.publica.id
}

resource "aws_route_table_association" "publica_2" {
  subnet_id      = aws_subnet.publica_2.id
  route_table_id = aws_route_table.publica.id
}

resource "aws_security_group" "ecs" {
  name        = "proyecto-cicd-ecs"
  description = "Permitir acceso a la API Flask"
  vpc_id      = aws_vpc.principal.id

  ingress {
    description = "API Flask"
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Permitir conexiones salientes"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name     = "proyecto-cicd-ecs"
    Proyecto = "proyecto-cicd"
  }
}