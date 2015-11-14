
# Code Coverage for Adobe ColdFusion
If you're looking for an easy-to-use ColdFusion? code-coverage tool for your CFM or CFC templates then you found it!

The aim of this project is to provide a set of tools which can be used to measure various statistics for your Cold Fusion application. In the initial version a code coverage possibilities were introduced.

# Features
- CFC components and CFM templates are covered
- Cold Fusion 8, 9, 10, 11 supported
- *cfscript* tag with it's content is supported
- small footprint on the template execution
- generated JAVA classes size is increased by 5% on average
- no manual code instrumentation is required
- easy to deploy and use (single JAR)

# How does this work?
Code Coverage statistics are enabled by deploying a single JAR file into the /lib/updates directory of your Cold Fusion server as any other Adobe(R) patch file.

# Installation
In the past cf-metrics.jar was available for download for various version of Cold Fusion engine. The best is to prepare the patch JAR with desired JAVA & CF version on your own to make it sure it will run on your environment without any troubles. 

## Building on your own
### Project structure
cf-metrics consists of two modules:
* cf-code-coverage - contains aspects and helper classes for preparing Adobe ColdFusion? patch (JAR)
* cf-client - a CFML client for presenting code coverage statistics

### Building the project
First you need to prepare a patch JAR that is going to be placed inside Cold Fusion "lib/updates" directory.

1. edit the pom.xml of cf-code-coverage module
2. set the "cfusion.version" property to a proper value (e.g. 11)
3. set the "cfusion.jar.location" property (must point to a cfusion.jar location of your local Cold Fusion distribution)
4. set the "java.version" and specify Java version to use for compilation (e.g. 7)
5. build the maven project `mvn clean package`

### Deploying the JAR file
Once build the patch JAR should be put into "{cf_fusion.dir}/lib/updates" directory. Restart the server and code coverage should be enabled since now on. You should be able to see the following line in a server logs during startup: `ColdFusion Code Coverage enabled". That's it!

Note:
Be aware that if you're using **"Trusted cache"** or **"Save class files"** then you have to navigate to your administration panel and make use of the **"Clear Template Cache Now"** button. This is required as the CFM templates got instrumented the moment they are transformed into JAVA.

![alt tag](http://wiki.cf-metrics.googlecode.com/git/images/cf-admin-trusted-cache.png)

Cleaning the compiled templates cache can be also done manually by removing all content from {cf_server.dir}/wwwroot/WEB-INF/cfclasses directory.

### CF statistics viewer
The tool comes with simple GUI written in Cold Fusion. I admit it's not pretty but can be used right away to view your code coverage statistics from the same server it's hosted on. The files are present in the "cf-client" project module. You can copy them to a directory of our choice (of course visible to the CF server).

# Example Visualization
Example visualization of the gathered code coverage statistics is present below.

## General overview of code coverage client
![alt tag](http://wiki.cf-metrics.googlecode.com/git/images/coverage-visualization-global.png)

## Details code coverage statistics for a particular file
![alt tag](http://wiki.cf-metrics.googlecode.com/git/images/coverage-visualization-file.png)

## Code coverage of cfscript block
![alt tag](http://wiki.cf-metrics.googlecode.com/git/images/coverage-visualization-cfscript.png)

Once a file is requested and processed by a Cold Fusion engine Code Coverage statistics are recorded. They can be accessed later on via singleton instance of a TemplateCoverageTool (statistics collector class). Any desired visualization can be applied to it afterwards. A default ColdFusion statistics viewer (written in CFML) is provided as a side project.
