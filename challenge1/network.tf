
resource "aws_vpc" "main" {
  cidr_block           = "10.1.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(
    local.common_tags,
    tomap({ "Name" = "${local.prefix}-vpc" })
  )
}

# Internet gateway to enable trafic from internet
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    local.common_tags,
    tomap({ "Name" = "${local.prefix}-main" })
  )
}

##############################################################################
#Public subnet -> inbund/outbound access for internet
##########################################
resource "aws_subnet" "public-a" {
  cidr_block              = "10.1.1.0/24"
  map_public_ip_on_launch = true
  vpc_id                  = aws_vpc.main.id
  availability_zone       = "${data.aws_region.current.name}a"

  tags = merge(
    local.common_tags,
    tomap({ "Name" = "${local.prefix}-public-a" })
  )
}

resource "aws_route_table" "public-a" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    local.common_tags,
    tomap({ "Name" = "${local.prefix}-public-a" })
  )
}

resource "aws_route_table_association" "public-a" {
  subnet_id      = aws_subnet.public-a.id
  route_table_id = aws_route_table.public-a.id
}

resource "aws_route" "public_access-a" {
  route_table_id         = aws_route_table.public-a.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id
}

resource "aws_eip" "public-a" {
  vpc = true
  tags = merge(
    local.common_tags,
    tomap({ "Name" = "${local.prefix}-public-a" })
  )
}

## Creating Nat gateway for resources in private subnet to use
resource "aws_nat_gateway" "public-a" {
  allocation_id = aws_eip.public-a.id
  subnet_id     = aws_subnet.public-a.id

  tags = merge(
    local.common_tags,
    tomap({ "Name" = "${local.prefix}-public-a" })
  )

}

###################################################################################################
#             Public subnet for AZ b -inbund/outbound access for internet                        #
###################################################################################################


resource "aws_subnet" "public-b" {
  cidr_block              = "10.1.2.0/24"
  availability_zone       = "${data.aws_region.current.name}b"
  map_public_ip_on_launch = true
  vpc_id                  = aws_vpc.main.id
  tags = merge(
    local.common_tags,
    tomap({ "Name" = "${local.prefix}-public-b" })
  )
}

resource "aws_route_table" "public-b" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    local.common_tags,
    tomap({ "Name" = "${local.prefix}-public-b" })
  )
}

resource "aws_route_table_association" "public-b" {
  subnet_id      = aws_subnet.public-b.id
  route_table_id = aws_route_table.public-b.id

}

resource "aws_route" "public_internet_access-b" {
  route_table_id         = aws_route_table.public-b.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id

}

resource "aws_eip" "public-b" {
  vpc = true
  tags = merge(
    local.common_tags,
    tomap({ "Name" = "${local.prefix}-public-b" })
  )
}

resource "aws_nat_gateway" "public-b" {
  allocation_id = aws_eip.public-b.id
  subnet_id     = aws_subnet.public-b.id
  tags = merge(
    local.common_tags,
    tomap({ "Name" = "${local.prefix}-public-b" })
  )
}

#########################################################
###  private subnet - internet outbound only  ##
#########################################################

#Createing a private subnet in AZ a
resource "aws_subnet" "private-a" {
  cidr_block        = "10.1.10.0/24"
  vpc_id            = aws_vpc.main.id
  availability_zone = "${data.aws_region.current.name}a"

  tags = merge(
    local.common_tags,
    tomap({ "Name" = "${local.prefix}-private-a" })
  )
}

#routing table for private subnet in AZ a
resource "aws_route_table" "private-a" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    local.common_tags,
    tomap({
      "Name" = "${local.prefix}-private-a"

    })
  )
}

# Routing table association with private subnet in AZ a
resource "aws_route_table_association" "private-a" {
  subnet_id      = aws_subnet.private-a.id
  route_table_id = aws_route_table.private-a.id

}

#Associating private subnet for AZ a with Nat gateway using routing table
resource "aws_route" "private-a_internet_out" {
  route_table_id         = aws_route_table.private-a.id
  nat_gateway_id         = aws_nat_gateway.public-a.id
  destination_cidr_block = "0.0.0.0/0"
}


###################  AZ b  #################################

#Createing a private subnet in AZ b
resource "aws_subnet" "private-b" {
  cidr_block        = "10.1.11.0/24"
  vpc_id            = aws_vpc.main.id
  availability_zone = "${data.aws_region.current.name}b"

  tags = merge(
    local.common_tags,
    tomap({
      "Name" = "${local.prefix}-private-b"

    })
  )
}

#routing table for private subnet in AZ b
resource "aws_route_table" "private-b" {
  vpc_id = aws_vpc.main.id
  tags = merge(
    local.common_tags,
    tomap({
      "Name" = "${local.prefix}-private-b"

    })
  )
}

# Routing table association with private subnet in AZ b
resource "aws_route_table_association" "private-b" {
  subnet_id      = aws_subnet.private-b.id
  route_table_id = aws_route_table.private-b.id
}



#Associating private subnet for AZ b with Nat gateway using routing table
resource "aws_route" "private-b-internet_out" {
  route_table_id         = aws_route_table.private-b.id
  nat_gateway_id         = aws_nat_gateway.public-b.id
  destination_cidr_block = "0.0.0.0/0"
}



