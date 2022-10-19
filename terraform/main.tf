#Configure the AWS Provider
provider "aws" {
  region = var.region
}
# variables defined
variable vpc_cidr_block {
  default= "10.0.0.0/16"
}
variable subnet_cidr_block{
  default= "10.0.10.0/24"
}
variable env_prefix {
  default= "Dev"
}
variable avail_zone{
  default= "us-east-1a"
}
variable region{
  default="us-east-1"
}

# Create a Dev VPC and Dev subnet
resource "aws_vpc" "myapp-vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name: "${var.env_prefix}-vpc"     
  }
} 
resource "aws_subnet" "myapp-subnet-1" {
  vpc_id = aws_vpc.myapp-vpc.id
  cidr_block = var.subnet_cidr_block
  availability_zone = var.avail_zone
  tags = {
    Name: "${var.env_prefix}-subnet-1"
  }
}
resource "aws_internet_gateway" "myapp-igw" {
  vpc_id = aws_vpc.myapp-vpc.id
  tags = {
    Name = "${var.env_prefix}-igw"
  }
}
#default route table 
resource "aws_default_route_table" "main-rt" {     
  default_route_table_id = aws_vpc.myapp-vpc.default_route_table_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myapp-igw.id
  }
  tags = {
    Name = "${var.env_prefix}-main-rt"
  }
}
#security groups 
resource "aws_security_group" "myapp-sg" {
  name        =  "myapp-sg"
  vpc_id      = aws_vpc.myapp-vpc.id

  ingress {
    description      = "SSH into the instance"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]                       # range of Ip adresses
   }
   ingress {
    from_port        = 0
    to_port          = 65535
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]                       
   }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
   Name = "${var.env_prefix}-sg"
  }
}
data "aws_ami" "ubuntu" {
  most_recent = true
  owners = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  
}
resource "aws_instance" "myapp-server" {
  ami = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id = aws_subnet.myapp-subnet-1.id
  vpc_security_group_ids = [aws_security_group.myapp-sg.id]
  availability_zone = var.avail_zone
  associate_public_ip_address = true
  key_name = "jenkins-terraform-demo3-key-pair"  
  user_data = file("userdata.tpl")
  tags = {
   Name = "${var.env_prefix}-jenkins-terraform demo"
  }
}
output "aws_ami_id"{
  value= data.aws_ami.ubuntu.id
}
output "aws_instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.myapp-server.public_ip
}

