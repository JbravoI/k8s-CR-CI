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
# appservice   #
################
variable "app_service_name" { 
  description = "app service Name"
  default     = "temp-appservice-name"
}
variable "app_service_plan_id" { 
  description = "app_service_plan_id"
}
