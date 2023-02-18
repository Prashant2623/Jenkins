provider "aws"{
region = "us-east-1"
}

variable  vpc_cidr_block {
    default = "10.0.0.0/16"
}
variable  subnet_cidr_block {
    default = "10.0.10.0/24"
}
variable  avail_zone {
    default = "us-east-1a"
}  
variable  env_prefix {
    default = "dev"
}
variable instance_type {
    default = "t2.micro"
}

resource "aws_vpc" "myapp-vpc" {
  cidr_block =  var.vpc_cidr_block
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

resource "aws_default_route_table" "main-rtb" {
  default_route_table_id =  aws_vpc.myapp-vpc.default_route_table_id
   route {
     cidr_block = "0.0.0.0/0" 
     gateway_id = aws_internet_gateway.myapp-igw.id
   }
   tags = {
      Name: "${var.env_prefix}-main-rtb"
   }
}

resource "aws_internet_gateway" "myapp-igw" {
   vpc_id = aws_vpc.myapp-vpc.id
   tags = {
      Name: "${var.env_prefix}-igw"
   }
}

resource "aws_default_security_group" "default-sg" {
  vpc_id = aws_vpc.myapp-vpc.id  

ingress {                                      
  from_port = 22             
  to_port = 22
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"] 
}
ingress {                                    
  from_port = 8080                
  to_port = 8080
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]          
 }
egress {                                      
  from_port = 0                
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]            
 }
 tags = {
      Name: "${var.env_prefix}-sg"
   }  
}

data "aws_ami" "amzlinux" {
  most_recent = true
  owners = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-gp2"]
  }
  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "myapp-server" {
  ami = data.aws_ami.amzlinux.id
  instance_type = "t2.micro"
  subnet_id = aws_subnet.myapp-subnet-1.id
  vpc_security_group_ids = [aws_default_security_group.default-sg.id]
  availability_zone = var.avail_zone
  associate_public_ip_address = true   
  key_name = "demo"   
  user_data = file("entry-script.tpl")
tags = {
      Name: "${var.env_prefix}-server"
   }   
}
output "ec2_public_ip" {
     value = aws_instance.myapp-server.public_ip
}