# Terraform AZURE
This project deploys virtual network with subnets, network security groups and VPN Gateway.
Virtual network, subnets and network security groups can be customized.
This uses azure service principal to login to azure. Use the command below to create a service principal with azure CLI.

az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/<subscription_id>"

You can refer the following link for azure service principal creation. 
 https://docs.microsoft.com/en-us/azure/developer/terraform/get-started-cloud-shell

Refer the following links for detailed description.
 
 
 https://aka.ms/citadel/terraform

 https://aka.ms/terraform
 
 terraform init
 terraform plan
 terraform apply
 terraform destroy (To delete )
