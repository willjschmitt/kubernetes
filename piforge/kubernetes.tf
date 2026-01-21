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

resource "kubernetes_namespace" "unifi" {
  metadata {
    name = "unifi"
  }
}

resource "helm_release" "unifi" {
  name       = "unifi"

  repository = "oci://ghcr.io/mkilchhofer/unifi-chart"
  chart      = "unifi"
  version    = "1.16.0"

  namespace = kubernetes_namespace.unifi.metadata[0].name

  values = [
    file("k8s-apps/unifi/unifi.values.yaml")
  ]
}

# resource "kubernetes_manifest" "wake-on-lan-proxy" {
#   manifest = yamldecode(file("k8s-apps/home-assistant/wake-on-lan-proxy.yaml"))
# }
#
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
