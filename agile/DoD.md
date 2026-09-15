# Definition of Done (DoD) - CKAD YouTube Series & Manifest Repo

A User Story / Task is considered "DONE" and ready for YouTube production release when it meets the following criteria:

1. **Manifest & Code Verification:**
    - Kubernetes YAML manifests pass syntax validation (`kubectl apply --dry-run=client`).
    - Manifests strictly follow the latest supported API version (`apps/v1`, `batch/v1`, `networking.k8s.io/v1`).
    - Resource names, labels, and selectors adhere to the project naming conventions.

2. **Automated & Manual Lab Testing:**
    - Manifests successfully deploy and execute on a local cluster (`kind` or `minikube`).
    - Imperative CLI generation shortcuts are validated for speed (< 30 seconds generation target).

3. **Video & Script Production Assets:**
    - Lesson script rewritten and approved in Gherkin / BDD format.
    - AI audio generated in cloned voice and checked for smooth cadence and natural pauses.
    - Slide deck / visual overlays rendered in 4K resolution (1080p minimum).
    - Audio and slide visual transitions synced cleanly without audio clipping.

4. **GitHub Repository Maintenance:**
    - Relevant YAML manifests committed to the designated `/manifests/phase-X/` folder.
    - GitHub Issue updated with Sprint label, dependencies linked, and marked as `Closed`.