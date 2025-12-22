resource "tailscale_acl" "k8s-operator-acl" {
  acl = <<EOF
  {
    "tagOwners": {
      "tag:k8s-operator": [],
      "tag:k8s": ["tag:k8s-operator"],
    }
  }
  EOF
}

resource "tailscale_oauth_client" "kubernetes-operator-client" {
  description = "Kuberenets Operator Tailscale Client"
  scopes      = ["devices:core", "auth_keys"]
  tags        = ["tag:k8s-operator"]

  depends_on = [tailscale_acl.k8s-operator-acl]
}
