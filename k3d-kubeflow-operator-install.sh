#!/usr/bin/env bash
kustomize || exit 1

REPO_PATH="$HOME/repos/kfctl"
git clone https://github.com/kubeflow/kfctl.git "$REPO_PATH"
cd "$REPO_PATH"
git checkout v1.2-branch

export OPERATOR_NAMESPACE=kubeflow-operator
kubectl create ns ${OPERATOR_NAMESPACE}

cd deploy
kustomize edit set namespace ${OPERATOR_NAMESPACE}
kustomize build | kubectl apply -f -
kubectl create ns kubeflow