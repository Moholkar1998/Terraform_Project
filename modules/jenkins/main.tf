resource "aws_security_group" "this" {
  name        = "jenkins-sg"
  description = "Security group for Jenkins EC2 instance"
  vpc_id      = var.vpc_id  # Pass the VPC ID from the parent module

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow inbound traffic to Jenkins on port 8080
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow SSH access
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.tags,  # Use existing tags
    { Name = "jenkins-sg" }
  )
}


resource "aws_instance" "this" {
  ami             = var.ami
  instance_type   = var.instance_type
  vpc_security_group_ids = [aws_security_group.this.id]
  key_name        = var.key_name
  subnet_id       = var.subnet_id
  associate_public_ip_address = true

  # Merge both tags in a single definition
  tags = merge(
    var.tags,  # This is your existing tags from the variable
    {
      Name = "Jenkins-EC2"  # Additional tag for this specific instance
    }
  )

  user_data = <<-EOF
              #!/bin/bash
# Update the system
sudo apt-get update -y
sudo apt-get upgrade -y

# Install Java OpenJDK 11
sudo apt-get install openjdk-11-jdk -y

# Install Git
sudo apt-get install git -y

# Install Docker
sudo apt-get install docker.io -y
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker ubuntu

# Install Jenkins
# Add Jenkins repository and key
sudo wget -q -O - https://pkg.jenkins.io/keys/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian/ $(lsb_release -cs) main > /etc/apt/sources.list.d/jenkins.list'

# Update and install Jenkins
sudo apt-get update -y
sudo apt-get install jenkins -y

# Start Jenkins service
sudo systemctl start jenkins
sudo systemctl enable jenkins

# Print Jenkins status (for debugging)
sudo systemctl status jenkins

              
              EOF

}

