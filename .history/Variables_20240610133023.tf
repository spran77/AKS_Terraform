variable "keyvault-name" {
  type = string
}

variable "rgname" {
  type        = string
  description = "resouce group name"

}

variable "location" {
  type        = string
  default     = "canadacentral"
  description = "Location of resource"
}

variable "service_principal_name" {
  type = string


}
