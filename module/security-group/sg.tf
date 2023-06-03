resource "aws_security_group" "tcbuk_sg" {
provider =  aws.tcbuk
  name = "tcbuk-${lower(terraform.workspace)}-tcbuk-sg"
  description = "Security Group for tcbuk EC2 Instance "
  vpc_id = data.terraform_remote_state.network_layer.outputs.vpc_id
 ingress = [
    {
      description      = "TLS from VPC"
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      cidr_blocks      = [aws_vpc.core_vpc.cidr_block]
          }
  ]

  egress = [
    {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
     
    }
  ]

  tags ={
    Name= "tcbuk-${lower(terraform.workspace)}-tcbuk-sg"
    Environment= lower(terraform.workspace)
     }
}

