#Terraform Azure

This project deploys Ubuntu virtual machine in azure with Ubuntu 18.04-LTS image. 

Change the Image as required. 

This uses azure service principal to login to azure. Use the command below to create a service principal with azure CLI.

az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/<subscription_id>"

You can refer the following link for azure service principal creation. https://docs.microsoft.com/en-us/azure/developer/terraform/get-started-cloud-shell

Refer the following links for detailed description.

https://aka.ms/citadel/terraform

https://aka.ms/terraform

terraform init terraform plan terraform apply terraform destroy (To delete )