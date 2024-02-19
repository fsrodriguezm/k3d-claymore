provider "random" {}

resource "random_integer" "port" {
  min = 8000
  max = 8099
}

locals {
  host_lb_port = (var.k3d_host_lb_port != "" ? var.k3d_host_lb_port : random_integer.port.result)
}

resource "null_resource" "cluster" {
  for_each = toset(var.k3d_cluster_name)
  triggers = {
    agent_count   = var.agent_count
    server_count  = var.server_count
    ip            = var.k3d_cluster_ip
    port          = var.k3d_cluster_port
    k3s_version   = var.k3s_version
  }
  provisioner "local-exec" {
    command = "k3d cluster create ${each.key} --agents ${var.agent_count} --servers ${var.server_count} -p '8901:30081@agent:0' -p '8902:30082@agent:0'"
  }
}

resource "null_resource" "cluster_config" {
  for_each = toset(var.k3d_cluster_name)
  provisioner "local-exec" {
    command = "k3d kubeconfig get ${each.key} > ../.kube/${each.key}-config"
  }
  depends_on = [
    null_resource.cluster
  ]
}

resource "null_resource" "cluster_delete" {
  for_each = toset(var.k3d_cluster_name)
  provisioner "local-exec" {
    command = "k3d cluster delete ${each.key} && rm -rf terraform.tfstate && rm -rf ../.kube/*"
    when    = destroy
  }
}