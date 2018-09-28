APP_NAME ?= divvycloud

.PHONY: crd/install
crd/install:
	kubectl create -f crd/app-crd.yaml

.PHONY: app/install
app/install:
	helm install --name=$(APP_NAME) divvycloud

.PHONY: app/uninstall
app/uninstall:
	helm delete $(APP_NAME) --purge

.PHONE: app/upgrade
app/upgrade:
	helm upgrade $(APP_NAME) divvycloud


.PHONY: create/plugins
create/plugins:
	mkdir -p .build/plugins/
	- ( cd plugins/ && zip -r ../.build/plugins/plugins.zip *)
	- kubectl delete secret divvycloud-plugins
	- kubectl create secret generic divvycloud-plugins --from-file=.build/plugins/plugins.zip

.PHONY: clean
clean:
	rm -rf .build/plugins
