<cfinclude template="coverage-check.cfm" >

<cfif not structKeyExists(url,"templatePath")>
	<p>No file has been specified</p>
	<cfexit>
</cfif>

<cfset pageCoverage = coverageTool.getCFPageCoverage(url.templatePath)>
<cfset lineNo = 1>

<html>
<head>
	<title>CF Metrics - code coverage</title>
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
		margin: 0px;
		font-family: Lucida Console;
		font-size: 12px;
	}
	.header {
		padding: 5px;
		background-color: #c2e1f4;
		border-bottom: 2px solid #90c8ec;
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
		color: #b0b0b0;
	}
	.visited .lineNumber {
		background-color: #aaeba1;
	}
	.visited .text {
		background-color: #d0f4cc;
		color: #000000;
	}
	.covered .lineNumber {
		background-color: #a0a0a0;
		color: #FFFFFF;
	}
	.covered .text {
		background-color: #d2d2d2;
		color: #000000;
	}
	pre {
		font-family: Lucida Console;
		margin: 0px;

	}
	.percentage {
		font-size: 30px;
	}
</style>
<body>
<cfoutput>
<cfif isDefined("pageCoverage")>
	<cfset outOfSync = not pageCoverage.isUpToDate() >
	<div class="header">
		<p>
			#htmlCodeFormat(url.templatePath)#
		</p>
		<p>
			<span class="percentage">#pageCoverage.getVisitedPercentage()#%</span> coverage<cfif outOfSync > (out of sync)</cfif>
		</p>
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
	</div>
	<div>
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
					<span class="lineNumber">#lineNo#</span>
					<div class="text">#HTMLCodeFormat(line & " ")#</div> <!--- TODO: fix empty line problem --->
				</dd>
				<cfset lineNo++ >
			</cfloop>
		</dl>
	</div>
<cfelse>
	<p>No statistics available</p>
</cfif>
</cfoutput>
</body>
</html>