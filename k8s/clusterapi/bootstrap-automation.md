docker run --rm \
  -v "$(pwd)":/out \
  -v "$(pwd)/envvars-cloudadmin.txt":/envvars.txt:ro \
  gcr.io/cluster-api-provider-vsphere/release/manifests:latest \
  -c management-cluster-cloudadmin

docker run --rm \
  -v "$(pwd)":/out \
  -v "$(pwd)/envvars-cloudadmin.txt":/envvars.txt:ro \
  gcr.io/cluster-api-provider-vsphere/release/manifests:latest \
  -c management-cluster

docker run --rm \
  -v "$(pwd)":/out \
  -v "$(pwd)/envvars.txt":/envvars.txt:ro \
  gcr.io/cluster-api-provider-vsphere/release/manifests:latest \
  -c management-cluster1

clusterctl create cluster \
  --bootstrap-type kind \
  --bootstrap-flags name=capv-cluster-mgmt-02 \
  --cluster ./out/management-cluster1/cluster.yaml \
  --machines ./out/management-cluster1/controlplane.yaml \
  --provider-components ./out/management-cluster1/provider-components.yaml \
  --addon-components ./out/management-cluster1/addons.yaml \
  --kubeconfig-out ./out/management-cluster1/kubeconfig


docker run --rm \
  -v "$(pwd)":/out \
  -v "$(pwd)/envvars.txt":/envvars.txt:ro \
  gcr.io/cluster-api-provider-vsphere/release/manifests:latest \
  -c workload-cluster-03

# deploy
kubectl apply -f ./out/workload-cluster-03/cluster.yaml -f ./out/workload-cluster-03/controlplane.yaml -f ./out/workload-cluster-03/machinedeployment.yaml

# get kubeconfig
x



  clusterctl create cluster \
  --bootstrap-type kind \
  --bootstrap-flags name=capv-cluster-mgmt-cloudadmin-01 \
  --cluster ./out/management-cluster-cloudadmin/cluster.yaml \
  --machines ./out/management-cluster-cloudadmin/controlplane.yaml \
  --provider-components ./out/management-cluster-cloudadmin/provider-components.yaml \
  --addon-components ./out/management-cluster-cloudadmin/addons.yaml \
  --kubeconfig-out ./out/management-cluster-cloudadmin/kubeconfig

  docker run --rm \
  -v "$(pwd)":/out \
  -v "$(pwd)/envvars-cloudadmin.txt":/envvars.txt:ro \
  gcr.io/cluster-api-provider-vsphere/release/manifests:latest \
  -c workload-cluster-03 -f

  # Apply cluster config
  kubectl apply -f ./out/workload-cluster-03/cluster.yaml -f ./out/workload-cluster-03/controlplane.yaml -f ./out/workload-cluster-03/machinedeployment.yaml


# Get kubeconfig
kubectl get secret workload-cluster-03-kubeconfig -o=jsonpath='{.data.value}' | { base64 -d 2>/dev/null || base64 -D; } >./out/workload-cluster-03/kubeconfig
kubectl get secret workload-cluster-01-kubeconfig -o=jsonpath='{.data.value}' | { base64 -d 2>/dev/null || base64 -D; } >./out/workload-cluster-01/kubeconfig

# Apply the addons
## Change kubeconfig
export KUBECONFIG=./out/workload-cluster-01/kubeconfig

## apply addons
kubectl apply -f ./out/workload-cluster-01/addons.yaml