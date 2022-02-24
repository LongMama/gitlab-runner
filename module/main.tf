resource "aws_instance" "runner" {
  ami                    = data.aws_ami.latest_amazon_linux.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.runner_SG.id]
  user_data = templatefile("userdata.sh.tpl", {
    key   = file("id_rsa"),
    url   = var.url,
    token = var.token,
    tags  = var.tags,
    user  = var.user
  })
  key_name = data.aws_key_pair.key.key_name
  tags = {
    Name = "GitlabRunner"
    OS   = "Amazon Linux"
  }
}

resource "aws_security_group" "runner_SG" {
  name        = "RunnerSG"
  description = "Allow ssh inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Runner-SG"
  }
}
