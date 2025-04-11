resource "aws_db_instance" "mvc_db" {
  engine            = "mysql"
  instance_class    = "db.t3.micro"
  allocated_storage = 20
  name              = "mvcapp"
  username          = "admin"
  password          = "password123!"
  db_subnet_group_name = aws_db_subnet_group.db_subnets.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  skip_final_snapshot   = true
}

resource "aws_db_subnet_group" "db_subnets" {
  name       = "mvc-db-subnet-group"
  subnet_ids = var.subnet_ids
}

resource "aws_security_group" "rds_sg" {
  name   = "mvc-rds-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "db_endpoint" {
  value = aws_db_instance.mvc_db.endpoint
}
