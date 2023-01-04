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


################
# appserviceplan #
################
variable "app_serviceplan_name" { 
  description = "app serviceplan Name"
  default     = "temp-appserviceplan-name"
}
variable "os_type" { 
  description = "OS type"
}
variable "sku_name" { 
  description = "sku name"
}
variable "sku_tier" { 
  description = "sku tier"
}
variable "sku_size" { 
  description = "sku size"
}

