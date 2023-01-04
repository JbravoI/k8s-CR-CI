#General Variables 
variable "rg_name" {
  description = "Name of the resource group to be imported."
  default     = "temp-rg"
}
variable "tags" {
  description = "The tags to associate with your resource(s)"
  type        = map(string)
  default = {
    environment = "temp"
  }
}

###################

variable "vnet_name" { 
  description = "Container instance Name"
  default     = "vnet-name"
}
variable "k8s_subnet_name" { 
  description = "Can be set Public or Private"
}
variable "ci_subnet_name" { 
  description = "Can be set Public or Private"
}
variable "vnet_address_space" {
    description = "Address space for VNET"
    type = list(string)
    # default     = "[10.0.0.0/24]"
}