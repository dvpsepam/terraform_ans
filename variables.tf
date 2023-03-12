variable "vpc_cidr" {
  type    = string
  default = "10.102.0.0/16"
}

# variable public_cidrs{
#     type = list(string)
#     default = ["10.102.1.0/24","10.102.3.0/24"]
# }

# variable private_cidrs{
#     type = list(string)
#     default = ["10.102.2.0/24","10.102.4.0/24"]
# }

variable "access_ip" {
  type    = string
  default = "0.0.0.0/0"
}

variable "main_instance_type" {
  type    = string
  default = "t2.micro"
}

variable "cloud9_ip" {
  type    = string
  default = "3.71.146.238/32"
}
variable "main_vol_size" {
  type    = number
  default = 10
}

variable "main_instance_count" {
  type    = number
  default = 1
}

variable "key_name" {
  type = string
}

variable "public_key_path" {
  type = string
}