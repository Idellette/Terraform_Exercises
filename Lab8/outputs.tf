output "ip_webserver1" {
    description = "IP Publique du serveur web"
    value       = module.server_website1.ip_website
}

output "ip_webserver2" {
    description = "IP Publique du serveur web"
    value       = module.server_website2.ip_website
}

output "ip_webserver3" {
    description = "IP Publique du serveur web"
    value       = module.server_website3.ip_website
}
