#!/bin/bash

# ==============================================================================
# CKAD PREP SERIES - MANIFESTS & FOLDER STRUCTURE GENERATOR
# Repository: https://github.com/nileshpagar/ckad-prep-series
# ==============================================================================

set -e

echo "=== 1. Creating CKAD Manifest Directory Hierarchy ==="

folders=(
  "manifests/phase-1-cli"
  "manifests/phase-2-design/multi-container"
  "manifests/phase-2-design/init-containers"
  "manifests/phase-2-design/jobs-cronjobs"
  "manifests/phase-2-design/volumes"
  "manifests/phase-3-config/configmaps-secrets"
  "manifests/phase-3-config/security-contexts"
  "manifests/phase-3-config/resources-quotas"
  "manifests/phase-3-config/rbac"
  "manifests/phase-4-network/services"
  "manifests/phase-4-network/ingress"
  "manifests/phase-4-network/network-policies"
  "manifests/phase-5-deploy/deployments"
  "manifests/phase-5-deploy/statefulsets-daemonsets"
  "manifests/phase-5-deploy/helm-canary"
  "manifests/phase-6-debug/probes"
  "manifests/phase-6-debug/logging-troubleshooting"
  "manifests/phase-6-debug/metrics-deprecations"
  "scripts"
)

for folder in "${folders[@]}"; do
  mkdir -p "$folder"
  echo "Created directory: $folder"
done

echo "=== 2. Generating Starter Manifests & Environment Scripts ==="

# ------------------------------------------------------------------------------
# Phase 1: CLI Navigation & Setup
# ------------------------------------------------------------------------------
cat << 'EOF' > manifests/phase-1-cli/setup-aliases.sh
#!/bin/bash
# CKAD Speed Setup
alias k=kubectl
export do="--dry-run=client -o yaml"
export now="--force --grace-period=0"
complete -o default -F __start_kubectl k
echo "CKAD fast CLI aliases enabled!"
EOF
chmod +x manifests/phase-1-cli/setup-aliases.sh

cat << 'EOF' > manifests/phase-1-cli/p1.2-nginx-pod.yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx-pod
  labels:
    app: nginx
spec:
  containers:
  - name: nginx
    image: nginx:alpine
    ports:
    - containerPort: 80
EOF

# ------------------------------------------------------------------------------
# Phase 2: Design & Build
# ------------------------------------------------------------------------------
cat << 'EOF' > manifests/phase-2-design/multi-container/p2.1-sidecar-logging.yaml
apiVersion: v1
kind: Pod
metadata:
  name: sidecar-logger-pod
spec:
  volumes:
  - name: log-vol
    emptyDir: {}
  containers:
  - name: app-container
    image: busybox
    command: ["sh", "-c", "while true; do echo $(date) 'App running...' >> /var/log/app.log; sleep 1; done"]
    volumeMounts:
    - name: log-vol
      mountPath: /var/log
  - name: sidecar-container
    image: busybox
    command: ["sh", "-c", "tail -n+1 -f /var/log/app.log"]
    volumeMounts:
    - name: log-vol
      mountPath: /var/log
EOF

cat << 'EOF' > manifests/phase-2-design/init-containers/p2.2-init-pod.yaml
apiVersion: v1
kind: Pod
metadata:
  name: init-demo-pod
spec:
  initContainers:
  - name: init-service
    image: busybox:1.28
    command: ['sh', '-c', 'until nslookup myservice; do echo waiting for myservice; sleep 2; done']
  containers:
  - name: main-app
    image: nginx:alpine
EOF

cat << 'EOF' > manifests/phase-2-design/jobs-cronjobs/p2.3-batch-job.yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: batch-job-demo
spec:
  completions: 3
  parallelism: 2
  backoffLimit: 4
  template:
    spec:
      containers:
      - name: job-worker
        image: busybox
        command: ["sh", "-c", "echo Processing batch job... && sleep 3"]
      restartPolicy: Never
EOF

cat << 'EOF' > manifests/phase-2-design/volumes/p2.4-pv-pvc.yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: ckad-pv
spec:
  capacity:
    storage: 1Gi
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: "/mnt/data"
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: ckad-pvc
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
EOF

