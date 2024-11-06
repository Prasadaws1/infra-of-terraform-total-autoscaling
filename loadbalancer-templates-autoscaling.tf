resource "aws_launch_configuration" "mylc" {
name = "terraform-template"
description = "my new templates"

image_id = "ami-04a37924ffe27da53"
instance_type = "t2.micro"
key_name = "5newpair"
security_groups = [aws_security_group.mysg.id]

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


resource "aws-elb" "myelb" {
name = "terraform-ld"
subnets = [aws_subnet.two.id, aws_subnet.three.id]
security_group = [aws_security-group.mysg.id]
listener {
instance_port = 80
instance_protocol = "httpd"
lb_port = 80
lb_protocol = "httpd"
}
}

