module github.com/kubism/backup-operator

go 1.13

require (
	github.com/aws/aws-sdk-go v1.34.28
	github.com/go-logr/logr v0.1.0
	github.com/go-logr/zapr v0.1.0
	github.com/hashicorp/consul/api v1.4.0
	github.com/mongodb/mongo-tools v0.0.0-20210520195542-5af948c84abe
	github.com/onsi/ginkgo v1.11.0
	github.com/onsi/gomega v1.8.1
	github.com/ory/dockertest/v3 v3.6.0
	github.com/prometheus/client_golang v1.2.0
	github.com/spf13/cobra v0.0.5
	go.mongodb.org/mongo-driver v1.5.1
	go.uber.org/zap v1.10.0
	golang.org/x/sync v0.0.0-20190911185100-cd5d95a43a6e
	k8s.io/api v0.17.2
	k8s.io/apimachinery v0.17.2
	k8s.io/client-go v0.17.2
	sigs.k8s.io/controller-runtime v0.5.0
)
