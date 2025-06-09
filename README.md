# ArgoCD Ephemeral Access Plugin for ServiceNow

[![argocd-ephemeral-access-plugin-servicenow](https://github.com/FrederiqueRetsema/argocd-ephemeral-access-plugin-servicenow/actions/workflows/merge-to-main.yml/badge.svg)](https://github.com/FrederiqueRetsema/argocd-ephemeral-access-plugin-servicenow/actions/workflows/merge-to-main.yml)
[![Go Coverage](https://github.com/frederiqueretsema/argocd-ephemeral-access-plugin-servicenow/wiki/coverage.svg)](https://raw.githack.com/wiki/frederiqueretsema/argocd-ephemeral-access-plugin-servicenow/coverage.html)

## Overview

The Ephemeral Access Extension
(<https://github.com/argoproj-labs/argocd-ephemeral-access>) is an add-on to
ArgoCD, which helps to implement least-privileged access control. Users of
ArgoCD can use read-only permissions by default, and then request more
permissions if they need to. The way permissions are processed is determined
by the plugin that is used.

This plugin provides the connection between the Ephemeral Access Extension
and ServiceNow. The plugin is developed using version v0.1.6 of the extension
and the Yokohama version of ServiceNow.

When a user does a request for more permissions, the plugin will connect to
ServiceNow. It checks the validity of the CI that is connected to the
application. When the CI is valid, the plugin will search for relevant changes.
When the change is found, the access will be granted. When no valid changes are
found, then the request will be denied.

### Valid CIs

A CI is valid, when the state of the CI is `Installed`, `In maintenance`,
`Pending install` or `Pending repair`.

### Valid changes

A change is valid, when the current date and time is within the range of the
start date and the end date. Apart from that, the change should have the
following properties:

* The state should be `Implement`
* The phase should be `Requested`
* The change should be `Approved`
* The change should be `Active`

To speed up the search of the ServiceNow API, both the start date and the end
date should be within (by default) one week. So when there is a valid change
from 1-1-2025 to 31-12-2025 and the current date is 31-05-2025, this change
will not be found by the plugin.

### Information in ServiceNow

When the access is granted, a note is created as part of the change in
ServiceNow. In this way, users of ServiceNow can see who got access to deal
with the change.

### Exclusion roles

When the ServiceNow API is not responding or when there is a big incident
that requires fast response, it might be useful to have a "work around" for
a limited number of employees. These employees can be part of a special
exclusion role.

When access is granted based on an exclusion role, a warning will be sent
to the logs.

## Demo

<video width="3200" controls>
  <source src="https://frpublic2.s3.eu-west-1.amazonaws.com/persoonlijk/ephemeral-access-extension-plugin-for-servicenow.mp4" type="video/mp4">
</video>

## Installation

## Versioning

### Patch releases: for example v0.0.0 to v0.0.1

We are using Renovate for automatically receiving updates of go modules etc.
This means that when the last number of a version is changing (f.e.
v0.0.0 to v0.0.1) then no other changes than updating versions took place.

### Minor releases: for example v0.0.0 to v0.1.0

When the plugin itself changes, for example when the Ephemeral Access
Extension releases a new version where this plugin can get rid of work
arounds, then a new minor release will be created.

### Major releases: for example v0.0.0 to v1.0.0

When the plugin changes with breaking changes (f.e. when configuration
currently is in environment variables, but in a new release the same
configuration is in a configmap), then the version will bump with a major
release number.

Please mind, that bumping up a major release number doesn't say anything
about the amount of changes, or the amount of changed functionality that
is in the release

### No version changes for documentation

When documentation or demo code is changed and the plugin itself
remains the same, then the version number is not changed.
