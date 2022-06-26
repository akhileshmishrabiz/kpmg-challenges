# Creating web servers in public subnets
resource "aws_instance" "web_server_a" {

  ami               = data.aws_ami.amazon_linux.id
  instance_type     = "t2.micro"
  subnet_id         = aws_subnet.public-a.id
  availability_zone = "${data.aws_region.current.name}a"
  user_data         = file("websetup.sh")
  vpc_security_group_ids = [
    aws_security_group.ssh.id,
    aws_security_group.http.id,
    aws_security_group.https.id
  ]
  key_name = "terraform-access-key"
  tags = merge(
    local.common_tags,
    tomap({ "Name" = "${local.prefix}-web1" })

  )

}



resource "aws_instance" "web_server_b" {

  ami               = data.aws_ami.amazon_linux.id
  instance_type     = "t2.micro"
  subnet_id         = aws_subnet.public-b.id
  user_data         = file("websetup.sh")
  availability_zone = "${data.aws_region.current.name}b"
  vpc_security_group_ids = [
    aws_security_group.ssh.id,
    aws_security_group.http.id,
    aws_security_group.https.id
  ]
  key_name = "terraform-access-key"
  tags = merge(
    local.common_tags,
    tomap({ "Name" = "${local.prefix}-web2" })

  )

}

######################################################################
## Creating ec2 instances in private subnet for app 

resource "aws_instance" "app_server_a" {

  ami               = data.aws_ami.amazon_linux.id
  instance_type     = "t2.micro"
  subnet_id         = aws_subnet.private-a.id
  availability_zone = "${data.aws_region.current.name}a"
  vpc_security_group_ids = [
    aws_security_group.ssh.id,

  ]
  key_name = "terraform-access-key"
  tags = merge(
    local.common_tags,
    tomap({ "Name" = "${local.prefix}-app1" })

  )

}


resource "aws_instance" "app_server_b" {

  ami               = data.aws_ami.amazon_linux.id
  instance_type     = "t2.micro"
  subnet_id         = aws_subnet.private-b.id
  availability_zone = "${data.aws_region.current.name}b"
  vpc_security_group_ids = [
    aws_security_group.ssh.id,

  ]
  key_name = "terraform-access-key"
  tags = merge(
    local.common_tags,
    tomap({ "Name" = "${local.prefix}-app2" })

  )

}
