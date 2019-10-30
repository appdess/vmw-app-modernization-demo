#!/bin/bash

export GOVC_INSECURE=1 # Don't verify SSL certs on vCenter
export GOVC_URL=https://vcenter.sddc-52-24-216-61.vmwarevmc.com/sdk # vCenter IP/FQDN
export GOVC_USERNAME=administrator@vmc.local # vCenter username
export GOVC_PASSWORD=XXXXXXX # vCenter password
export GOVC_DATASTORE=WorkloadDatastore # Default datastore to deploy to
export GOVC_NETWORK=Corp # Default network to deploy to
export GOVC_RESOURCE_POOL=/SDDC-Datacenter/host/Cluster-1/Resources/Compute-ResourcePool # Default resource pool to deploy t
export GOVC_FOLDER=adess



#!/bin/bash

export GOVC_INSECURE=1 # Don't verify SSL certs on vCenter
export GOVC_URL=https://vcenter.sddc-52-24-216-61.vmwarevmc.com/sdk # vCenter IP/FQDN
export GOVC_USERNAME=cloudadmin@vmc.local # vCenter username
export GOVC_PASSWORD=XXXXXXX # vCenter password
export GOVC_DATASTORE=WorkloadDatastore # Default datastore to deploy to
export GOVC_NETWORK=Corp # Default network to deploy to
export GOVC_RESOURCE_POOL=/SDDC-Datacenter/host/Cluster-1/Resources/Compute-ResourcePool # Default resource pool to deploy t
export GOVC_FOLDER=adess