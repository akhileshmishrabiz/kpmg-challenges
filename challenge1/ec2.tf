
resource "aws_instance" "web_server_a" {

  ami               = data.aws_ami.amazon_linux.id
  instance_type     = "t2.micro"
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

  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t2.micro"
  user_data              = file("websetup.sh")
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

