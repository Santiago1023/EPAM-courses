provider "aws" {
  region = "us-east-1" # Cambia por la región que prefieras
}

resource "aws_instance" "app_server" {
  ami           = "ami-0c2b8ca1dad447f8a" # Amazon Linux 2 Free Tier
  instance_type = "t2.micro"              # Elegible para el Free Tier
  key_name      = var.key_name            # Clave SSH para conectarte a la EC2

  # User data script para instalar y configurar la aplicación
  user_data = file("init-script.sh")

  tags = {
    Name = "AppServer"
  }

  # Abrir puertos para la aplicación
  security_groups = [aws_security_group.app_sg.name]
}

resource "aws_security_group" "app_sg" {
  name        = "app_sg"
  description = "Allow HTTP and Node.js traffic"

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3030
    to_port     = 3030
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Solo para pruebas, restringir más adelante
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# output "ec2_public_ip" {
#   description = "Public IP of the EC2 instance"
#   value       = aws_instance.app_server.public_ip
# }
