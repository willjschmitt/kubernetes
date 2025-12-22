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

// ============================================================================
// Tailscale Operator
// ============================================================================

resource "kubernetes_namespace" "tailscale" {
  metadata {
    name = "tailscale"
  }
}

data "sops_file" "tailscale-oauth-secret" {
  source_file = "tailscale-operator.secrets.enc.yaml"
  input_type  = "yaml"
}

resource "helm_release" "tailscale" {
  name       = "tailscale-operator"

  repository = "https://pkgs.tailscale.com/helmcharts"
  chart      = "tailscale-operator"
  version    = "1.86.5"

  namespace = kubernetes_namespace.tailscale.metadata[0].name

  values = [
    data.sops_file.tailscale-oauth-secret.raw,
  ]
}
