resource "aws_security_group" "web" {
  name        = "lms-sasaki-web-sg"
  description = "Allow HTTP"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 80
    to_port     = 80
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
    owner  = "lms-sasaki"
    course = "aws-101"
  }
}

resource "aws_instance" "web" {
  ami                         = data.aws_ssm_parameter.al2023.value
  instance_type               = "t3.micro"
  subnet_id                   = tolist(data.aws_subnets.default.ids)[0]
  vpc_security_group_ids      = [aws_security_group.web.id]
  iam_instance_profile        = "lms-lab-ssm"
  associate_public_ip_address = true

  user_data = <<-USERDATA
    #!/bin/bash
    dnf install -y nginx
    echo "<h1>lms-sasaki ec2 nginx</h1>" > /usr/share/nginx/html/index.html
    systemctl enable --now nginx
  USERDATA

  tags = {
    owner  = "lms-sasaki"
    course = "aws-101"
    Name   = "lms-sasaki-web"
  }
}