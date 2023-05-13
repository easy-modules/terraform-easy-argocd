 # Terraform easy modules
 
Terraform module to deploy ArgoCD

## Usage

```hcl
module "argo_cd" {
  source = "easy-modules/argocd/easy"

  namespace = "argocd-system"
  stage     = "dev"

  argo_chart      = "argo-cd"
  argo_repository = "https://argoproj.github.io/argo-helm"
  argo_version    = "5.27.1"

  values = [
    {
      name  = "configs.cm.timeout.reconciliation"
      value = "40s"
    },
    {
      name  = "configs.cm.params.applicationsetcontroller.enable.progressive.syncs"
      value = true
    },
    {
      name  = "crds.install"
      value = true
    },
  ]

  project = {
    easy_modules = {
      project_description = "Easy Modules project"
      project_name        = "easy"
    }
  }
  
  public_repo = {
    easy_modules = {
      app_name        = "prometheus"
      public_repo_url = "https://github.com/prometheus-community/helm-charts"
    }
  }

  applications = {
    easy_modules = {
      app_name              = "kube-state-metrics"
      app_namespace         = "kube-state-metrics"
      app_path              = "charts/kube-state-metrics"
      app_repo_url          = "https://github.com/prometheus-community/helm-charts"
      app_target_revision   = "HEAD"
      app_directory_recurse = false
      app_project           = "easy"
    }
    alert-manager = {
      app_name              = "alert-manager"
      app_namespace         = "alert-manager"
      app_path              = "charts/alertmanager"
      app_repo_url          = "https://github.com/prometheus-community/helm-charts"
      app_target_revision   = "HEAD"
      app_directory_recurse = false
      app_project           = "easy"
    },
  }
}
```
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 4.0.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | 2.9.0 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | >= 1.7.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.9.0 |
| <a name="provider_kubectl"></a> [kubectl](#provider\_kubectl) | >= 1.7.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.argo_cd_install](https://registry.terraform.io/providers/hashicorp/helm/2.9.0/docs/resources/release) | resource |
| [kubectl_manifest.argo_cd_application](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.argo_cd_notification](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.argo_cd_private_repo](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.argo_cd_project](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.argo_cd_public_repo](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_applications"></a> [applications](#input\_applications) | Application Setup | `any` | <pre>{<br>  "alert-manager": {<br>    "app_directory_recurse": false,<br>    "app_name": "alert-manager",<br>    "app_namespace": "alert-manager",<br>    "app_path": "charts/alertmanager",<br>    "app_project": "easy",<br>    "app_repo_url": "https://github.com/prometheus-community/helm-charts",<br>    "app_target_revision": "HEAD"<br>  },<br>  "easy": {<br>    "app_directory_recurse": false,<br>    "app_name": "kube-state-metrics",<br>    "app_namespace": "kube-state-metrics",<br>    "app_path": "charts/kube-state-metrics",<br>    "app_project": "easy",<br>    "app_repo_url": "https://github.com/prometheus-community/helm-charts",<br>    "app_target_revision": "HEAD"<br>  }<br>}</pre> | no |
| <a name="input_argo_chart"></a> [argo\_chart](#input\_argo\_chart) | ArgoCD chart | `string` | `"argo-cd"` | no |
| <a name="input_argo_repository"></a> [argo\_repository](#input\_argo\_repository) | ArgoCD repository | `string` | `"https://argoproj.github.io/argo-helm"` | no |
| <a name="input_argo_version"></a> [argo\_version](#input\_argo\_version) | ArgoCD version | `string` | `"5.27.1"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace to deploy ArgoCD | `string` | `"argocd-system"` | no |
| <a name="input_notification"></a> [notification](#input\_notification) | Notification Setup | `any` | `{}` | no |
| <a name="input_private_repo"></a> [private\_repo](#input\_private\_repo) | Private repository | `any` | `{}` | no |
| <a name="input_project"></a> [project](#input\_project) | Project Setup | `any` | <pre>{<br>  "ezops": {<br>    "project_description": "Easy project",<br>    "project_name": "easy"<br>  }<br>}</pre> | no |
| <a name="input_public_repo"></a> [public\_repo](#input\_public\_repo) | Private repository | `any` | <pre>{<br>  "ezops": {<br>    "app_name": "prometheus",<br>    "public_repo_url": "https://github.com/prometheus-community/helm-charts"<br>  }<br>}</pre> | no |
| <a name="input_stage"></a> [stage](#input\_stage) | Stage to deploy ArgoCD | `string` | `"dev"` | no |
| <a name="input_values"></a> [values](#input\_values) | ArgoCD values | <pre>list(object({<br>    name  = string<br>    value = string<br>  }))</pre> | <pre>[<br>  {<br>    "name": "configs.cm.timeout.reconciliation",<br>    "value": "40s"<br>  },<br>  {<br>    "name": "configs.cm.params.applicationsetcontroller.enable.progressive.syncs",<br>    "value": true<br>  },<br>  {<br>    "name": "crds.install",<br>    "value": true<br>  }<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_argo_cd_application_name"></a> [argo\_cd\_application\_name](#output\_argo\_cd\_application\_name) | The name of the application |
| <a name="output_argo_cd_application_namespace"></a> [argo\_cd\_application\_namespace](#output\_argo\_cd\_application\_namespace) | The namespace in which the application is installed |
| <a name="output_argo_cd_notification_id"></a> [argo\_cd\_notification\_id](#output\_argo\_cd\_notification\_id) | The id of the notification |
| <a name="output_argo_cd_notification_name"></a> [argo\_cd\_notification\_name](#output\_argo\_cd\_notification\_name) | The name of the notification |
| <a name="output_argo_cd_private_repo_id"></a> [argo\_cd\_private\_repo\_id](#output\_argo\_cd\_private\_repo\_id) | The id of the private repo |
| <a name="output_argo_cd_private_repo_name"></a> [argo\_cd\_private\_repo\_name](#output\_argo\_cd\_private\_repo\_name) | The name of the private repo |
| <a name="output_argo_cd_project_id"></a> [argo\_cd\_project\_id](#output\_argo\_cd\_project\_id) | The id of the project |
| <a name="output_argo_cd_project_name"></a> [argo\_cd\_project\_name](#output\_argo\_cd\_project\_name) | The name of the project |
| <a name="output_argo_cd_public_repo_id"></a> [argo\_cd\_public\_repo\_id](#output\_argo\_cd\_public\_repo\_id) | The id of the public repo |
| <a name="output_argo_cd_public_repo_name"></a> [argo\_cd\_public\_repo\_name](#output\_argo\_cd\_public\_repo\_name) | The name of the public repo |
| <a name="output_helm_release_name"></a> [helm\_release\_name](#output\_helm\_release\_name) | The name of the release |
| <a name="output_helm_release_namespace"></a> [helm\_release\_namespace](#output\_helm\_release\_namespace) | The namespace in which the release is installed |
| <a name="output_helm_release_namespace_id"></a> [helm\_release\_namespace\_id](#output\_helm\_release\_namespace\_id) | The namespace in which the release is installed |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
