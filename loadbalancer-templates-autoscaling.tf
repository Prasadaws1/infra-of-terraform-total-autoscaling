############################# template creation 1step#######################

resource "aws_launch_configuration" "mylc" {
name = "terraform-template"
description = "my new templates"

image_id = "ami-04a37924ffe27da53"
instance_type = "t2.micro"
key_name = "5newpair"
security_groups = [aws_security_group.mysg.id]
###########script##################
 user_data = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install httpd -y
    sudo systemctl start httpd
    sudo systemctl enable httpd
    sudo systemctl restart httpd
    sudo chmod 766 /var/www/html/index.html
    sudo echo "<html><body><h1>Welcome to Terraform Scaling.</h1></body></html>">/var/www/html/index.html
 EOF
}

#######################creating loadbalancer############################
resource "aws_elb" "myelb" {
name = "terraformelb"
subnets = [aws_subnet.two.id, aws_subnet.three.id]
security_groups = [aws_security_group.mysg.id]
listener {
instance_port = 80
instance_protocol = "http"
lb_port = 80
lb_protocol = "http"
}
}

#######################autoscalinggroup#################
resource "aws_autoscaling_group" "myasg" {
name = "myscale"
launch_configuration = aws_launch_template.mylc.id
min_size = 2
max_size = 5
desired_capacity = 2
health_check_type = "EC2"

load_balancers = [aws_elb.myelb.id]
vpc_zone_identifier = [aws_subnet.two.id, aws_subnet.three.id]
}
