.MAIN: init

init:
	cd k3d-cluster && terraform init
	cd k3d-cluster && terraform apply --auto-approve
	kubectl apply -f rancher/rancher.yaml
	cd rancher && terraform init
	cd rancher && terraform apply --auto-approve

cluster-init:
	cd k3d-cluster && terraform init
	cd k3d-cluster && terraform apply --auto-approve

rancher-init:
	kubectl apply -f rancher/rancher.yaml
	cd rancher && terraform init
	cd rancher && terraform apply --auto-approve

destroy:
	kubectl delete namespace cattle-system
	cd k3d-cluster && terraform destroy --auto-approve