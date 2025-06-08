# Examples of Ephemeral Access Extension Plugin for Service Now

This directory contains some examples that might help you when you either want
to use the plugin or when you want to test or enhance the plugin.

## Use of the plugin

In the beginning it might be hard to understand which manifests should be
created to get your implementation working. For this goal, I created two
examples:

### AWS example

This example will deploy a three node Kubernetes cluster, with ArgoCD and the
plugin installed, on AWS.

### Kubernetes ephemeral access extension

In this directory you will find a complete explaination of the Ephemeral Access
Extension (without the plugin).

## Test or enhance the plugin

I'm using CloudFormation templates to test or enhance the plugin. You can find
more information in [this README.md](./dev-and-test-of-plugin/README.md) in the
dev-and-test-of-plugin directory.