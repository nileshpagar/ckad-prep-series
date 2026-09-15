#!/bin/bash
# CKAD Speed Setup
alias k=kubectl
export do="--dry-run=client -o yaml"
export now="--force --grace-period=0"
complete -o default -F __start_kubectl k
echo "CKAD fast CLI aliases enabled!"
