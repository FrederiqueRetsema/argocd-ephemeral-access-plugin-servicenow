# ArgoCD Ephemeral Access Plugin for ServiceNow

[![argocd-ephemeral-access-plugin-servicenow](https://github.com/FrederiqueRetsema/argocd-ephemeral-access-plugin-servicenow/actions/workflows/merge-to-main.yml/badge.svg)](https://github.com/FrederiqueRetsema/argocd-ephemeral-access-plugin-servicenow/actions/workflows/merge-to-main.yml)
[![Go Coverage](https://github.com/frederiqueretsema/argocd-ephemeral-access-plugin-servicenow/wiki/coverage.svg)](https://raw.githack.com/wiki/frederiqueretsema/argocd-ephemeral-access-plugin-servicenow/coverage.html)

## Overview

This plugin provides the connection between the Ephemeral Access Extension
(<https://github.com/argoproj-labs/argocd-ephemeral-access>) and ServiceNow.
The plugin is developed using version v0.1.6 of the extension.

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

When the access is granted a note is created as part of the change in
ServiceNow. In this way, users of ServiceNow can see who got access to deal
with the change.

### Exclusion roles

When the ServiceNow API is not responding or when there is a big incident
that requires fast response, it might be useful to have a "work around" for
a limited number of employees. These employees can be part of a special
exclusion role.

When access is granted based on an exclusion role, a warning will be sent
to the logs.

## Installation
