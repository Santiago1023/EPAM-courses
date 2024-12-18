output "ec2_public_ip" {
  description = "Dirección IP pública de la EC2"
  value       = aws_instance.app_server.public_ip
}
