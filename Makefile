VERSION = 1.0.0
BUILD_NAMESPACE = jupyter-stacks


.PHONY: create_namespaces
create_namespaces:
	oc new-project ${BUILD_NAMESPACE}

.PHONY: prepare_build
prepare_build:
	oc apply -f builder/image_streams.yaml -n openshift
	oc apply -f builder/base_notebook.yaml -n ${BUILD_NAMESPACE}

.PHONY: config_build
config_build:
	oc policy add-role-to-user system:image-builder \
		system:serviceaccount:${BUILD_NAMESPACE}:builder \
		--namespace=openshift

.PHONY: base-notebook-local
base-notebook-local:
	cd base-notebook && podman build -t jupyter-stacks/base-notebook:${VERSION} .


.PHONY: cleanup
cleanup:
	oc delete build --all -n ${BUILD_NAMESPACE}
	#oc delete pipelineruns --all -n ${BUILD_NAMESPACE}
	oc delete pod --field-selector=status.phase==Succeeded -n ${BUILD_NAMESPACE}
	oc delete pod --field-selector=status.phase==Succeeded -n ${BUILD_NAMESPACE}