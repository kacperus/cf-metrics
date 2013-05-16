<cftry>
	<cfset coverageTool = createObject("java","org.kacperus.cf.coverage.TemplateCoverageTool").getInstance()>
<cfcatch type="any">
	<p>Code Coverage Not Enabled</p>
	<cfexit>
</cfcatch>
</cftry>