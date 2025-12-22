output "tailscale-kubernetes-oauth-client-id" {
  value       = tailscale_oauth_client.kubernetes-operator-client.id
  description = "The OAuth Client ID for the Tailscale Kubernetes Operator."
}

output "tailscale-kubernetes-oauth-client-key" {
  value       = tailscale_oauth_client.kubernetes-operator-client.key
  description = "The OAuth Client Key for the Tailscale Kubernetes Operator."

  sensitive   = true
}
