<cfinclude template="coverage-check.cfm" >

<cfparam name="url.sortColumn" default="1">
<cfparam name="url.order" default="ASC">
<cfset opositeOrder = "DESC">
<cfif url.order eq "DESC">
	<cfset opositeOrder = "ASC">
</cfif>

<cfset arrCFPageCoverages = coverageTool.listCFPageCoverages()>
<cfset totalLinesCovered = 0 >
<cfset totalLinesVisited = 0 >

<cfset qPages = queryNew("filename,linesCovered,linesVisited,percentage,filepath")>

<cfloop array="#arrCFPageCoverages#" index="page">
	<cfset totalLinesCovered += page.getCoveredLineCount() >
	<cfset totalLinesVisited += page.getVisitedLineCount() >
	<!--- fill in qPages query --->
	<cfset queryAddRow(qPages)>
	<cfset querySetCell(qPages,"filename",getFileFromPath(page.getTemplatePath()))>	
	<cfset querySetCell(qPages,"filepath",page.getTemplatePath())>
	<cfset querySetCell(qPages,"linesCovered",page.getCoveredLineCount())>
	<cfset querySetCell(qPages,"linesVisited",page.getVisitedLineCount())>
	<cfset querySetCell(qPages,"percentage",page.getVisitedPercentage())>
</cfloop>

<cfquery name="qPages" dbtype="query">
	SELECT *
	FROM qPages
	ORDER BY <cfqueryparam cfsqltype="cf_sql_integer" value="#url.sortColumn#"> <cfif url.order eq "desc">DESC</cfif>
</cfquery>

<cfif totalLinesCovered gt 0 >
	<cfset totalPercentage = round( 100 * totalLinesVisited / totalLinesCovered )>
<cfelse>
	<cfset totalPercentage = 100 >
</cfif>

<html>
<head>
	<title>CF Metrics - code coverage</title>
	<script type="text/javascript">
		function confirmReset(){
			return window.confirm("Do you want to reset statistics for all templates?");
		}
	</script>
</head>
<style type="text/css">
	body {
		margin: 0px;
		font-family: Lucida Console;
		font-size: 12px;
	}
	.header {
		padding: 5px;
		background-color: #c2e1f4;
		border-bottom: 2px solid #90c8ec;
	}
	.container table {
		font-size: 12px;
		margin: 5px;
	}
	.percentage {
		font-size: 30px;
	}
</style>

<body>
	
<cfoutput>
	<div class="header">
		<p>
			<span class="percentage">#totalPercentage#%</span> total coverage
		</p>
		<form action="coverage-statistics-action.cfm" method="get">
			<input type="submit" name="action" value="refresh" title="Refresh current page"/>
			<input type="submit" name="action" value="reset" onclick="confirmReset();" title="Reset statistics for all templates" />
		</form>
	</div>
	<div class="container">
		<cftable query="qPages" htmltable="true" colHeaders="true">
			<cfcol header='<a href="?sortColumn=1&order=#opositeOrder#">File Name [-]</a>' text='<a href="coverage-details.cfm?templatePath=#qPages.filepath#" title="#qPages.filepath#">#qPages.filename#</a>'>
			<cfcol header='<a href="?sortColumn=2&order=#opositeOrder#">Lines Covered [##]</a>' text="#qPages.linesCovered#">
			<cfcol header='<a href="?sortColumn=3&order=#opositeOrder#">Lines Visited [##]</a>' text="#qPages.linesVisited#">
			<cfcol header='<a href="?sortColumn=4&order=#opositeOrder#">Code Coverage [%]</a>' text="#qPages.percentage#">
			<cfcol header='<a href="?sortColumn=5&order=#opositeOrder#">Path [-]</a>' text="#qPages.filepath#">
		</cftable>
	</div>
</cfoutput>

</body>
</html>