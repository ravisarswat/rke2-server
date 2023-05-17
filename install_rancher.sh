#!/bin/bash

cp /etc/rancher/rke2/rke2.yaml ~/.kube/config

export KUBECONFIG=/etc/rancher/rke2/rke2.yaml
export PATH=$PATH:/var/lib/rancher/rke2/bin:/usr/local/bin  # Add the path to helm binary

(
  # Rest of your commands...
  curl -#L https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
  /usr/local/bin/helm repo add rancher-latest https://releases.rancher.com/server-charts/latest
  /usr/local/bin/helm repo add jetstack https://charts.jetstack.io
  kubectl apply -f https://github.com/jetstack/cert-manager/releases/download/v1.6.1/cert-manager.crds.yaml
  /usr/local/bin/helm upgrade -i cert-manager jetstack/cert-manager --namespace cert-manager --create-namespace
  /usr/local/bin/helm upgrade -i rancher rancher-latest/rancher --create-namespace --namespace cattle-system --set hostname=ryan.dell.com --set bootstrapPassword=ryan@123 --set replicas=1
)
