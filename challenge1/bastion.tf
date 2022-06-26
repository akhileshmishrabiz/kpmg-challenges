
data "aws_ami" "amazon_linux" {
  most_recent = true
  filter {

    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-2.0.*-x86_64-gp2"]
  }
  owners = ["amazon"]

}

resource "aws_security_group" "bastion_server" {
  name        = "bastion_server_sg"
  description = "Will allow ssh to bastion server"


  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

}





#creating role for bastion server to access S3 
resource "aws_iam_role" "bastion_role" {
  name = "${local.prefix}-bastion_server"
  assume_role_policy = jsonencode({
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "bastion" {
  role       = aws_iam_role.bastion_role.name
  policy_arn = "arn:aws:iam::594814570036:policy/bastion-bucket"
}


resource "aws_iam_instance_profile" "bastion_profile" {
  name = "bastion-profile"
  role = aws_iam_role.bastion_role.name
}

resource "aws_instance" "bastion_server" {

  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"
  #user_data     = file("")
  vpc_security_group_ids = [aws_security_group.bastion_server.id]
  key_name               = "terraform-access-key"
  iam_instance_profile   = aws_iam_instance_profile.bastion_profile.name
  availability_zone      = "${data.aws_region.current.name}b"


  tags = merge(
    local.common_tags,
    tomap({ "Name" = "${local.prefix}-bastion_server" })

  )

}

