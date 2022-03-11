module "datapower-operator" {
  source = "./module"

  gitops_config = module.gitops.gitops_config
  git_credentials = module.gitops.git_credentials
  server_name = module.gitops.server_name
  namespace = module.gitops_namespace.name
  catalog = module.cp_catalogs.catalog_ibmoperators
  entitlement_key = module.cp_catalogs.entitlement_key
  kubeseal_cert = module.gitops.sealed_secrets_cert
}
