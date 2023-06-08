output "ip_website" {
    description = "IP Publique du serveur web"
    value       = aws_instance.web_server.public_ip 
}
