variable vpc_cidr{
    type = string
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

variable access_ip {
    type = string
    default = "0.0.0.0/0"
}