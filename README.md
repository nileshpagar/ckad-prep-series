# Certified Kubernetes Application Developer (CKAD) Prep Series

Welcome to the **CKAD Preparation Series** repository! This repository contains code manifests, terminal practice scripts, project planning assets, and curriculum modules for our comprehensive YouTube training series designed to help software engineers and DevOps professionals pass the Linux Foundation / CNCF CKAD exam.

---

## 📌 Project Overview

- **Target Certification:** Certified Kubernetes Application Developer (CKAD)
- **Format:** Hands-on YouTube Video Tutorials & Guided Terminal Labs
- **Exam Weight Coverage:** 100% (Core Concepts, App Design, Security, Networking, Deployments, Observability)
- **Primary Execution Speed Focus:** Imperative CLI mastery (`kubectl run`, `--dry-run=client -o yaml`, shell aliases)

---

## 🛠️ Tooling & AI Tech Stack

This course is produced using state-of-the-art AI generation and video automation workflows:

- **Voice Generation & Cloning:** ElevenLabs / Descript (Custom Voice Model)
- **Presentation & Visuals:** Marp (Markdown-to-Slides) / Canva & Keynote / Excalidraw / Manim
- **Screen Capture & Demo Recording:** OBS Studio / Screen Studio / CleanShot X / Loom
- **Video & Audio Synchronization:** HeyGen / Fliki AI / DaVinci Resolve & CapCut Desktop

---

## 📂 Repository Structure

```text
.
├── manifests/            # Practice YAML manifests by exam domain
│   ├── phase-1-cli/      # Imperative CLI scripts & alias profiles
│   ├── phase-2-design/   # Pod patterns, Jobs, and PVC configs
│   ├── phase-3-config/   # SecurityContexts, ConfigMaps, and RBAC
│   ├── phase-4-network/  # Service manifests & NetworkPolicies
│   ├── phase-5-deploy/   # Rollout updates, StatefulSets, and Helm
│   └── phase-6-debug/    # Health probes & ephemeral containers

[//]: # (└── scripts/              # Automation and backlog management scripts)
