ifeq ($(wildcard terraform.mk),)
    $(error $@: terraform.mk not found)
else
    include  terraform.mk
endif