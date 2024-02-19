.MAIN: init

init:
	cd k3d-cluster
	terraform init
	terraform apply --auto-approve
	cd ..
	cd rancher
	terraform init
	terraform apply --auto-approve

destroy:
	cd rancher
	terraform destroy --auto-approve
	cd ..
	cd k3d-cluster
	terraform destroy --auto-approve