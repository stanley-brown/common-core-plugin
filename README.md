## Goals
In building this API template I had several goals in mind:

1.  Use only standard Mule components.  No JSON Logger, Error Handling, or other third party components.  Non-standard components are not updated by MuleSoft and can introduce security issues or become deprecated due to updates by MuleSoft.
2.  Be generic enough for various deployment targets like CloudHub, RTF, on-prem, etc.  And do this using a standard pom that can be used with the MuleSoft Maven plugin (MMP).
3.  Include bare minimal error handling and logging including a catch-all global error handler.
4.  Base property files for the usual environments (dev,qa, and prod) along with local and common (the later is shared regardless of environment).

## Logging
To facilitate logging there is an included log config in the template.  This has several subflows for various log levels (error, info, debug) which use the standard Mule log component.  The output of the log message will be in JSON format.  The reason for this is many logging systems prefer this over any other format to allow them to easily parse the content of messages.

Along with the flow there are per environment logging settings.  This allows for per enviornment toggling if payloads are included in messages and attribute filtering.

To set a custom message for a log subflow just set the variable "logMessage" before calling one.

Customize this based on customer needs.  It is also possible to externalize the log flow in to its own dependent asset if needed.  This has its own pros and cons with keeping projects up to date.

## Error Handling
There is a default, global error handler flow located in the global config.  This immediately calls out to the logging config log-error-subFlow sub flow.  This subflow will create a JSON error message and log it out using the standard logging component with level "ERROR".

If this error is part of an HTTP API request, then the set-http-response-payload subFlow is called.  This subflow serves two purposes:

1. Create a JSON response payload to send back to the requestor.
2. Set the HTTP status code variable

This HTTP response payload consists of two elements: the HTTP response code abd textual description of the error reason.  Many of the APIKIT and HTTP errors are already handled in the dataweave script set-http-response.  The default, when no match is found, is this:
```
{
  "code": 500,
  "reason": "Server Error"
}
```

Additional or custom errors can be added by implmentors by simply adding or changing the dataweave script.

## How To Use
Before you can deploy the template to a target organzation's Anypoint Exchange (or other asset management system), you will need to update the pom.xml.  The main part to edit is the groupId at the top from "org-id-goes-here" to whatever unique identifier target org Exchange you will be deploying to.

Next you may want to set the proper deployment target being used by organization.  To do this you just need to find the deployment target section that matches (like CloudHub 2.0) and change "skip" setting to "false".  This will ensure the Mule Maven plugin uses that as the target for deployments.  For organizations with more than one deployment target you may want to either make this configurable outside the pom or create multiple templates for different deployment targets.

## Using the Template
After deploying the template to Exchange, you can use it as such:

Anypoint Studio:
1.  File->New->Project from Template.  Select the template from Exchange.
2.  A new project will be created in Studio Package Explorer.  The first thing to do is rename it to a proper name.  Right click on project name -> Refactor -> Rename.
3.  Now add an existing API to the project.  Right click on project->Manage Dependencies->Manage API.  Import an API.
4.  Run As->Mule Application (Configure).  Select the "Arugments" tab.  Add "-Danypoint.platform.gatekeeper=disabled" to the end of the VM arguments section (making sure to include space between it and last argument).  The template uses a self-signed cert to always use HTTPS instead of HTTP.


