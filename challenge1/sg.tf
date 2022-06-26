resource "aws_security_group" "ssh" {

  description = "allow ssh to ec2"
  name        = "${local.prefix}-ssh_access"
  vpc_id      = aws_vpc.main.id

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["10.1.0.0/16"]
    #We can limit the ip here
  }
  tags = local.common_tags

}


resource "aws_security_group" "http" {

  description = "allow access to http trafic"
  name        = "${local.prefix}-http_access"
  vpc_id      = aws_vpc.main.id

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["10.1.1.0/24", "10.1.2.0/24"]
    #We can limit the ip here
  }
  tags = local.common_tags

}

resource "aws_security_group" "https" {

  description = "allow access to https trafic"
  name        = "${local.prefix}-https_access"
  vpc_id      = aws_vpc.main.id

  ingress {
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = ["10.1.1.0/24", "10.1.2.0/24"]
    #We can limit the ip here
  }
  tags = local.common_tags

}