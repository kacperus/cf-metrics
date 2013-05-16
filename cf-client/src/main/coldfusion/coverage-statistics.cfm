<cfinclude template="coverage-check.cfm" >

<cfparam name="url.sortColumn" default="1">

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
	ORDER BY <cfqueryparam cfsqltype="cf_sql_integer" value="#url.sortColumn#">
</cfquery>

<cfif totalLinesCovered gt 0 >
	<cfset totalPercentage = round( 100 * totalLinesVisited / totalLinesCovered )>
<cfelse>
	<cfset totalPercentage = 100 >
</cfif>

<html>
<head>
	<title>CF Template code coverage</title>
	<script type="text/javascript" src="http://bernii.github.com/gauge.js/dist/gauge.min.js"></script>
	<script type="text/javascript">
		function confirmReset(){
			return window.confirm("Do you want to reset statistics for all templates?");
		}
	</script>
</head>
<style type="text/css">
	.percentage {
		font-size: 30px;
	}
	#gauge_canvas {
		width: 200px;
		height: 100px;
	}
</style>

<body>
	
<cfoutput>
	<p>
		<canvas id="gauge_canvas"></canvas>
		<span class="percentage">#totalPercentage#% covered</span>
	</p>
	<hr/>
		<form action="coverage-statistics-action.cfm" method="get">
			<input type="submit" name="action" value="refresh" title="Refresh current page"/>
			<input type="submit" name="action" value="reset" onclick="confirmReset();" title="Reset statistics for all templates" />
		</form>
	<hr/>
	<div id="container">
	
	<cftable query="qPages" htmltable="true" colHeaders="true">
		<cfcol header='<a href="?sortColumn=1">File Name [-]</a>' text='<a href="coverage-details.cfm?templatePath=#qPages.filepath#" title="#qPages.filepath#">#qPages.filename#</a>'>
		<cfcol header='<a href="?sortColumn=2">Lines Covered [##]</a>' text="#qPages.linesCovered#">
		<cfcol header='<a href="?sortColumn=3">Lines Visited [##]</a>' text="#qPages.linesVisited#">
		<cfcol header='<a href="?sortColumn=4">Code Coverage [%]</a>' text="#qPages.percentage#">
	</cftable>

	</div>
	<script type="text/javascript">
		var opts = {
  			lines: 12, // The number of lines to draw
	  		angle: 0, // The length of each line
			lineWidth: 0.34, // The line thickness
			pointer: {
			    length: 0.86, // The radius of the inner circle
			    strokeWidth: 0.053, // The rotation offset
			    color: '##000000' // Fill color
			},
			colorStart: '##ff0000',   // Colors
			colorStop: '##00ff00',    // just experiment with them
			strokeColor: '##E0E0E0',   // to see which ones work best for you
			generateGradient: true
		};
		var target = document.getElementById('gauge_canvas'); // your canvas element
		var gauge = new Gauge(target).setOptions(opts); // create sexy gauge!
		gauge.maxValue = #totalLinesCovered#; // set max gauge value
		gauge.animationSpeed = 32; // set animation speed (32 is default value)
		gauge.set(#totalLinesVisited#); // set actual value
	</script>
	
</cfoutput>

</body>
</html>