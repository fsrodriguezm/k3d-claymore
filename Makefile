.MAIN: init

init:
	cd k3d-cluster && terraform init
	cd k3d-cluster && terraform apply --auto-approve
	cd rancher && terraform init
	cd rancher && terraform apply --auto-approve

cluster-init:
	cd k3d-cluster && terraform init
	cd k3d-cluster && terraform apply --auto-approve

rancher-init:
	cd rancher && terraform init
	cd rancher && terraform apply --auto-approve

destroy:
	cd k3d-cluster && terraform destroy --auto-approve