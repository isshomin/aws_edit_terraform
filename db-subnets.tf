# 첫 번째 DB 서브넷의 CIDR 블록 변수 선언
variable "db-subnet1-cidr" {
  description = "첫 번째 DB 서브넷의 CIDR 블록"
  type        = string
  default     = "10.0.3.0/24" # 기본 CIDR 블록
}

# 두 번째 DB 서브넷의 CIDR 블록 변수 선언
variable "db-subnet2-cidr" {
  description = "두 번째 DB 서브넷의 CIDR 블록"
  type        = string
  default     = "10.0.4.0/24" # 기본 CIDR 블록
}

# 첫 번째 DB 서브넷의 이름 변수
variable "db-subnet1-name" {
  description = "첫 번째 DB 서브넷의 이름"
  type        = string
  default     = "ce00-terraform-db-subnet1"
}

# 두 번째 DB 서브넷의 이름 변수
variable "db-subnet2-name" {
  description = "두 번째 DB 서브넷의 이름"
  type        = string
  default     = "ce00-terraform-db-subnet2"
}

# 가용 영역(Availability Zone) 변수
variable "az-1" {
  description = "첫 번째 가용 영역"
  default     = "ap-northeast-2a"
}

variable "az-2" {
  description = "두 번째 가용 영역"
  default     = "ap-northeast-2b"
}



# 첫 번째 DB 서브넷 (db-subnet1) 생성
resource "aws_subnet" "db-subnet1" {
  # 이 서브넷이 속할 VPC의 ID. aws_vpc 리소스에서 생성된 VPC를 참조.
  vpc_id = aws_vpc.vpc.id
  
  # 서브넷의 CIDR 블록. var.db-subnet1-cidr 변수를 사용해 IP 범위 설정.
  cidr_block = var.db-subnet1-cidr
  
  availability_zone = "ap-northeast-2a"
  
  # 인스턴스가 이 서브넷에 생성될 때 퍼블릭 IP 할당 여부. false로 설정.
  map_public_ip_on_launch = false

  # 서브넷의 태그. AWS 콘솔에서 식별을 쉽게 하기 위해 Name 태그 설정.
  tags = {
    Name = "ce00-terraform-db-subnet1"
  }
}

# 두 번째 DB 서브넷 (db-subnet2) 생성
resource "aws_subnet" "db-subnet2" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.db-subnet2-cidr
  availability_zone = "ap-northeast-2b"
  map_public_ip_on_launch = true

  tags = {
    Name = "ce00-terraform-db-subnet2"
  }
}
