#!/bin/bash

# Epic 1: Exam Readiness & CLI Mechanics
gh issue create --title "P1.1: Fast CLI Navigation & Aliases" \
  --body "Configure kubectl aliases, bash completion, and imperative dry-run generation." \
  --label "Epic-1,Priority-P0"

gh issue create --title "P1.2: Pod Creation & Imperative Commands" \
  --body "Practice creating Pod manifests imperatively using kubectl run." \
  --label "Epic-1,Priority-P0"

# Epic 2: Application Design & Build
gh issue create --title "P2.1: Multi-Container Pod Patterns" \
  --body "Implement Sidecar, Ambassador, and Adapter container patterns." \
  --label "Epic-2,Priority-P0"

gh issue create --title "P2.2: Init Containers & Multi-Stage Initialization" \
  --body "Configure Init Containers to run pre-flight tasks before main containers start." \
  --label "Epic-2,Priority-P0"

gh issue create --title "P2.3: Jobs & CronJobs Management" \
  --body "Define batch Jobs and CronJobs with completions, parallelism, and backoff limits." \
  --label "Epic-2,Priority-P0"

gh issue create --title "P2.4: Persistent & Ephemeral Volumes" \
  --body "Configure emptyDir, hostPath, PersistentVolumes (PV), and PersistentVolumeClaims (PVC)." \
  --label "Epic-2,Priority-P0"

# Epic 3: Configuration, Security & Governance
gh issue create --title "P3.1: ConfigMaps & Secrets Management" \
  --body "Inject ConfigMaps and Secrets into Pods as environment variables and volume mounts." \
  --label "Epic-3,Priority-P0"

gh issue create --title "P3.2: SecurityContexts & ServiceAccounts" \
  --body "Configure runAsUser, capabilities, readOnlyRootFilesystem, and Pod ServiceAccounts." \
  --label "Epic-3,Priority-P0"

gh issue create --title "P3.3: Resource Quotas, Limits & Requests" \
  --body "Set CPU/Memory requests and limits on Pods, and configure LimitRanges." \
  --label "Epic-3,Priority-P0"

gh issue create --title "P3.4: Authentication, Authorization & Admission" \
  --body "Configure Role-Based Access Control (RBAC) rules, RoleBindings, and CRDs." \
  --label "Epic-3,Priority-P0"

# Epic 4: Services & Network Management
gh issue create --title "P4.1: Services & Endpoints" \
  --body "Create ClusterIP, NodePort, and LoadBalancer services to expose workloads." \
  --label "Epic-4,Priority-P1"

gh issue create --title "P4.2: Ingress Rules & Traffic Routing" \
  --body "Configure HTTP/HTTPS Ingress rules, host/path routing, and TLS termination." \
  --label "Epic-4,Priority-P1"

gh issue create --title "P4.3: NetworkPolicies (Ingress & Egress)" \
  --body "Author NetworkPolicies defining ingress and egress rules with pod and namespace selectors." \
  --label "Epic-4,Priority-P1"

# Epic 5: Application Deployment & Strategy
gh issue create --title "P5.1: Deployments, Rolling Updates & Rollbacks" \
  --body "Manage rolling updates, check rollout status, and perform rollbacks." \
  --label "Epic-5,Priority-P1"

gh issue create --title "P5.2: StatefulSets & DaemonSets" \
  --body "Configure StatefulSets for ordered deployment and DaemonSets for node-level agents." \
  --label "Epic-5,Priority-P1"

gh issue create --title "P5.3: Advanced Deployment Strategies & Helm" \
  --body "Implement Blue/Green and Canary deployments, and deploy apps using Helm charts." \
  --label "Epic-5,Priority-P1"

# Epic 6: Observability & Maintenance
gh issue create --title "P6.1: Health Checks & Probes" \
  --body "Configure Liveness, Readiness, and Startup probes using HTTP, TCP, and Exec." \
  --label "Epic-6,Priority-P2"

gh issue create --title "P6.2: Container Logging & Troubleshooting" \
  --body "Inspect multi-container logs and attach ephemeral debug containers to running pods." \
  --label "Epic-6,Priority-P2"

gh issue create --title "P6.3: Cluster Metrics & Deprecations" \
  --body "Use kubectl top pod/node to isolate bottlenecks and inspect API deprecations." \
  --label "Epic-6,Priority-P2"


# ==============================================================================
# GH BACKLOG STRUCTURING SCRIPT
# Applies Epic -> Feature -> Story hierarchy with cascading labels and parent linking
# ==============================================================================

