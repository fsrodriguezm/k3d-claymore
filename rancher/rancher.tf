provider "helm" {
  kubernetes  {
    config_path    = "../.kube/claymore-config"
    config_context = "k3d-claymore"
  }
}

provider "kubernetes" {
  config_path    = "../.kube/claymore-config"
  config_context = "k3d-claymore"
}

resource "kubernetes_namespace" "cattle_system" {
  metadata {
    name = "cattle-system"
  }
}

# https://github.com/rancher/rancher/tree/release/v2.9/chart
resource "helm_release" "rancher" {
  chart      = "rancher"
  name       = "rancher"
  namespace  = "cattle-system"
  repository = "https://releases.rancher.com/server-charts/latest"

  set {
    name  = "ingress.enabled"
    value = false
  }

  set {
    name  = "replicas"
    value = 1
  }

  set {
    name  = "tls"
    value = "external"
  }
  depends_on = [ kubernetes_namespace.cattle_system ]
}

resource "kubernetes_service" "rancher_nodeport" {
  metadata {
    name = "rancher-nodeport"
    namespace = "cattle-system"
    labels = {
      "app" = "rancher"
    }
  }
  spec {
    selector = {
      "app" = "rancher"
    }
    port {
      name        = "http"
      node_port   = 30080
      port        = 80
      protocol    = "TCP"
      target_port = 80
    }
    port {
      name        = "https-internal"
      node_port   = 30081
      port        = 443
      protocol    = "TCP"
      target_port = 443
    }
    type = "NodePort"
  }
  depends_on = [ helm_release.rancher ]
}