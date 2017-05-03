#!/bin/bash
echo -e "*****************************************"
echo -e "*   This script is written by Suhas G   *"
echo -e "*           gsuhas@vmware.com           *"
echo -e "*****************************************"
echo -e "This Script Deploys vSphere Data Protection"
echo -e "\nDownloading govc for Linux"
curl -L https://github.com/vmware/govmomi/releases/download/v0.5.0/govc_linux_386.gz | gunzip -d > /usr/local/bin/govc
chmod +x /usr/local/bin/govc
echo -e "\nThe version of govc is"
govc version
echo -e "\nEnter the requested details"
read -p "Specify vCenter FQDN or IP Address: " GOVC_URL_a
read -p "Specify administrator username: " GOVC_USERNAME_a
read -p "Specify the password: " GOVC_PASSWORD_a
read -p "Specify the Datastore name: " GOVC_DATASTORE_a
read -p "Specify Network Portgroup: " GOVC_NETWORK_a
read -p "If needed Specify resource pool name: " GOVC_RESOURCE_POOL_a

export GOVC_INSECURE=1
export GOVC_URL=$GOVC_URL_a
export GOVC_USERNAME=$GOVC_USERNAME_a
export GOVC_PASSWORD=$GOVC_PASSWORD_a
export GOVC_DATASTORE=$GOVC_DATASTORE_a
export GOVC_NETWORK=$GOVC_NETWORK_a
export GOVC_RESOURCE_POOL=$GOVC_RESOURCE_POOL_a

echo -e "\n\nThe JSON Specification file is as below"
echo -e "Edit the file to enter your deployment details\n"
sleep 5
govc import.spec /vSphereDataProtection-6.1.3.ova | python -m json.tool
govc import.spec /vSphereDataProtection-6.1.3.ova | python -m json.tool > /vdp.json
vi /vdp.json
echo -e "Deploying VDP\n"
govc import.ova -options=/vdp.json /vSphereDataProtection-6.1.3.ova
echo "\n\nDeployment Complete. All Done!"
