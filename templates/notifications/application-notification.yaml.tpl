---
apiVersion: v1
kind: Secret
metadata:
  name: argocd-notifications-secret
  namespace: ${ARGO_NAMESPACE}
stringData:
  slack-token: ${OAUTH_SLACK_TOKEN}
type: Opaque
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: argocd-notifications-cm
  namespace: ${ARGO_NAMESPACE}
data:
  service.slack: |
    token: $slack-token
  defaultTriggers: |
    - on-deployed
  trigger.on-deployed: |
    - description: Application is synced and healthy. Triggered once per commit.
      oncePer: app.status.operationState.syncResult.revision
      send:
        - app-deployed
      when: app.status.operationState.phase in ['Succeeded'] and app.status.health.status == 'Healthy' and app.status.sync.status == 'Synced'
  trigger.on-created: |
      - description: Application is created.
        oncePer: app.metadata.name
        send:
        - app-created
        when: "true"
    trigger.on-deleted: |
      - description: Application is deleted.
        oncePer: app.metadata.name
        send:
        - app-deleted
        when: app.metadata.deletionTimestamp != nil
    trigger.on-health-degraded: |
      - description: Application has degraded
        send:
        - app-health-degraded
        when: app.status.health.status == 'Degraded'
    trigger.on-sync-failed: |
      - description: Application syncing has failed
        send:
        - app-sync-failed
        when: app.status.operationState.phase in ['Error', 'Failed']
    trigger.on-sync-running: |
      - description: Application is being synced
        send:
        - app-sync-running
        when: app.status.operationState.phase in ['Running']
    trigger.on-sync-status-unknown: |
      - description: Application status is 'Unknown'
        send:
        - app-sync-status-unknown
        when: app.status.sync.status == 'Unknown'
    trigger.on-sync-succeeded: |
      - description: Application syncing has succeeded
        send:
        - app-sync-succeeded
        when: app.status.operationState.phase in ['Succeeded']
---
