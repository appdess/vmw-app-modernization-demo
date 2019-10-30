# Datacenter Migration
- CommuteAnalytics needs to move out of the Datacenter and decides to migrate to VMC after successful POC
- VMware HCX was deployed in the on-prem environment to move their workloads Hybridity for Workloads and therefore the VMs will be moved


- The Company is facing issue with the availability of their applicaitons during peak times

# Show Essential PKS Cluster Setup on VMC
- The VMs are now fully migrated to the cloud and serving the website (DNS Entry for frontend!)
- Due to Scalability and upgrade problems a refactoring of the applciation will be done
    - The Frontend will be modernized to run in K8s
    - The Backend will stay as Database VM
- We created our containers
- We create our service in K8s 
- Now all we have to do is to change the DNS record to point to the NEW K8s Loadbalancer
    - The application is now served from K8s completly and we can shutdown the VM

- Do a scaling of the application


- Explain the deep integration with VMC (CSI and AVI Loadbalancing)

# Show VMC and the Cluster Setup


# Show the AVI Load-Balancing integration

# Edit hosts file to point to IP
10.72.30.31     CommuteAnalytics.com
sudo killall -HUP mDNSResponder




# Make use of K8s termonoligy and use the Autoscaler for the deployment

kubectl autoscale deployment titofe --cpu-percent=50 --min=1 --max=10

kubectl scale deployment titofe --replicas=10


# Start load-Testing to K8s
 siege -r 10000 http://172.30.118.239:80

