#!/bin/bash

# ==============================================================================
# GITHUB ISSUE ESTIMATES UPDATE SCRIPT
# Appends Story Points and Hour Estimates to CKAD GitHub Issues
# ==============================================================================

set -e

# Verify GitHub CLI
if ! command -v gh &> /dev/null; then
    echo "Error: GitHub CLI (gh) is not installed."
    exit 1
fi

echo "=== 1. Creating Estimate Labels ==="
gh label create "estimate: 2pts" --color "D4C5F9" --description "2 Story Points (~4 Hours)" --force
gh label create "estimate: 3pts" --color "BFD4F2" --description "3 Story Points (~6 Hours)" --force
gh label create "estimate: 5pts" --color "FBCA04" --description "5 Story Points (~8 Hours)" --force

echo "=== 2. Updating Issues with Estimates ==="

# Helper function to append estimates and add label
apply_estimate() {
  local search_term="$1"
  local points="$2"
  local hours="$3"
  local label_name="$4"

  issue_num=$(gh issue list --search "$search_term" --json number --jq '.[0].number')

  if [ -n "$issue_num" ] && [ "$issue_num" != "null" ]; then
    echo "Updating Issue #${issue_num} ($search_term) -> ${points} Story Points (${hours} hrs)..."

    current_body=$(gh issue view "$issue_num" --json body --jq '.body')

    # Check if estimate section already exists to prevent duplicate appending
    if [[ "$current_body" != *"Estimation Details"* ]]; then
      new_body="${current_body}

---
### Estimation Details
- **Story Points:** ${points}
- **Estimated Effort:** ${hours} hours"
    else
      new_body="$current_body"
    fi

    gh issue edit "$issue_num" \
      --add-label "$label_name" \
      --body "$new_body"
  else
    echo "Warning: Issue matching '$search_term' not found."
  fi
}

# Phase 1: Foundation
apply_estimate "P1.1: Exam Setup" "2" "4" "estimate: 2pts"
apply_estimate "P1.2: Pod Creation" "2" "4" "estimate: 2pts"

# Phase 2: Design & Build
apply_estimate "P2.1: Multi-Container" "5" "8" "estimate: 5pts"
apply_estimate "P2.2: Init Containers" "3" "6" "estimate: 3pts"
apply_estimate "P2.3: Jobs & CronJobs" "3" "6" "estimate: 3pts"
apply_estimate "P2.4: Persistent & Ephemeral" "5" "8" "estimate: 5pts"

# Phase 3: Config & Security
apply_estimate "P3.1: ConfigMaps & Secrets" "3" "6" "estimate: 3pts"
apply_estimate "P3.2: SecurityContexts" "5" "8" "estimate: 5pts"
apply_estimate "P3.3: Resource Quotas" "3" "6" "estimate: 3pts"
apply_estimate "P3.4: Authentication" "5" "8" "estimate: 5pts"

# Phase 4: Services & Networking
apply_estimate "P4.1: Services & Endpoints" "3" "6" "estimate: 3pts"
apply_estimate "P4.2: Ingress Rules" "5" "8" "estimate: 5pts"
apply_estimate "P4.3: NetworkPolicies" "5" "8" "estimate: 5pts"

# Phase 5: Deployments
apply_estimate "P5.1: Deployments" "3" "6" "estimate: 3pts"
apply_estimate "P5.2: StatefulSets" "5" "8" "estimate: 5pts"
apply_estimate "P5.3: Deployment Strategies" "3" "6" "estimate: 3pts"

# Phase 6: Observability
apply_estimate "P6.1: Health Checks" "3" "6" "estimate: 3pts"
apply_estimate "P6.2: Container Logging" "3" "6" "estimate: 3pts"
apply_estimate "P6.3: Monitoring & Metrics" "2" "4" "estimate: 2pts"

echo "=== All Issues Successfully Updated with Estimates! ==="