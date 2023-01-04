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
# kubernetes #
################
variable "kubernetes_name" { 
  description = "kubernetes Name"
  default     = "temp-kubernetes-name"
}
variable "kubernetes_default_node_pool_name" { 
  description = "kubernetes node pool Name"
}
variable "kubernetes_version" {
  description = "the version of kubernetes needed"
}
variable "dns_prefix" { 
  description = " Name for dns_prefix"
  default     = "custom-dns-prefix-name"
}
variable "subnet_id" { 
  description = "subnet id gotten from vnet"
}
variable "subnet_name" { 
  description = "subnet name gotten from vnet"
}
variable "load_balancer_sku" { 
  description = "Can be set to Basic or Standard"
}
variable "outbound_type" { 
  description = "Can be set loadBalancer or UserDefined"
}
variable "enable_auto_scaling" { 
  description = "Can be set true or false"
}
variable "max_count" { 
  description = "Can be set between 1 and 1000"
}
variable "min_count" { 
  description = "Can be set between 1 and 1000"
}
variable "vm_size" { 
  description = "the size of kubernetes nodes"
}
variable "identity_type" { 
  description = "Can be set to SystemAssigned or UserDefined"
}