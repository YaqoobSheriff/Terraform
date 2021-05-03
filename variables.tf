variable "loc" {
    description = "Default Azure region"
    default     =   "South India"
}

variable "tags" {
    default     = {
        source  = "azure"
        env     = "networking"
    }
}