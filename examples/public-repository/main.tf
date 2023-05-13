module "argo_cd" {
  source          = "../../"
  stage           = var.stage
  namespace       = var.namespace
  argo_version    = var.argo_version
  argo_chart      = var.argo_chart
  argo_repository = var.argo_repository
  values          = var.values

  project      = var.project
  public_repo  = var.public_repo
  applications = var.applications

  # Optional {}
  notification = try(var.notification, {})
  private_repo = try(var.private_repo, {})
}
