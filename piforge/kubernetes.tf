resource "kubernetes_namespace" "home-assistant" {
  metadata {
    name = "home-assistant"
  }
}

resource "helm_release" "home-assistant" {
  name       = "home-assistant"

  repository = "http://pajikos.github.io/home-assistant-helm-chart"
  chart      = "home-assistant"
  version    = "0.3.24"

  namespace = "home-assistant"

  values = [
    file("k8s-apps/home-assistant/home-assistant.values.yaml")
  ]

  depends_on = [
    kubernetes_namespace.home-assistant,
  ]
}