set -e

# Verify GitHub CLI
if ! command -v gh &> /dev/null; then
    echo "Error: GitHub CLI (gh) is not installed."
    exit 1
fi

echo "=== 1. Creating Label Taxonomy ==="

# Tier Labels
gh label create "type: epic" --color "5319E7" --description "Top-level domain epic" --force
gh label create "type: feature" --color "1D76DB" --description "Mid-level capability feature" --force
gh label create "type: story" --color "0E8A16" --description "Actionable implementation story" --force

# Epic Domain Labels
gh label create "epic: exam-readiness" --color "B60205" --description "Domain: Exam Readiness & CLI Speed" --force
gh label create "epic: app-design" --color "D93F0C" --description "Domain: Application Design & Build" --force
gh label create "epic: config-security" --color "FBCA04" --description "Domain: App Environment, Config & Security" --force
gh label create "epic: networking" --color "006B75" --description "Domain: Services & Networking" --force
gh label create "epic: deployment" --color "2188E9" --description "Domain: Application Deployment" --force
gh label create "epic: observability" --color "D4C5F9" --description "Domain: Observability & Maintenance" --force

# Feature Grouping Labels
gh label create "feature: cli-speed" --color "C2E0C6" --force
gh label create "feature: pod-patterns" --color "BFD4F2" --force
gh label create "feature: batch-jobs" --color "BFD4F2" --force
gh label create "feature: storage" --color "BFD4F2" --force
gh label create "feature: config-mgmt" --color "FEF2C0" --force
gh label create "feature: security-context" --color "FEF2C0" --force
gh label create "feature: resources" --color "FEF2C0" --force
gh label create "feature: rbac" --color "FEF2C0" --force
gh label create "feature: services" --color "C5DEF5" --force
gh label create "feature: ingress" --color "C5DEF5" --force
gh label create "feature: network-policy" --color "C5DEF5" --force
gh label create "feature: rollout-strategy" --color "BFDAD8" --force
gh label create "feature: stateful-workloads" --color "BFDAD8" --force
gh label create "feature: helm-deploy" --color "BFDAD8" --force
gh label create "feature: health-probes" --color "E9D5DA" --force
gh label create "feature: logging-debug" --color "E9D5DA" --force
gh label create "feature: metrics" --color "E9D5DA" --force

echo "=== 2. Creating Epics ==="

EPIC_1_NUM=$(gh issue create --title "[EPIC] Exam Readiness & CLI Speed" \
  --body "Top-level Epic covering execution speed, imperative YAML generation, and alias setups for CKAD." \
  --label "type: epic,epic: exam-readiness" | grep -o '[0-9]*$')

EPIC_2_NUM=$(gh issue create --title "[EPIC] Application Design and Build" \
  --body "Top-level Epic covering multi-container patterns, pod init, batch jobs, and persistent storage." \
  --label "type: epic,epic: app-design" | grep -o '[0-9]*$')

EPIC_3_NUM=$(gh issue create --title "[EPIC] App Environment, Config & Security" \
  --body "Top-level Epic covering ConfigMaps, Secrets, SecurityContexts, ResourceQuotas, and RBAC." \
  --label "type: epic,epic: config-security" | grep -o '[0-9]*$')

EPIC_4_NUM=$(gh issue create --title "[EPIC] Services & Networking" \
  --body "Top-level Epic covering Service types, Ingress controllers, and NetworkPolicies." \
  --label "type: epic,epic: networking" | grep -o '[0-9]*$')

EPIC_5_NUM=$(gh issue create --title "[EPIC] Application Deployment Strategy" \
  --body "Top-level Epic covering deployment rollouts, StatefulSets, DaemonSets, and Helm." \
  --label "type: epic,epic: deployment" | grep -o '[0-9]*$')

EPIC_6_NUM=$(gh issue create --title "[EPIC] Observability and Maintenance" \
  --body "Top-level Epic covering lifecycle probes, troubleshooting, logging, and metrics." \
  --label "type: epic,epic: observability" | grep -o '[0-9]*$')

echo "=== 3. Creating Features linked to Epics ==="

# Features under Epic 1
FEAT_1_1=$(gh issue create --title "[FEATURE] Fast CLI Navigation & Shell Setup" \
  --body "Parent Epic: #${EPIC_1_NUM}\n\nEstablish fast CLI navigation shortcuts and dry-run YAML generation." \
  --label "type: feature,epic: exam-readiness,feature: cli-speed" | grep -o '[0-9]*$')

