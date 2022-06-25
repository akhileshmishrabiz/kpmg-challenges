
####  Subnet group used by rds ##########

resource "aws_db_subnet_group" "main" {
  name       = "${local.prefix}-main"
  subnet_ids = [aws_subnet.private-a.id, aws_subnet.private-b.id]

  tags = merge(
    local.common_tags,
    tomap({
      "Name" = "${local.prefix}-main"

    })
  )
}


# Security group to be used by RDS database
resource "aws_security_group" "rds" {

  description = "allow access to rds database"
  name        = "${local.prefix}-rds_bound_access"
  vpc_id      = aws_vpc.main.id

  ingress {
    protocol  = "tcp"
    from_port = 3306
    to_port   = 3306
    #5432 is a default port for postgres db
  }
  tags = local.common_tags

}
##################
#rds 
##########
resource "aws_db_instance" "main" {
  identifier              = "${local.prefix}-db"
  db_name                 = "kpmg"
  allocated_storage       = 20
  storage_type            = "gp2"
  engine                  = "mysql"
  instance_class          = "db.t2.micro"
  db_subnet_group_name    = aws_db_subnet_group.main.name
  password                = var.mydb_password
  username                = var.mydb_username
  backup_retention_period = 0
  multi_az                = false
  skip_final_snapshot     = true
  vpc_security_group_ids  = [aws_security_group.rds.id]
  

  tags = merge(
    local.common_tags,
    tomap({
      "Name" = "${local.prefix}-main"
    })
  )

}