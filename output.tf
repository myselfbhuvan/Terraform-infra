output "portfolio_public_ip" {
  description = "Public IP address of the portfolio EC2 instance"
  value       = aws_instance.portfolio.public_ip
}

output "portfolio_url" {
  description = "URL to access the portfolio"
  value       = "http://${aws_instance.portfolio.public_ip}"
}
