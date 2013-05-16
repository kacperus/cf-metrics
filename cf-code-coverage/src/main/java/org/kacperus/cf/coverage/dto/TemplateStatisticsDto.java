package org.kacperus.cf.coverage.dto;

import org.kacperus.cf.coverage.utils.TransformationTool;

public class TemplateStatisticsDto {
	
	private String templatePath;
	private int coveredLinesCount;
	private int visitedLinesCount;
	private int[] coveredLines = {};
	private int[] visitedLines = {};
	
	public TemplateStatisticsDto(){
	}
	
	public TemplateStatisticsDto(String templatePath, int coveredLinesCount, int visitedLinesCount) {
		this.templatePath = templatePath;
		this.coveredLinesCount = coveredLinesCount;
		this.visitedLinesCount = visitedLinesCount;
	}

	public String getTemplatePath() {
		return templatePath;
	}
	public void setTemplatePath(String templatePath) {
		this.templatePath = templatePath;
	}

	public int getCoveredLinesCount() {
		return coveredLinesCount;
	}
	public void setCoveredLinesCount(int coveredLinesCount) {
		this.coveredLinesCount = coveredLinesCount;
	}

	public int getVisitedLinesCount() {
		return visitedLinesCount;
	}
	public void setVisitedLinesCount(int visitedLinesCount) {
		this.visitedLinesCount = visitedLinesCount;
	}

	public int[] getCoveredLines() {
		return coveredLines;
	}
	public void setCoveredLines(int[] coveredLines) {
		this.coveredLines = coveredLines;
	}

	public int[] getVisitedLines() {
		return visitedLines;
	}
	public void setVisitedLines(int[] visitedLines) {
		this.visitedLines = visitedLines;
	}
	
	public String getVisitedLinesAsString(){
		return TransformationTool.intArray2String(visitedLines);
	}
	public void setVisitedLinesAsString(String comaSeparatedList){
		visitedLines = TransformationTool.string2IntArray(comaSeparatedList);
	}

	public String getCoveredLinesAsString(){
		return TransformationTool.intArray2String(coveredLines);
	}
	public void setCoveredLinesAsString(String comaSeparatedList){
		coveredLines = TransformationTool.string2IntArray(comaSeparatedList);
	}

}
