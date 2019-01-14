resource "aws_key_pair" "aws_keypair" {
  key_name   = "terraform_keypair"
  public_key = "${file(var.ssh_key_public)}"
}

resource "aws_instance" "instance" {
  ami                         = "${data.aws_ami.amazon_linux.id}"
  instance_type               = "${var.instance_type}"
  security_groups             = ["${aws_security_group.instance_security_group.name}"]
  key_name                    = "${aws_key_pair.aws_keypair.key_name}"
  associate_public_ip_address = true
  count                       = 1

  lifecycle {
    create_before_destroy = true
  }

  provisioner "remote-exec" {
    # Install Python for Ansible
    inline = ["sudo yum install -y python libselinux-python"]

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = "${file(var.ssh_key_private)}"
      timeout = "2m"
      agent = false
    }
  }

  #provisioner "local-exec" {
    #command = "ansible-playbook -u fedora -i '${self.public_ip},' --private-key ${var.ssh_key_private} -T 300 provision.yml"
  #}
}

resource "aws_security_group" "instance_security_group" {
  name = "instance_security_group"

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

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
