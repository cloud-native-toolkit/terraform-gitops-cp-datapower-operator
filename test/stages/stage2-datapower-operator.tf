module "gitops_module" {
  source = "./module"
  gitops_config = module.gitops.gitops_config
  git_credentials = module.gitops.git_credentials
  server_name = module.gitops.server_name
  
  # Pulling variables from CP4I dependency management
  channel  = module.cp4i-dependencies.datapower.channel


}
