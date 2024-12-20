provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      hashicorp-learn = "module-use"
    }
  }
}
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.18.1"

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs             = var.vpc_azs
  private_subnets = var.vpc_private_subnets
  public_subnets  = var.vpc_public_subnets

  enable_nat_gateway = var.vpc_enable_nat_gateway

  tags = var.vpc_tags
}

module "ec2_instances" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "4.3.0"
  count   = 2

  name            = "practical-task-ec2"
  ami             = "ami-0c2b8ca1dad447f8a" # Amazon Linux 2 Free Tier
  instance_type   = "t2.micro"
  vpc_security_group_ids = [module.ec2_security_group.security_group_id]
  subnet_id       = module.vpc.private_subnets[count.index]

  user_data = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo amazon-linux-extras enable nginx1 -y
    sudo yum install nginx -y
    sudo systemctl enable nginx
    sudo systemctl start nginx

    # Personalizar el contenido del archivo index.html
    INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
    echo "<html><body><h1>Hola desde EC2 $INSTANCE_ID</h1></body></html>" > /usr/share/nginx/html/index.html
  EOF

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

# module "ec2_instances" {
#   source  = "terraform-aws-modules/ec2-instance/aws"
#   version = "4.3.0"
#   count   = 2

#   name = "practical-task-ec2"
#   ami           = "ami-0c2b8ca1dad447f8a" # Amazon Linux 2 Free Tier
#   instance_type          = "t2.micro"
#   vpc_security_group_ids = [module.ec2_security_group.security_group_id]
#   subnet_id = module.vpc.private_subnets[count.index]
#   user_data = <<-EOF
#     #!/bin/bash
#     sudo yum update -y
#     sudo amazon-linux-extras enable nginx1
#     sudo yum install nginx -y
#     sudo systemctl enable nginx
#     sudo systemctl start nginx
#     echo "<html><body><h1>Hello from Nginx!</h1></body></html>" | sudo tee /usr/share/nginx/html/index.html
#     EOF

#   tags = {
#     Terraform   = "true"
#     Environment = "dev"
#   }
# }

module "ec2_security_group" {
#   source  = "terraform-aws-modules/security-group/aws//modules/web"
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.2"

  name        = "practical-task-ec2-sg"
  description = "Security group for EC2 instances allowing traffic from ELB"
  vpc_id      = module.vpc.vpc_id
  ingress_with_source_security_group_id = [{
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    description = "Allow HTTP traffic from ELB"
    source_security_group_id = module.lb_security_group.security_group_id
  }]
  egress_rules = ["all-all"]

#   egress_cidr_blocks = ["0.0.0.0/0"]
}

module "lb_security_group" {
#   source  = "terraform-aws-modules/security-group/aws//modules/web"
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.2"
  name        = "practical-task-lb-sg"
  description = "Security group for load balancer with HTTP ports open within VPC"
  vpc_id      = module.vpc.vpc_id
  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp"]
  egress_rules = ["all-all"]
}

module "elb_http" {
  source  = "terraform-aws-modules/elb/aws"
  version = "4.0.2"

  # Ensure load balancer name is unique
  name = "practical-task-lb"
  internal = false
  
#   security_groups = [module.lb_security_group.security_group_id]
  security_groups = [module.lb_security_group.security_group_id]
  subnets         = module.vpc.public_subnets
  number_of_instances = length(module.ec2_instances[*].id)
  instances           = module.ec2_instances[*].id
  listener = [{
    instance_port     = "80"
    instance_protocol = "HTTP"
    lb_port           = "80"
    lb_protocol       = "HTTP"
  }]
  health_check = {
    target              = "HTTP:80/index.html"
    interval            = 10
    healthy_threshold   = 3
    unhealthy_threshold = 10
    timeout             = 5
  }
}