# Features under Epic 2
FEAT_2_1=$(gh issue create --title "[FEATURE] Multi-Container & Init Pod Patterns" \
  --body "Parent Epic: #${EPIC_2_NUM}\n\nImplement sidecar, adapter, ambassador, and initContainer workloads." \
  --label "type: feature,epic: app-design,feature: pod-patterns" | grep -o '[0-9]*$')

FEAT_2_2=$(gh issue create --title "[FEATURE] Batch Jobs & Cron Workloads" \
  --body "Parent Epic: #${EPIC_2_NUM}\n\nManage non-interactive batch job execution models." \
  --label "type: feature,epic: app-design,feature: batch-jobs" | grep -o '[0-9]*$')

FEAT_2_3=$(gh issue create --title "[FEATURE] Storage & Volume Persistence" \
  --body "Parent Epic: #${EPIC_2_NUM}\n\nHandle volume mounts, PV, and PVC bindings." \
  --label "type: feature,epic: app-design,feature: storage" | grep -o '[0-9]*$')

# Features under Epic 3
FEAT_3_1=$(gh issue create --title "[FEATURE] App Configuration & Secrets" \
  --body "Parent Epic: #${EPIC_3_NUM}\n\nManage environment injection via ConfigMaps and Secrets." \
  --label "type: feature,epic: config-security,feature: config-mgmt" | grep -o '[0-9]*$')

FEAT_3_2=$(gh issue create --title "[FEATURE] Container Security & Isolation" \
  --body "Parent Epic: #${EPIC_3_NUM}\n\nConfigure pod security settings and ServiceAccount bindings." \
  --label "type: feature,epic: config-security,feature: security-context" | grep -o '[0-9]*$')

FEAT_3_3=$(gh issue create --title "[FEATURE] Resource Governance & Boundaries" \
  --body "Parent Epic: #${EPIC_3_NUM}\n\nSet CPU/Memory boundaries and namespace quotas." \
  --label "type: feature,epic: config-security,feature: resources" | grep -o '[0-9]*$')

FEAT_3_4=$(gh issue create --title "[FEATURE] Access Control & RBAC Policy" \
  --body "Parent Epic: #${EPIC_3_NUM}\n\nDefine user/app permissions using Roles and RoleBindings." \
  --label "type: feature,epic: config-security,feature: rbac" | grep -o '[0-9]*$')

# Features under Epic 4
FEAT_4_1=$(gh issue create --title "[FEATURE] Service Endpoints & Traffic Controls" \
  --body "Parent Epic: #${EPIC_4_NUM}\n\nExpose pod workloads across cluster service boundaries." \
  --label "type: feature,epic: networking,feature: services" | grep -o '[0-9]*$')

FEAT_4_2=$(gh issue create --title "[FEATURE] Ingress Controller Routing" \
  --body "Parent Epic: #${EPIC_4_NUM}\n\nRoute external L7 HTTP/HTTPS traffic into internal services." \
  --label "type: feature,epic: networking,feature: ingress" | grep -o '[0-9]*$')

FEAT_4_3=$(gh issue create --title "[FEATURE] Network Security Policies" \
  --body "Parent Epic: #${EPIC_4_NUM}\n\nRestructure pod-to-pod ingress/egress network traffic." \
  --label "type: feature,epic: networking,feature: network-policy" | grep -o '[0-9]*$')

# Features under Epic 5
FEAT_5_1=$(gh issue create --title "[FEATURE] Deployment Lifecycle & Rollouts" \
  --body "Parent Epic: #${EPIC_5_NUM}\n\nManage rolling updates and rollback strategies." \
  --label "type: feature,epic: deployment,feature: rollout-strategy" | grep -o '[0-9]*$')

FEAT_5_2=$(gh issue create --title "[FEATURE] Stateful & Node-Level Workloads" \
  --body "Parent Epic: #${EPIC_5_NUM}\n\nManage StatefulSets and DaemonSet agents." \
  --label "type: feature,epic: deployment,feature: stateful-workloads" | grep -o '[0-9]*$')

FEAT_5_3=$(gh issue create --title "[FEATURE] Packaging & Advanced Deployment Patterns" \
  --body "Parent Epic: #${EPIC_5_NUM}\n\nExecute Blue/Green, Canary, and Helm chart releases." \
  --label "type: feature,epic: deployment,feature: helm-deploy" | grep -o '[0-9]*$')

