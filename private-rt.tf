# 프라이빗 라우트 테이블 생성
resource "aws_route_table" "private-route-table" {
  # 라우트 테이블이 속할 VPC의 ID. aws_vpc 리소스에서 생성된 VPC를 참조.
  vpc_id = aws_vpc.vpc.id

  # 기본 라우트 설정. 모든 트래픽을 NAT 게이트웨이로 라우팅.
  route {
    cidr_block = "0.0.0.0/0"  # 모든 IP 주소에 대한 트래픽
    gateway_id = aws_nat_gateway.nat-gw.id  # NAT 게이트웨이를 통해 라우팅
  }

  # 라우트 테이블의 태그. AWS 콘솔에서 식별을 쉽게 하기 위해 Name 태그 설정.
  tags = {
    Name = "ce04-terraform-private-rt"  
  }
}

resource "aws_route_table_association" "pri-rt-association-1" {
  # 연결할 서브넷의 ID. aws_subnet 리소스에서 생성된 서브넷을 참조.
  subnet_id      = aws_subnet.app-subnet1.id
  
  # 연결할 라우트 테이블의 ID. aws_route_table 리소스에서 생성된 라우트 테이블을 참조.
  route_table_id = aws_route_table.private-route-table.id
}

resource "aws_route_table_association" "pri-rt-association-2" {
  subnet_id      = aws_subnet.app-subnet2.id
  route_table_id = aws_route_table.private-route-table.id
}
