output "elb_dns_name" {
  value = module.elb_http.elb_dns_name
  description = "DNS Name of the Load Balancer"
}
