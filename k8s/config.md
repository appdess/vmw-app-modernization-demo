

# Bootstrap with scripts

# CPOD Config

# normal cluster
docker run --rm \
  -v "$(pwd)":/out \
  -v "$(pwd)/envvars.txt":/envvars.txt:ro \
  gcr.io/cluster-api-provider-vsphere/release/manifests:latest \
  -c workload-cluster-02

kubectl apply -f ./out/workload-cluster-02/cluster.yaml -f ./out/workload-cluster-02/controlplane.yaml -f ./out/workload-cluster-02/machinedeployment.yaml

# non priviledged cluster
docker run --rm \
  -v "$(pwd)":/out \
  -v "$(pwd)/envvars.txt":/envvars1.txt:ro \
  gcr.io/cluster-api-provider-vsphere/release/manifests:latest \
  -c cloudadmin-cluster-03

kubectl apply -f ./out/workload-


# Export kubeconfig
sudo cp /etc/kubernetes/admin.conf $HOME/
sudo chown $(id -u):$(id -g) $HOME/admin.conf
export KUBECONFIG=$HOME/admin.conf


# CSI-Config
vmware@adess-jh:~/deploy/k8s-automation$ govc vm.upgrade -version=15 -vm pks-master01
vmware@adess-jh:~/deploy/k8s-automation$ govc vm.upgrade -version=15 -vm pks-worker02
vmware@adess-jh:~/deploy/k8s-automation$ govc vm.upgrade -version=15 -vm pks-worker03
vmware@adess-jh:~/deploy/k8s-automation$ govc vm.change -e="disk.enableUUID=1" -vm pks-master01
vmware@adess-jh:~/deploy/k8s-automation$ govc vm.change -e="disk.enableUUID=1" -vm pks-worker02
vmware@adess-jh:~/deploy/k8s-automation$ govc vm.change -e="disk.enableUUID=1" -vm pks-worker03

 sudo kubeadm upgrade apply --config kube-upgrade.yaml

kubeadm upgrade apply --config upgrade.yaml
apiVersion: kubeadm.k8s.io/v1beta1
kind: ClusterConfiguration
imageRepository: vmware
kubernetesVersion: v1.15.1+vmware.1
networking:
    podSubnet: "192.168.0.0/16"
kind: InitConfiguration
kubeletExtraArgs:
    cloud-provider: external