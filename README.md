# IBM Cloud Pak for Integration - DataPower module

Module to populate a gitops repository with the DataPower operator from IBM Cloud Pak for Integration.

## Software dependencies

The module depends on the following software components:

### Command-line tools

- terraform - v15
- kubectl
 
### Terraform providers

- IBM Cloud provider >= 1.5.3
- Helm provider >= 1.1.1 (provided by Terraform)

## Module dependencies

This module makes use of the output from other modules:

- GitOps - github.com/cloud-native-toolkit/terraform-tools-gitops.git
- Namespace - github.com/cloud-native-toolkit/terraform-gitops-namespace.git
- Catalogs - github.com/cloud-native-toolkit/terraform-gitops-cp-catalogs.git

## Example usage

```hcl-terraform
module "datapower-operator" {
   source = "./module"

   gitops_config = module.gitops.gitops_config
   git_credentials = module.gitops.git_credentials
   server_name = module.gitops.server_name
   namespace = module.gitops_namespace.name
   catalog = module.cp_catalogs.catalog_ibmoperators
   kubeseal_cert = module.gitops.sealed_secrets_cert
   entitlement_key = module.cp_catalogs.entitlement_key

   # Pulling variables from CP4I dependency management
   channel  = module.cp4i-dependencies.datapower.channel  
}
```