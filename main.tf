provider "aws" {
  profile                 = "${var.aws_profile}"
  shared_credentials_file = "~/.aws/credentials"
  region                  = "${var.aws_region}"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami                 = "${data.aws_ami.ubuntu.id}"
  instance_type       = "${var.instance_size}"
  vpc_security_groups = ["${aws_security_group.allow_ssh_and_http.id}"]
  subnet_id           = "${var.subnet_id}"
  key_name            = "${var.keyname}"

  provisioner "remote-exec" {
    connection {
      type = "ssh"
      user = "ubuntu"

      #   private_key = "${file("demo.pem")}"

      private_key = "${var.key_contents}"
    }

    inline = [
      "sudo apt-get install -y apache2",
      "sudo ufw allow 'Apache Full'",
    ]
  }

  tags {
    Name = "HelloWorld"
  }
}
