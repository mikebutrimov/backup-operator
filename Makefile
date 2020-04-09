
# Image URL to use all building/pushing image targets
IMG ?= controller:latest
# Produce CRDs that do NOT work back to Kubernetes 1.11 (allows version conversion)
CRD_OPTIONS ?= "crd:trivialVersions=false"

# Get the currently used golang install path (in GOPATH/bin, unless GOBIN is set)
ifeq (,$(shell go env GOBIN))
GOBIN=$(shell go env GOPATH)/bin
else
GOBIN=$(shell go env GOBIN)
endif

KUBEBUILDER_VERSION ?= 2.3.1
KUBEBUILDER_ASSETS ?= $(shell pwd)/tools/kubebuilder_$(KUBEBUILDER_VERSION)_$(shell go env GOOS)_$(shell go env GOARCH)/bin

export

.PHONY: all test manager run install uninstall deploy manifests tools fmt vet generate docker-build docker-push controller-gen

all: manager

# Run tests
test: generate fmt vet manifests tools
	go test -v ./... -coverprofile cover.out -ginkgo.v

# Build manager binary
manager: generate fmt vet
	go build -o bin/manager ./cmd/manager/main.go

# Run against the configured Kubernetes cluster in ~/.kube/config
run: generate fmt vet manifests
	go run ./cmd/manager/main.go

# Install CRDs into a cluster
install: manifests
	kustomize build config/crd | kubectl apply -f -

# Uninstall CRDs from a cluster
uninstall: manifests
	kustomize build config/crd | kubectl delete -f -

# Deploy controller in the configured Kubernetes cluster in ~/.kube/config
deploy: manifests
	cd config/manager && kustomize edit set image controller=${IMG}
	kustomize build config/default | kubectl apply -f -

# Generate manifests e.g. CRD, RBAC etc.
manifests: controller-gen
	$(CONTROLLER_GEN) $(CRD_OPTIONS) rbac:roleName=manager-role webhook paths="./..." output:crd:artifacts:config=config/crd/bases

tools:
	@{ \
	./tools/kubebuilder > /dev/null 2>&1 || true; \
	}

# Run go fmt against code
fmt:
	go fmt ./...

# Run go vet against code
vet:
	go vet ./...

# Generate code
generate: controller-gen
	$(CONTROLLER_GEN) object:headerFile="hack/boilerplate.go.txt" paths="./..."

# Build the docker image
docker-build: test
	docker build . -t ${IMG}

# Push the docker image
docker-push:
	docker push ${IMG}

# find or download controller-gen
# download controller-gen if necessary
controller-gen:
ifeq (, $(shell which controller-gen))
	@{ \
	set -e ;\
	CONTROLLER_GEN_TMP_DIR=$$(mktemp -d) ;\
	cd $$CONTROLLER_GEN_TMP_DIR ;\
	go mod init tmp ;\
	go get sigs.k8s.io/controller-tools/cmd/controller-gen@v0.2.5 ;\
	rm -rf $$CONTROLLER_GEN_TMP_DIR ;\
	}
CONTROLLER_GEN=$(GOBIN)/controller-gen
else
CONTROLLER_GEN=$(shell which controller-gen)
endif
