<cfinclude template="coverage-check.cfm" >

<cfif not structKeyExists(url,"templatePath")>
	<p>No file has been specified</p>
	<cfexit>
</cfif>

<cfset pageCoverage = coverageTool.getCFPageCoverage(url.templatePath)>

<cfif isDefined("pageCoverage") and structKeyExists(url,"action") >
	<cfif url.action eq "reset">
		<cfset pageCoverage.reset() >
	</cfif>
	<cfif url.action eq "timestamp">
		<cfset pageCoverage.updateLastModifiedTimestamp() >
	</cfif>
	
	<cflocation url="coverage-details.cfm?templatePath=#url.templatePath#" addToken="false" />
</cfif>