output "helm_release_namespace" {
  description = "The namespace in which the release is installed"
  value       = helm_release.argo_cd_install.namespace
}

output "helm_release_name" {
  description = "The name of the release"
  value       = helm_release.argo_cd_install.name
}

output "helm_release_namespace_id" {
  description = "The namespace in which the release is installed"
  value       = helm_release.argo_cd_install.id
}

output "argo_cd_application_name" {
  description = "The name of the application"
  value       = [for app in kubectl_manifest.argo_cd_application : app.name]
}

output "argo_cd_application_namespace" {
  description = "The namespace in which the application is installed"
  value       = [for app in kubectl_manifest.argo_cd_application : app.namespace]
}

output "argo_cd_notification_id" {
  description = "The id of the notification"
  value       = [for not in kubectl_manifest.argo_cd_notification : not.id]
}

output "argo_cd_notification_name" {
  description = "The name of the notification"
  value       = [for not in kubectl_manifest.argo_cd_notification : not.name]
}

output "argo_cd_private_repo_id" {
  description = "The id of the private repo"
  value       = [for repo in kubectl_manifest.argo_cd_private_repo : repo.id]
}

output "argo_cd_private_repo_name" {
  description = "The name of the private repo"
  value       = [for repo in kubectl_manifest.argo_cd_private_repo : repo.name]
}

output "argo_cd_project_id" {
  description = "The id of the project"
  value       = [for proj in kubectl_manifest.argo_cd_project : proj.id]
}

output "argo_cd_project_name" {
  description = "The name of the project"
  value       = [for proj in kubectl_manifest.argo_cd_project : proj.name]
}

output "argo_cd_public_repo_id" {
  description = "The id of the public repo"
  value       = [for pub in kubectl_manifest.argo_cd_public_repo : pub.id]
}

output "argo_cd_public_repo_name" {
  description = "The name of the public repo"
  value       = [for pub in kubectl_manifest.argo_cd_public_repo : pub.name]
}
