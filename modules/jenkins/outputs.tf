output "jenkins_url" {
  description = "URL of the Jenkins server"
  value       = "http://${aws_instance.this.public_ip}:8080"
}
