
# tf:init is terraform init
.PHONY: init
init:
	@terraform init -var="vars.tfvars" -backend-config="backend/wireguard.conf"

clean:
	rm -rf .terraform
.PHONY: clean

plan:
	@terraform plan -out plan.out
.PHONEY: plan

build: clean init plan
.PHONEY: build

apply:
	@terraform apply -auto-approve -input=false plan.out
