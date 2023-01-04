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


######################
# Container Instance #
######################
variable "Container_instance_name" { 
  description = "Container instance Name"
  default     = "temp-Container-instance-name"
}
variable "ip_address_type" { 
  description = "Can be set Public or Private"
}
variable "dns_name_label" { 
  description = "DNS Name"
  default     = "aci-label"
}
variable "subnet_id" { 
  description = "OS type"
}
variable "os_type" { 
  description = "OS type"
}
variable "container_name" { 
  description = "container name"
}
variable "container_image" { 
  description = "image"
}
variable "container_cpu" { 
  description = "cpu"
}
variable "container_memory" { 
  description = "memory"
}
variable "container_port" {
  # type = list(string)
  description = "network ports"
}
variable "container_protocol" { 
  description = "network protocol"
}