locals {
  name     = "ibm-datapower-operator"
  yaml_dir      = "${path.cwd}/.tmp/${local.name}/chart/${local.name}"

  values_content = {
    subscriptions = {
      ibmdatapower = {
        name         = "datapower-operator"
        subscription = {
          channel             = var.channel
          installPlanApproval = "Automatic"
          name                = "datapower-operator"
          source              = var.catalog
          sourceNamespace     = var.catalog_namespace
        }
      }
    }
  }

  layer = "services"
  type  = "operators"
  application_branch = "main"
  layer_config = var.gitops_config[local.layer]
  
  values_file = "values.yaml"
}


resource null_resource create_yaml {
  provisioner "local-exec" {
    command = "${path.module}/scripts/create-yaml.sh '${local.name}' '${local.yaml_dir}' '${local.values_file}'"

    environment = {
      VALUES_CONTENT = yamlencode(local.values_content)
    }
  }
}

resource gitops_module setup_gitops {
  depends_on = [null_resource.create_yaml]

  name = local.name
  namespace = var.namespace
  content_dir = local.yaml_dir
  server_name = var.server_name
  layer = local.layer
  type = local.type
  branch = local.application_branch
  config = yamlencode(var.gitops_config)
  credentials = yamlencode(var.git_credentials)
}