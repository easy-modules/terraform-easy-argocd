# README

## Terraform easy modules

Terraform module to deploy ArgoCD

### Usage

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

## LOGIN

If you want to login to argo CD using default credentials you can use the following command:

Username: **admin**

Password: `kubectl get -namespace argocd-system secrets argocd-initial-admin-secret -o=jsonpath='{.data.password}' | base64 -d`

### Requirements

| Name                                   | Version  |
| -------------------------------------- | -------- |
| [terraform](./#requirement\_terraform) | >=1.0.0  |
| [aws](./#requirement\_aws)             | 4.0.0    |
| [helm](./#requirement\_helm)           | 2.9.0    |
| [kubectl](./#requirement\_kubectl)     | >= 1.7.0 |

### Providers

| Name                            | Version  |
| ------------------------------- | -------- |
| [helm](./#provider\_helm)       | 2.9.0    |
| [kubectl](./#provider\_kubectl) | >= 1.7.0 |

### Modules

No modules.

### Resources

| Name                                                                                                                                    | Type     |
| --------------------------------------------------------------------------------------------------------------------------------------- | -------- |
| [helm\_release.argo\_cd\_install](https://registry.terraform.io/providers/hashicorp/helm/2.9.0/docs/resources/release)                  | resource |
| [kubectl\_manifest.argo\_cd\_application](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest)   | resource |
| [kubectl\_manifest.argo\_cd\_notification](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest)  | resource |
| [kubectl\_manifest.argo\_cd\_private\_repo](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl\_manifest.argo\_cd\_project](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest)       | resource |
| [kubectl\_manifest.argo\_cd\_public\_repo](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest)  | resource |

### Inputs

| Name                                           | Description                | Type                                                                               | Default                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | Required |
| ---------------------------------------------- | -------------------------- | ---------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------: |
| [applications](./#input\_applications)         | Application Setup          | `any`                                                                              | <pre><code>{
  "alert-manager": {
    "app_directory_recurse": false,
    "app_name": "alert-manager",
    "app_namespace": "alert-manager",
    "app_path": "charts/alertmanager",
    "app_project": "easy",
    "app_repo_url": "https://github.com/prometheus-community/helm-charts",
    "app_target_revision": "HEAD"
  },
  "easy": {
    "app_directory_recurse": false,
    "app_name": "kube-state-metrics",
    "app_namespace": "kube-state-metrics",
    "app_path": "charts/kube-state-metrics",
    "app_project": "easy",
    "app_repo_url": "https://github.com/prometheus-community/helm-charts",
    "app_target_revision": "HEAD"
  }
}
</code></pre> |    no    |
| [argo\_chart](./#input\_argo\_chart)           | ArgoCD chart               | `string`                                                                           | `"argo-cd"`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |    no    |
| [argo\_repository](./#input\_argo\_repository) | ArgoCD repository          | `string`                                                                           | `"https://argoproj.github.io/argo-helm"`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |    no    |
| [argo\_version](./#input\_argo\_version)       | ArgoCD version             | `string`                                                                           | `"5.27.1"`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |    no    |
| [namespace](./#input\_namespace)               | Namespace to deploy ArgoCD | `string`                                                                           | `"argocd-system"`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |    no    |
| [notification](./#input\_notification)         | Notification Setup         | `any`                                                                              | `{}`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |    no    |
| [private\_repo](./#input\_private\_repo)       | Private repository         | `any`                                                                              | `{}`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |    no    |
| [project](./#input\_project)                   | Project Setup              | `any`                                                                              | <pre><code>{
  "ezops": {
    "project_description": "Easy project",
    "project_name": "easy"
  }
}
</code></pre>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |    no    |
| [public\_repo](./#input\_public\_repo)         | Private repository         | `any`                                                                              | <pre><code>{
  "ezops": {
    "app_name": "prometheus",
    "public_repo_url": "https://github.com/prometheus-community/helm-charts"
  }
}
</code></pre>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |    no    |
| [stage](./#input\_stage)                       | Stage to deploy ArgoCD     | `string`                                                                           | `"dev"`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |    no    |
| [values](./#input\_values)                     | ArgoCD values              | <pre><code>list(object({
    name  = string
    value = string
  }))
</code></pre> | <pre><code>[
  {
    "name": "configs.cm.timeout.reconciliation",
    "value": "40s"
  },
  {
    "name": "configs.cm.params.applicationsetcontroller.enable.progressive.syncs",
    "value": true
  },
  {
    "name": "crds.install",
    "value": true
  }
]
</code></pre>                                                                                                                                                                                                                                                                                                                                                                                              |    no    |

### Outputs

| Name                                                                            | Description                                         |
| ------------------------------------------------------------------------------- | --------------------------------------------------- |
| [argo\_cd\_application\_name](./#output\_argo\_cd\_application\_name)           | The name of the application                         |
| [argo\_cd\_application\_namespace](./#output\_argo\_cd\_application\_namespace) | The namespace in which the application is installed |
| [argo\_cd\_notification\_id](./#output\_argo\_cd\_notification\_id)             | The id of the notification                          |
| [argo\_cd\_notification\_name](./#output\_argo\_cd\_notification\_name)         | The name of the notification                        |
| [argo\_cd\_private\_repo\_id](./#output\_argo\_cd\_private\_repo\_id)           | The id of the private repo                          |
| [argo\_cd\_private\_repo\_name](./#output\_argo\_cd\_private\_repo\_name)       | The name of the private repo                        |
| [argo\_cd\_project\_id](./#output\_argo\_cd\_project\_id)                       | The id of the project                               |
| [argo\_cd\_project\_name](./#output\_argo\_cd\_project\_name)                   | The name of the project                             |
| [argo\_cd\_public\_repo\_id](./#output\_argo\_cd\_public\_repo\_id)             | The id of the public repo                           |
| [argo\_cd\_public\_repo\_name](./#output\_argo\_cd\_public\_repo\_name)         | The name of the public repo                         |
| [helm\_release\_name](./#output\_helm\_release\_name)                           | The name of the release                             |
| [helm\_release\_namespace](./#output\_helm\_release\_namespace)                 | The namespace in which the release is installed     |
| [helm\_release\_namespace\_id](./#output\_helm\_release\_namespace\_id)         | The namespace in which the release is installed     |
|                                                                                 |                                                     |
