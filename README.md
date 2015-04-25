
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

Once a file is requested and processed by a Cold Fusion engine Code Coverage statistics are recorded. They can be accessed later on via singleton instance of a TemplateCoverageTool (statistics collector class). Any desired visualization can be applied to it afterwards. A default ColdFusion statistics viewer (written in CFML) is provided as a side project.
