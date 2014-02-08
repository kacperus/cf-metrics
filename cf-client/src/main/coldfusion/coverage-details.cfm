<cfinclude template="coverage-check.cfm" >

<cfif not structKeyExists(url,"templatePath")>
	<p>No file has been specified</p>
	<cfexit>
</cfif>

<cfset pageCoverage = coverageTool.getCFPageCoverage(url.templatePath)>
<cfset lineNo = 1>

<html>
<head>
	<title>CF Template code coverage</title>
	<script type="text/javascript">
		function goBack(){
			window.location = 'coverage-statistics.cfm';
		}
		function confirmReset(){
			return window.confirm("Do you want to reset statistics for this template?");
		}
	</script>
</head>
<style type="text/css">
	body {
		font-family: Lucida Console;
		font-size: 12px;
	}
	.file-content {
		font-size: 12px;
	}
	.line {
		font-family: Lucida Console;
		margin: 0px;
		height: 20px;
		line-height: 20px;
	}
	.line .lineNumber {
		float: left;
		padding-left: 5px;
		width: 35px;
	}
	.line .text {
	}
	.visited .lineNumber {
		background-color: #aaeba1;
	}
	.visited .text {
		background-color: #d0f4cc;
	}
	.covered .lineNumber {
		background-color: #a0a0a0;
		color: #FFFFFF;
	}
	.covered .text {
		background-color: #d2d2d2;
	}
	pre {
		font-family: Lucida Console;
		margin: 0px;

	}
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
<cfif isDefined("pageCoverage")>
	<cfset outOfSync = not pageCoverage.isUpToDate() >
	<p>
		#htmlCodeFormat(url.templatePath)#
	</p>
	<p>
		<span class="percentage">#pageCoverage.getVisitedPercentage()#%</span> of covered visited.<cfif outOfSync >(out of sync)</cfif>
	</p>
	<hr/>
		<form action="coverage-details-action.cfm" method="get">
			<input type="hidden" name="templatePath" value="#url.templatePath#" />
			
			<input type="button" name="" value="back" onclick="goBack();"/>
			<input type="submit" name="action" value="refresh" title="Refresh current page"/>
			<input type="submit" name="action" value="reset" onclick="confirmReset();" title="Reset statistics for current template"/>
			<cfif outOfSync >
			|
				<input type="submit" name="action" value="timestamp" title="Update coverage timestamp"/>
			</cfif>
		</form>
	<hr/>
	<dl class="file-content">
		<cfloop file="#url.templatePath#" index="line">
			<cfif pageCoverage.wasVisited(lineNo)>
				<cfset styleClass = "visited">
			<cfelseif pageCoverage.wasCovered(lineNo)>
				<cfset styleClass = "covered">
			<cfelse>
				<cfset styleClass = "">
			</cfif>
			<dd class="line #styleClass#">
				<div class="lineNumber">#lineNo#</div>
				<div class="text">#HTMLCodeFormat(line & " ")#</div> <!--- TODO: fix empty line problem --->
			</dd>
			<cfset lineNo++ >
		</cfloop>
	</dl>
<cfelse>
	No statistics available
</cfif>
</cfoutput>
</body>
</html>