# ------------------------------------------------------------------------------
# Phase 3: Config & Security
# ------------------------------------------------------------------------------
cat << 'EOF' > manifests/phase-3-config/configmaps-secrets/p3.1-configmap-secret.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-config
data:
  APP_COLOR: "blue"
  DB_HOST: "postgres-svc"
---
apiVersion: v1
kind: Secret
metadata:
  name: app-secret
type: Opaque
stringData:
  DB_PASSWORD: "SuperSecurePassword123"
EOF

cat << 'EOF' > manifests/phase-3-config/security-contexts/p3.2-security-context.yaml
apiVersion: v1
kind: Pod
metadata:
  name: secure-pod
spec:
  securityContext:
    runAsUser: 1000
    runAsGroup: 3000
    fsGroup: 2000
  containers:
  - name: secure-container
    image: busybox
    command: ["sh", "-c", "sleep 3600"]
    securityContext:
      allowPrivilegeEscalation: false
      readOnlyRootFilesystem: false
EOF

cat << 'EOF' > manifests/phase-3-config/resources-quotas/p3.3-resource-limits.yaml
apiVersion: v1
kind: Pod
metadata:
  name: resource-constrained-pod
spec:
  containers:
  - name: app
    image: nginx:alpine
    resources:
      requests:
        memory: "64Mi"
        cpu: "250m"
      limits:
        memory: "128Mi"
        cpu: "500m"
EOF

cat << 'EOF' > manifests/phase-3-config/rbac/p3.4-rbac-role.yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  namespace: default
  name: pod-reader
rules:
- apiGroups: [""]
  resources: ["pods"]
  verbs: ["get", "watch", "list"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: read-pods
  namespace: default
subjects:
- kind: ServiceAccount
  name: default
  namespace: default
roleRef:
  kind: Role
  name: pod-reader
  apiGroup: rbac.authorization.k8s.io
EOF

# ------------------------------------------------------------------------------
# Phase 4: Networking
# ------------------------------------------------------------------------------
cat << 'EOF' > manifests/phase-4-network/services/p4.1-nodeport-service.yaml
apiVersion: v1
kind: Service
metadata:
  name: web-service
spec:
  type: NodePort
  selector:
    app: web
  ports:
  - port: 80
    targetPort: 80
    nodePort: 30080
EOF

cat << 'EOF' > manifests/phase-4-network/ingress/p4.2-ingress-routing.yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: app-ingress
spec:
  rules:
  - host: ckad.example.com
    http:
      paths:
      - path: /api
        pathType: Prefix
        backend:
          service:
            name: api-service
            port:
              number: 8080
EOF

cat << 'EOF' > manifests/phase-4-network/network-policies/p4.3-network-policy.yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: deny-all-ingress
  namespace: default
spec:
  podSelector: {}
  policyTypes:
  - Ingress
EOF

# ------------------------------------------------------------------------------
# Phase 5: Deployments & Helm
# ------------------------------------------------------------------------------
cat << 'EOF' > manifests/phase-5-deploy/deployments/p5.1-rolling-deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web-deployment
spec:
  replicas: 3
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 0
  selector:
    matchLabels:
      app: web
  template:
    metadata:
      labels:
        app: web
    spec:
      containers:
      - name: nginx
        image: nginx:1.21.0
        ports:
        - containerPort: 80
EOF

cat << 'EOF' > manifests/phase-5-deploy/statefulsets-daemonsets/p5.2-daemonset.yaml
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: logging-agent
spec:
  selector:
    matchLabels:
      name: logging-agent
  template:
    metadata:
      labels:
        name: logging-agent
    spec:
      containers:
      - name: agent
        image: fluentd
EOF

# ------------------------------------------------------------------------------
# Phase 6: Observability
# ------------------------------------------------------------------------------
cat << 'EOF' > manifests/phase-6-debug/probes/p6.1-liveness-readiness.yaml
apiVersion: v1
kind: Pod
metadata:
  name: probed-pod
spec:
  containers:
  - name: web
    image: nginx:alpine
    livenessProbe:
      httpGet:
        path: /
        port: 80
      initialDelaySeconds: 5
      periodSeconds: 10
    readinessProbe:
      httpGet:
        path: /
        port: 80
      initialDelaySeconds: 3
      periodSeconds: 5
EOF

echo "=== All Manifest Folders and Starter Files Successfully Created! ==="