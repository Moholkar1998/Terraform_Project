resource "aws_instance" "this" {
  ami             = var.ami
  instance_type   = var.instance_type
  security_groups = var.security_groups
  key_name        = var.key_name
  subnet_id       = var.subnet_id

  # Merge both tags in a single definition
  tags = merge(
    var.tags,  # This is your existing tags from the variable
    {
      Name = "Jenkins-EC2"  # Additional tag for this specific instance
    }
  )

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo amazon-linux-extras install java-openjdk11 -y
              sudo yum install git -y
              sudo yum install docker -y
              sudo service docker start
              sudo usermod -aG docker ec2-user
              curl -fsSL https://get.jenkins.io/war/2.319/jenkins.war -o /home/ec2-user/jenkins.war
              java -jar /home/ec2-user/jenkins.war & disown
              EOF
}
