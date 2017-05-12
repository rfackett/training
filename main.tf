provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

resource "aws_instance" "web" {
  count                  = "${var.num_webs}"
  ami                    = "ami-da4c29ba"
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["sg-f13c508a"]
  subnet_id              = "subnet-5ba79c3f"
  key_name               = "fogops-supportfog"

  tags {
    CostCenter  = "ryan@foghornconsulting.com"
    Environment = "hashitraining"
    Name        = "web ${count.index + 1}/${var.num_webs}"
  }
}
resource "garbage" "garbage"{
  garbage = garbage
  }

terraform {
  backend "atlas" {
    name = "rfackett/training"
  }
}

variable "aws_region" {
  default = "us-west-2"
}

variable "aws_access_key" {}

variable "aws_secret_key" {}

variable "num_webs" {
  default = 3
}

output "public_ip" {
  value = ["${aws_instance.web.*.public_ip}"]
}

output "public_dns" {
  value = ["${aws_instance.web.*.public_dns}"]
}
