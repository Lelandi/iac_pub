variable "app_name" {
  default = "vmazure2"
  type    = string
}

variable "azure_region" {
  type        = string
  description = "A região da Azure onde a infraestrutura será criada."
  default     = "brazilsouth"
}

variable "environment" {
  default = "prod"
  type    = string
}

variable "tags_list" {
  type        = map(string)
  description = "Mapa de tags e seus valores a serem aplicados aos recursos."
  default = {
    projeto  = "lelandi-vmapp"
    ambiente = "prod"
  }
}

variable "resource_group" {
  default = "rg-vmapp"
  type    = string
}

variable "virtual_machine_size" {
  type        = string
  default     = "Standard_B2s"
  description = "Size or SKU of the Virtual Machine."
}

variable "disk_name" {
  type        = string
  default     = "disk"
  description = "Name of the OS disk of the Virtual Machine."
}

variable "redundancy_type" {
  type        = string
  default     = "Standard_LRS"
  description = "Storage redundancy type of the OS disk."
}