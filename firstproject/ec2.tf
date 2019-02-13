# Provider Configuration for AWS
provider "aws" {
  shared_credentials_file = "/home/vagrant/.aws/credentials"
  profile                 = "default"  
  region     = "us-east-1"
}

# Resource Configuration for AWS
resource "aws_instance" "myserver" {
  ami = "ami-cfe4b2b0"
  instance_type = "t2.micro"
  key_name = "EffectiveDevOpsAWS"
  vpc_security_group_ids = ["sg-08f0993b19beb2229"]

  tags {
    Name = "helloworld"
  }
}
