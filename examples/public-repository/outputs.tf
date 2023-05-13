output "helm_release_name" {
  description = "The name of the Helm release"
  value       = module.argo_cd.helm_release_name
}

output "argo_cd_project_id" {
  description = "The ID of the Argo CD project"
  value       = module.argo_cd.argo_cd_project_id
}

output "argo_cd_private_repo_id" {
  description = "The ID of the Argo CD private repository"
  value       = module.argo_cd.argo_cd_private_repo_id
}

output "argo_cd_application_name" {
  description = "The name of the Argo CD application"
  value       = module.argo_cd.argo_cd_application_name
}
