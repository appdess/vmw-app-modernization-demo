
Create files:
docker run --rm \
  -v "$(pwd)":/out \
  -v "$(pwd)/envvars.txt":/envvars.txt:ro \
  gcr.io/cluster-api-provider-vsphere/release/manifests:latest \
  -c workload-cluster-04


  # Export kubeconfig to mgmt-cluster
  export KUBECONFIG=./out/management-cluster/kubeconfig

  # apply files
  kubectl apply -f ./out/workload-cluster-05/cluster.yaml -f ./out/workload-cluster-05/controlplane.yaml -f ./out/workload-cluster-05/machinedeployment.yaml

  kubectl get secret workload-cluster-04-kubeconfig -o=jsonpath='{.data.value}' | { base64 -d 2>/dev/null || base64 -D; } >./out/workload-cluster-04/kubeconfig

    kubectl get secret workload-cluster-05-kubeconfig -o=jsonpath='{.data.value}' | { base64 -d 2>/dev/null || base64 -D; } >./out/workload-cluster-05/kubeconfig

export KUBECONFIG=./out/workload-cluster-04/kubeconfig
kubectl apply -f ./out/workload-cluster-04/addons.yaml

export KUBECONFIG=./out/workload-cluster-05/kubeconfig
kubectl apply -f ./out/workload-cluster-05/addons.yaml


# with 02:
docker run --rm \
  -v "$(pwd)":/out \
  -v "$(pwd)/envvars.txt":/envvars.txt:ro \
  gcr.io/cluster-api-provider-vsphere/release/manifests:latest \
  -c workload-cluster-02

    kubectl apply -f ./out/workload-cluster-02/cluster.yaml -f ./out/workload-cluster-02/controlplane.yaml -f ./out/workload-cluster-02/machinedeployment.yaml







### Create Kind Cluster:
kind create cluster --name clusterapiexport KUBECONFIG="$(kind get kubeconfig-path --name="clusterapi")"
kubectl create -f https://github.com/kubernetes-sigs/cluster-api/releases/download/v0.2.3/cluster-api-components.yaml
kubectl create -f https://github.com/kubernetes-sigs/cluster-api-bootstrap-provider-kubeadm/releases/download/v0.1.1/bootstrap-components.yaml

### vSphere Infrastructure Components
kubectl create -f  https://github.com/kubernetes-sigs/cluster-api-provider-vsphere/releases/download/v0.5.2-beta.1/infrastructure-components.yaml
Kubectl apply -f infrastructure-components.yaml 

### Apply the secrets file
apiVersion: v1
stringData:
password: VMware1!
username: administrator@vsphere.local
kind: Secret
metadata:
name: capv-manager-bootstrap-credentials
namespace: capv-system
type: Opaque

        Kubectl apply infra-secrets.yaml


Downlaod the envvars.txt file from here https://github.com/kubernetes-sigs/cluster-api-provider-vsphere/blob/master/docs/getting_started.md
Update the envvars.txt file with valuses from the vcenter server

docker run --rm -v "$(pwd)":/out -v "$(pwd)/envvars.txt":/envvars.txt:ro gcr.io/cluster-api-provider-vsphere/release/manifests:v0.5.1 -c workload-cluster-1 -f

 kubectl apply -f out/management-cluster/cluster.yaml 
 kubectl apply -f out/management-cluster/controlplane.yaml 

# Check the machines for provisioning till state is running
kubectl get machines

        NAME                                PROVIDERID                                       PHASE
        management-cluster-controlplane-0   vsphere://4225f500-01fd-1150-71c6-dce7b19fbddb   running
        workload-cluster-2-controlplane-0   vsphere://4225e31d-c31c-ade2-917d-ac507ecfce20   running


# Get the Kubeconfig of the target cluster
kubectl --namespace=default get secret/workload-cluster-3-kubeconfig -o json   | jq -r .data.value   | base64 --decode   > ./capv-cluster3.kubeconfig


# Apply CNI on the target cluster
kubectl --kubeconfig capv-cluster3.kubeconfig apply -f out/workload-cluster-3/addons.yaml

# Create worker nodes - your Management cluster takes care ;)
 kubectl apply -f out/workload-cluster-3/machinedeployment.yaml

# Export Kubeconfig if wanted:
export KUBECONFIG=./capv-cluster3.kubeconfig

# Default Kubeconfig for Kind (to reset)
export KUBECONFIG=/home/ubuntu/.kube/kind-config-clusterapiexport

# CSI-Setup

### Delete standard SC
kubectl delete sc --all

