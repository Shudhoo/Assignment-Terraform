
resource "aws_vpc" "example-vpc" {
    cidr_block = var.vpc_cidr
    tags = {
      Name = "assignmnet_vpc"
    }
}

resource "aws_subnet" "example-subnet" {
  vpc_id = aws_vpc.example-vpc.id
  cidr_block = var.subnet_cidr
  tags = {
    Name = "assignment_subnet"
  }
}

resource "aws_internet_gateway" "example-IG" {
  vpc_id = aws_vpc.example-vpc.id

  tags = {
    Name = "IGW"
  }
}

resource "aws_route_table" "example-route-table" {
  vpc_id = aws_vpc.example-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.example-IG.id
  }
}

resource "aws_route_table_association" "example-route-table-association" {
  subnet_id = aws_subnet.example-subnet.id
  route_table_id = aws_route_table.example-route-table.id
}


resource "aws_instance" "example-1" {
  subnet_id = aws_subnet.example-subnet.id
  ami = var.ami-region-1
  instance_type = var.instance_type
  tags = {
    Name = "assignment-4"
  }
}
