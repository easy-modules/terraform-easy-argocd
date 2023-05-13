resource "helm_release" "argo_cd_install" {
  name             = format("argo-cd-%s", var.stage)
  repository       = var.argo_repository
  version          = var.argo_version
  chart            = var.argo_chart
  namespace        = var.namespace
  create_namespace = true
  wait             = true
  cleanup_on_fail  = true

  dynamic "set" {
    for_each = try(var.values, {})
    content {
      name  = set.value.name
      value = set.value.value
    }
  }
}

resource "kubectl_manifest" "argo_cd_project" {
  for_each = try({ for k, v in var.project : k => v if v != null }, {})

  yaml_body = templatefile("${path.module}/templates/project/project.yaml.tpl", {
    PROJECT_NAME        = try(each.value.project_name, "default")
    ARGO_NAMESPACE      = var.namespace
    PROJECT_DESCRIPTION = each.value.project_description
  })

  depends_on = [
    helm_release.argo_cd_install
  ]
}

resource "kubectl_manifest" "argo_cd_private_repo" {
  for_each = try({ for k, v in var.private_repo : k => v if v != null }, {})

  yaml_body = templatefile("${path.module}/templates/repositories/Private-repository.yaml.tpl", {
    APP_NAME         = each.value.app_name
    ARGO_NAMESPACE   = var.namespace
    PRIVATE_REPO_URL = each.value.private_repo_url
    SSH_PRIVATE_KEY  = filebase64(each.value.ssh_private_key)
  })

  depends_on = [
    helm_release.argo_cd_install
  ]
}

resource "kubectl_manifest" "argo_cd_public_repo" {
  for_each = try({ for k, v in var.public_repo : k => v if v != null }, {})

  yaml_body = templatefile("${path.module}/templates/repositories/Public-repository.yaml.tpl", {
    APP_NAME        = each.value.app_name
    ARGO_NAMESPACE  = var.namespace
    PUBLIC_REPO_URL = each.value.public_repo_url
  })
  depends_on = [
    helm_release.argo_cd_install
  ]
}

resource "kubectl_manifest" "argo_cd_application" {
  for_each = try({ for k, v in var.applications : k => v if v != null }, {})

  yaml_body = templatefile("${path.module}/templates/applications/Application.yaml.tpl", {
    APP_NAME              = each.value.app_name
    ARGO_NAMESPACE        = var.namespace
    APP_NAMESPACE         = each.value.app_namespace
    APP_PATH              = each.value.app_path
    APP_REPO_URL          = each.value.app_repo_url
    APP_TARGET_REVISION   = each.value.app_target_revision
    APP_DIRECTORY_RECURSE = each.value.app_directory_recurse
    APP_PROJECT           = try(each.value.app_project, "default")


  })
  depends_on = [
    helm_release.argo_cd_install
  ]
}

resource "kubectl_manifest" "argo_cd_notification" {
  for_each = try({ for k, v in var.notification : k => v if v != null }, {})

  yaml_body = templatefile("${path.module}/templates/notifications/application-notification.yaml.tpl", {
    ARGO_NAMESPACE      = var.namespace
    OAUTH_SLACK_TOKEN   = each.value.oauth_slack_token
    SLACK_CHANNELS_LIST = each.value.slack_channels_list
  })

  depends_on = [
    helm_release.argo_cd_install
  ]
  sensitive_fields = [
    "data.oauth-slack-token"
  ]
}
