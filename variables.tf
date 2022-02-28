variable "tags" {
  type = any
}

variable "env" {
  type = string
}

variable "serverType" {
  type = string
}

variable "userDefinedString" {
  type = string
}

variable "postfix" {
  type = string
  description = "(optional) describe your variable"
}

variable "metadata" {
  type = any
  default = {}
}

variable "machine_type" {
  type = string
}

variable "zone" {
  type = any

}

variable "allow_stopping_for_update" {
  type = bool
  default = true
}

variable "initialize_params" {
  type = any
}

variable "network_interface" {
  type = any
}

variable "metadata_startup_script" {
  type = string
}

variable "service_account" {
  type = any
}