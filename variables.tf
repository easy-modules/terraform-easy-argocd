#------------------------------------------------------------------------------
# ARGO HELM CONFIG
#------------------------------------------------------------------------------
variable "stage" {
  type        = string
  description = "Stage to deploy ArgoCD"
  default     = "dev"
}

variable "namespace" {
  type        = string
  description = "Namespace to deploy ArgoCD"
  default     = "argocd-system"
}

variable "argo_version" {
  type        = string
  description = "ArgoCD version"
  default     = "5.27.1"
}

variable "argo_chart" {
  type        = string
  description = "ArgoCD chart"
  default     = "argo-cd"
}

variable "argo_repository" {
  type        = string
  description = "ArgoCD repository"
  default     = "https://argoproj.github.io/argo-helm"
}

variable "values" {
  description = "ArgoCD values"
  type = list(object({
    name  = string
    value = string
  }))
  default = [
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
    }
  ]
}


#------------------------------------------------------------------------------
# ARGO CD PROJECTS CONFIG
#------------------------------------------------------------------------------
variable "project" {
  type        = any
  description = "Project Setup"
  default = {
    ezops = {
      project_name        = "easy"
      project_description = "Easy project"
    }
  }
}

variable "private_repo" {
  type        = any
  description = "Private repository"
  default     = {}
  #  default = {
  #    ezops = {
  #      app_name         = "ezops"
  #      argo_namespace   = "argocd-system"
  #      private_repo_url = ""
  #      ssh_private_key  = ""
  #    }
  ##  }
  #}
}

variable "public_repo" {
  type        = any
  description = "Private repository"
  default = {
    ezops = {
      app_name        = "prometheus"
      public_repo_url = "https://github.com/prometheus-community/helm-charts"

    }
  }
}

variable "applications" {
  type        = any
  description = "Application Setup"
  default = {
    easy = {
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

variable "notification" {
  type        = any
  description = "Notification Setup"
  default     = {}
}