# Features under Epic 6
FEAT_6_1=$(gh issue create --title "[FEATURE] Health Monitoring & Lifecycle Probes" \
  --body "Parent Epic: #${EPIC_6_NUM}\n\nConfigure liveness, readiness, and startup health checks." \
  --label "type: feature,epic: observability,feature: health-probes" | grep -o '[0-9]*$')

FEAT_6_2=$(gh issue create --title "[FEATURE] Runtime Diagnostics & Debugging" \
  --body "Parent Epic: #${EPIC_6_NUM}\n\nInspect logs and debug failing container instances." \
  --label "type: feature,epic: observability,feature: logging-debug" | grep -o '[0-9]*$')

FEAT_6_3=$(gh issue create --title "[FEATURE] Cluster Metrics & API Deprecations" \
  --body "Parent Epic: #${EPIC_6_NUM}\n\nMonitor resource utilization and update deprecated API manifests." \
  --label "type: feature,epic: observability,feature: metrics" | grep -o '[0-9]*$')

echo "=== 4. Updating Existing Story Issues with Epic & Feature Labels ==="

# Helper function to tag and link stories
tag_story() {
  local title_pattern="$1"
  local parent_feature_num="$2"
  local epic_label="$3"
  local feature_label="$4"

  issue_num=$(gh issue list --search "$title_pattern" --json number --jq '.[0].number')

  if [ -n "$issue_num" ] && [ "$issue_num" != "null" ]; then
    echo "Updating Story #${issue_num} ($title_pattern)..."
    gh issue edit "$issue_num" \
      --add-label "type: story,${epic_label},${feature_label}" \
      --body "$(gh issue view "$issue_num" --json body --jq '.body')

---
**Parent Feature:** #${parent_feature_num}"
  else
    echo "Warning: Story with pattern '$title_pattern' not found."
  fi
}

# Epic 1 Stories
tag_story "P1.1: Exam Setup" "$FEAT_1_1" "epic: exam-readiness" "feature: cli-speed"
tag_story "P1.2: Pod Creation" "$FEAT_1_1" "epic: exam-readiness" "feature: cli-speed"

# Epic 2 Stories
tag_story "P2.1: Multi-Container" "$FEAT_2_1" "epic: app-design" "feature: pod-patterns"
tag_story "P2.2: Init Containers" "$FEAT_2_1" "epic: app-design" "feature: pod-patterns"
tag_story "P2.3: Jobs & CronJobs" "$FEAT_2_2" "epic: app-design" "feature: batch-jobs"
tag_story "P2.4: Persistent & Ephemeral" "$FEAT_2_3" "epic: app-design" "feature: storage"

# Epic 3 Stories
tag_story "P3.1: ConfigMaps & Secrets" "$FEAT_3_1" "epic: config-security" "feature: config-mgmt"
tag_story "P3.2: SecurityContexts" "$FEAT_3_2" "epic: config-security" "feature: security-context"
tag_story "P3.3: Resource Quotas" "$FEAT_3_3" "epic: config-security" "feature: resources"
tag_story "P3.4: Authentication" "$FEAT_3_4" "epic: config-security" "feature: rbac"

# Epic 4 Stories
tag_story "P4.1: Services & Endpoints" "$FEAT_4_1" "epic: networking" "feature: services"
tag_story "P4.2: Ingress Rules" "$FEAT_4_2" "epic: networking" "feature: ingress"
tag_story "P4.3: NetworkPolicies" "$FEAT_4_3" "epic: networking" "feature: network-policy"

# Epic 5 Stories
tag_story "P5.1: Deployments" "$FEAT_5_1" "epic: deployment" "feature: rollout-strategy"
tag_story "P5.2: StatefulSets" "$FEAT_5_2" "epic: deployment" "feature: stateful-workloads"
tag_story "P5.3: Deployment Strategies" "$FEAT_5_3" "epic: deployment" "feature: helm-deploy"

# Epic 6 Stories
tag_story "P6.1: Health Checks" "$FEAT_6_1" "epic: observability" "feature: health-probes"
tag_story "P6.2: Container Logging" "$FEAT_6_2" "epic: observability" "feature: logging-debug"
tag_story "P6.3: Monitoring & Metrics" "$FEAT_6_3" "epic: observability" "feature: metrics"

echo "=== Backlog Hierarchy Successfully Established! ==="


