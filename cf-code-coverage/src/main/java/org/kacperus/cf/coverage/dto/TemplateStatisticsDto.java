package org.kacperus.cf.coverage.dto;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

import org.kacperus.cf.coverage.utils.TransformationTool;


@XmlRootElement(name="templateStatistics")
@XmlAccessorType(XmlAccessType.PROPERTY)
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

	@XmlTransient
	public int[] getCoveredLines() {
		return coveredLines;
	}
	public void setCoveredLines(int[] coveredLines) {
		this.coveredLines = coveredLines;
	}

	@XmlTransient
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
