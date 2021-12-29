# Create a Workload Identity Pool and Workload Identity Provider in that pool
module "workload_identity_pool" {
  source       = "./modules/gcp-wilf"
  project_id   =  var.project_id
  wilf_id      = var.wilf_id
  wilf_provider_id = var.wilf_provider_id
}

# SA: Workload indtity pool binding for Service account
module "workload_idetify-sa-binding" {
  source       = "./modules/wlif-sa-binding"
  project_id   =  var.project_id
  gh_repo      = var.repo
  sa_id        = var.sa_account
  poolid       = var.wilf_id
  depends_on   = [module.workload_identity_pool]
}
