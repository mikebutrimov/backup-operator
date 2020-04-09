module github.com/kubism-io/backup-operator

go 1.13

require (
	github.com/go-logr/logr v0.1.0
	github.com/go-logr/zapr v0.1.0
	github.com/golang/snappy v0.0.1 // indirect
	github.com/jessevdk/go-flags v1.4.0 // indirect
	github.com/mongodb/mongo-tools v0.0.0-20200227185201-f8447b92a52f
	github.com/mongodb/mongo-tools-common v2.0.3+incompatible
	github.com/onsi/ginkgo v1.11.0
	github.com/onsi/gomega v1.8.1
	github.com/ory/dockertest/v3 v3.5.5
	github.com/xdg/scram v0.0.0-20180814205039-7eeb5667e42c // indirect
	github.com/xdg/stringprep v1.0.0 // indirect
	go.mongodb.org/mongo-driver v1.3.2
	go.uber.org/zap v1.10.0
	k8s.io/api v0.17.2
	k8s.io/apimachinery v0.17.2
	k8s.io/client-go v0.17.2
	sigs.k8s.io/controller-runtime v0.5.0
)
