variable "location" {
    type = string
    default = "francecentral"
}

variable "resource_group_name" {
    type = string
    default = "rg-imdb-movies"  
}

variable "image_tag" {
    type = string
    default = "v1"
}

variable "registryname" {
    type = string
    default = "moviesRegistry"
}
