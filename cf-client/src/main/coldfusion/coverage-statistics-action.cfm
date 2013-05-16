<cfinclude template="coverage-check.cfm" >

<cfif structKeyExists(url,"action") >
	<cfif url.action eq "reset">
		<cfset coverageTool.resetStatistics() >
	</cfif>
	<cflocation url="coverage-statistics.cfm" />
</cfif>