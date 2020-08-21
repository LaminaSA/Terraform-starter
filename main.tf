provider "aws" {
# which region is the AMI available in (in my case it's ireland)
   region = "eu-west-1"

}

# create an instance - launch an instace from AMI

resource "aws_instance" "app_instance" {
          ami          = "ami-0916351ac92849e5b"

# what type of ec2 instance we want to create t2micro
	  instance_type = "t2.micro"

# setting up public IP
	  associate_public_ip_address = true

	  tags = {
          Name = "agbo.terraform.ec2"
	  }
           
}


# creating subnet block of code 
# attatch this subnet to your vpc

resource "aws_subnet" "agbo_public_subnet" {
  vpc_id     = "vpc-09c7307405e98bcae"
  cidr_block = "100.0.0.0/24"

  tags = {
    Name = "agbo_subnet"
  }
}



resource "aws_security_group" "agbo_terraform_sg" {
  name        = "agbo_terraform_sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = "vpc-09c7307405e98bcae"

  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["100.0.0.0/24"] 

  }


  egress {
    from_port     = 0
    to_port       = 0
    protocol      = "-1"
    cidr_blocks   = ["0.0.0.0/0"]
  }  

  tags = {
    Name = "agbo_terraform_cidr"
  }
}