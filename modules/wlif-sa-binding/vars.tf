variable "project_id" {
  type = string
  description = "The Google Project ID"
}

variable "gh_repo" {
  type = list(string)
  description = "The GitHub repo in the format username/repo_name"
}

variable "sa_id" {
    type = list(string)
    description = "Service account for wilf binding"
  
}

variable "poolid" {
   type = string
   description = "Pool Id"

}