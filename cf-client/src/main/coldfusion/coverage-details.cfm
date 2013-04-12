<cftry>
	<cfset coverageTool = createObject("java","org.kacperus.cf.coverage.TemplateCoverageTool").getInstance()>
<cfcatch type="any">
	<p>Code Coverage Not Enabled</p>
	<cfexit>
</cfcatch>
</cftry>

<cfif not structKeyExists(url,"templatePath")>
	<p>No file has been specified</p>
	<cfexit>
</cfif>

<cfset pageCoverage = coverageTool.getCFPageCoverage(url.templatePath)>
<cfset lineNo = 1>

<html>
<head>
	<title>CF Template code coverage</title>
	<script type="text/javascript" src="http://bernii.github.com/gauge.js/dist/gauge.min.js"></script>
</head>
<style type="text/css">
	.file-content {
		font-family: verdana;
		font-size: 12px;
	}
	
	.line .lineNumber {
		float: left;
		height: 20px;
		width: 32px;
	}
	.line .text {
		height: 20px;
	}
	
	.visited .lineNumber {
		background-color: #80FF50;
	}
	.visited .text {
		background-color: #B0FFC0;
	}
	
	.covered .lineNumber {
		background-color: #707070;
		color: #FFFFFF;
	}
	.covered .text {
		background-color: #C0C0C0;
	}
	pre {
		margin: 0px;
		padding-top: 3px;
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
	<p>
		<canvas id="gauge_canvas"></canvas>
		<span class="percentage">#pageCoverage.getVisitedPercentage()#% covered</span>
	</p>
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
		gauge.maxValue = 100; // set max gauge value
		gauge.animationSpeed = 32; // set animation speed (32 is default value)
		gauge.set(#pageCoverage.getVisitedPercentage()#); // set actual value
	</script>
	
<cfelse>
	No statistics available
</cfif>
</cfoutput>
</body>
</html>