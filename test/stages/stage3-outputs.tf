resource null_resource write_outputs {
  provisioner "local-exec" {
    command = "echo \"$${OUTPUT}\" > gitops-output.json"

    environment = {
      OUTPUT = jsonencode({
        subscription_namespace = module.datapower-operator.subscription_namespace
      })
    }
  }
}
