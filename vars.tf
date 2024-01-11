variable "project_id" {
  type = string
  description = "The Google Project ID"
}

variable "wilf_id" {
    type = string
    description = "Wrokload Identity PoolId"
  
}

variable "wilf_provider_id" {
    type = string
    description = "Wrokload Identity Pool Provider Id"
  
}
variable "repo" {
  type = list(string)
  description = "The GitHub repo in the format username/repo_name"
}

variable "sa_account" {
    type = list(string)
    description = "Service account for wilf binding"
  
}
