resource "aws_instance" "mvc_controller" {
  ami           = "ami-0c55b159cbfafe1f0" # Amazon Linux 2 (use region-specific)
  instance_type = "t3.micro"
  subnet_id     = var.subnet_ids[0]
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  user_data     = file("init_script.sh")

  tags = {
    Name = "MVC-Controller"
  }
}

resource "aws_security_group" "ec2_sg" {
  name        = "mvc-controller-sg"
  description = "Allow HTTP and SSH"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

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
}

output "public_ip" {
  value = aws_instance.mvc_controller.public_ip
}
