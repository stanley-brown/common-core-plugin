# Common Core Plugin
This plugin is intended to be used by other applications or templates in order to facilitate logging and a global error handler.  It needs to be deployed to either Anypoint Exchange or some other artifact repository.  From there, applications and templates can access the flows used within it to quickly and easily perform log operations.  Main entry points to integrations can use the global error handler when non-specific error capture and handling is preferred.  

## How To Deploy to Anypoint Exchange
To deploy the plugin to a target business group's or organization's Exchange, you will need to modify the pom.xml file "groupId" and replace it with the target UUID for the target. 


 These can be found in Anypoint Access Management.  After modifing and saving the changes to the pom, execute the following Apache Maven command:

```
mvn clean deploy
```

After executing the command ensure that "Common Core Plugin" is visible with the target org or business group.

Note that a settings.xml file will need to include a reference to the repository in exchange like such:



## How To Include In Application or Template
To include the plugin in to an application or template, there are several steps that must occur.

First, the pom.xml will need to add a depedency to the plugin:
```
<dependency>
	<groupId>${project.groupId}</groupId>
	<artifactId>common-core-plugin</artifactId>
	<version>${common.core.plugin.version}</version>
	<classifier>mule-plugin</classifier>
</dependency>
```

Second, the pom.xml must also include a reference to the target Exchange as part of its pluginRepository:


you must first add the following global imports that will make the flows within the plugin available to it:

```
<import doc:name="Import Logging Config" doc:id="a41aa308-56e2-4aae-bd77-935c98d035c9" file="logging.xml" doc:description="Imports logging flows from common-core-plugin"/>
<import doc:name="Import Error Handler Config" doc:id="e8d118a5-f1ff-4d30-8158-a5ac556c8e55" file="error-handler.xml" doc:description="Imports error handling flows from common-core-plugin"/>
```

## Logging

There are several logging endpoints to use.

log-apiStart: Use this after any API router but in the individual API endpoints.  It will log out any request attributes specified in a comma delimited list by property "log.attributes".  By using this it is possible to output HTTP incoming properties.

log-apiEnd: Simply used to log the end of the API.  Best placed after the API router in the main API flow.  It simply logs "API End".

log-info, log-warn: Both subflows log a message with matching log category.  Setting variable "logMessage" before calling these subflows allows for custom messages.

log-error: similar to log-info and log-warn.  Will also include Mule error type and description.