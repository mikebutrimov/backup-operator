# Backup Operator

[![Go Documentation](https://img.shields.io/badge/go-documentation-blue.svg?style=flat)](https://pkg.go.dev/mod/github.com/kubism-io/backup-operator?tab=packages)
[![Build Status](https://travis-ci.org/kubism-io/backup-operator.svg?branch=master)](https://travis-ci.org/kubism-io/backup-operator)

## Development

### Kubebuilder

This project uses a different project layout than what is generated by
kubebuilder. The layout adheres to the [golang standards](https://github.com/golang-standards/project-layout) layout.
For this to properly work a wrapper is required ([`tools/kubebuilder`](./tools/kubebuilder)),
which makes sure the correct kubebuilder version is available and temporarily
moves files around as required.

While this is certainly not beautiful, this should improve with future versions
of kubebuilder and their plugin capabilities.

#### Known quirks

* When using the kubebuilder CLI to create a new API [`main.go`](./cmd/manager/main.go)
has a wrong controllers import path and has to be fixed manually afterwards.
