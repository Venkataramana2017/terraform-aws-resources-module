# Terraform Module Name: tcbuk-global-terraform-module-network
## General
Every module created providing all the information about the module updated ,
 will follow repos naming standerds so that it will be easy to understand any of the business requirement  .
This module  used to create resources in AWS cloud provider which are related to networking features.

---

## Features

Below  are able to check the resources that are being created as part of this module call:

- VPC
- One Public Subnet per AZ
- One Private DMZ Subnet per AZ
- One Private Subnet per AZ
- An Internet Gateway
- One NAT Gateway per AZ
- Public, Web and Private Routing Tables
- DB Subnet Groups
- Network ACL

---

## Usage

The variables that required in order for the module to be successfully called  following:

| Variable | Description | Type |
|------|---------|----|
| vpc_cidr | IP range of Core VPC | map |
| tcb_local_network | IP range of TCB internal network | string |
| environment | TCB environment | string |
| subnets | Subnet list with IP ranges | map |
| subnet_names | Subnet list with the names of the subnets | map |
| availability_zones | Availability zones that are going to be used for the subnets  | list |
| vpc_name | VPC name related to the environment and the source market | string |
| vpc_flowlogs_log_group_name | VPC flowlogs log group name | string |
| route_table_public_name | Public DMZ routing table name | string |
| route_table_privdmz_names | Private DMZ routing table name | list |
| route_table_private_name | Private routing table name | string |
| source_market_name | Source market name | string |
| nacl_name | Network ACL name | string |
| igw_name | Internet gateway name | string |
| nat_gw_names | NAT gateway names | list |
| vpc_flow_log_role_arn | VPC flow log role ARN | string |
| atcomcache_atcdb_db_subnet_group_name | Atcomcache Mariadb subnet group name | string |

## Outputs

### General
Below are the variables that Networking Module exposes in order to be used by other layers :

| Variable | Description | Type |
|------|-------|------|
| vpc_id | VPC ID | string |
| pubdmz0_subnet_id | Public Subnet ID - 1a | string |
| pubdmz1_subnet_id | Public Subnet ID - 1b | string |
| privdmz0_subnet_id | Private DMZ Subnet ID - 1a | string |
| privdmz1_subnet_id | Private DMZ Subnet ID - 1b | string |
| private0_subnet_id | Private Subnet ID - 1a | string |
| private1_subnet_id | Private Subnet ID - 1b | string |

### Usage
In order for the variables to be accessed on module level please use the syntax below:
```bash
module.<module_name>.<output_variable_name>
```

If an output variable needs to be exposed on root level in order to be accessed through terraform state file follow the steps below:

- Include the syntax above in the network layer output terraform file.
- Add the code snippet below to the variables/global_variables file.
```bash
data "terraform_remote_state" "<module_name>" {
  backend = "s3"

  config {
    bucket = <bucket_name> (i.e. "tcbuk-s3-terraform-statete")
    key    = <state_file_relative_path> (i.e. "env:/${terraform.workspace}/4_Networking/terraform.tfstate")
    region = <bucket_region> (i.e. "eu-west-1")
  }
}
```
- The output variable is able to be accessed through terraform state file using the syntax below:
```bash
"${data.terraform_remote_state.<module_name>.<output_variable_name>}"
```



