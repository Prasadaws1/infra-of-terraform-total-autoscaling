resource "aws_security_group" "mysg" {
name = "my terraform sg"
description = "it hs all the code"
vpc_id = aws_vpc.one.id

ingress {
from_port = "0"
to_port = "0"
protocol = "-1"
cidr_blocks = ["0.0.0.0/0"]
}

egress {
from_port = "0"
to_port = "0"
protocol = "-1"
cidr_blocks = ["0.0.0.0/0"]
}
}
