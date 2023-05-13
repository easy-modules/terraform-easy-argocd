apiVersion: argoproj.io/v1alpha1
kind: ApplicationSet
metadata:
  name: ${APP_NAME}
  namespace: ${ARGO_NAMESPACE}
spec:
  generators:
  - git:
      repoURL: ${APP_REPO_URL}
      revision: ${APP_TARGET_REVISION}
      directories:
      - path: ${APP_PATH}
  template:
    metadata:
      name: ${APP_NAME}
      namespace: ${ARGO_NAMESPACE}
    spec:
      project: ${APP_PROJECT}
      source:
        repoURL: ${APP_REPO_URL}
        targetRevision: ${APP_TARGET_REVISION}
        path: ${APP_PATH}
      destination:
        server: ${DESTINATION_SERVER}
        namespace: ${APP_NAMESPACE}
      syncPolicy:
        automated:
          prune: true
          selfHeal: true
        syncOptions:
          - CreateNamespace=true
