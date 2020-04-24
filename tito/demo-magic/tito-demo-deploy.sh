#!/usr/bin/env bash

########################
# include the magic
########################
. ./demo-magic.sh


########################
# Configure the options
########################

#
# speed at which to simulate typing. bigger num = faster
#
# TYPE_SPEED=20

#
# custom prompt
#
# see http://www.tldp.org/HOWTO/Bash-Prompt-HOWTO/bash-prompt-escape-sequences.html for escape sequences
#
DEMO_PROMPT="${GREEN}➜ ${CYAN}\W "

# hide the evidence
clear


# Export Workload Cluster kubeconfig
pe "cd /home/ubuntu/clusterapi/demo"
pe "export KUBECONFIG=/home/ubuntu/clusterapi/out/workload-cluster-01/kubeconfig"

# check if the cluster is healthy and show in VMC (Showing a "Ready" status)
pe "kubectl get nodes"

# Show Cluster Networking integration
pe " kubectl get pods -n=default"

# Show Cluster Storage integration
pe "kubectl get pvc --all-namespaces"

# show the new LB for the app
pe "cat tito-lb.yaml"
pe "kubectl apply -f tito-lb.yaml"

# show the deployment of the app and apply it
pe "cat tito-deployment.yaml"
pe "kubectl apply -f tito-deployment.yaml"

# check the state of the deployment:
pe "kubectl get deploy -n tito-app"
pe "kubectl get svc -n tito-app"

# show the pods which have been created by our deployment - we filter them by their label "vmc-nginx". You will notice that each pod got it´s own IP by our overlay-network (Calico). This is K8s internal networking and not accessible from the outside.
pe "kubectl get pods -o wide -n tito-app"


# Switch the DNS on the DC to the right IP, shutdown the VM
p "looks good? Let´s adjust the DNS"

# Scale the Deployment up
pe "kubectl scale deployment titofe --replicas=10 -n tito-app"
pe "kubectl get pods -o wide -n tito-app"

# cleanup the stuff
pe "kubectl delete ns tito-app"

# show a prompt so as not to reveal our true nature after
# the demo has concluded
p ""
