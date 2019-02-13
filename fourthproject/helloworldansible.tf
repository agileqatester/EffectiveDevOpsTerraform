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

# Provisioner for applying Ansible playbook in Pull mode
  provisioner "remote-exec" {
    connection {
      user = "ec2-user"
      private_key = "${file("~/.ssh/EffectiveDevOpsAWS.pem")}"
    }
    inline = [
      "sudo yum install --enablerepo=epel -y ansible git",
      "sudo ansible-pull -U https://github.com/yogeshraheja/ansible helloworld.yml -i localhost",
    ]
  }
  
}


# IP address of newly created EC2 instance
output "myserver" {
 value = "${aws_instance.myserver.public_ip}"
}
