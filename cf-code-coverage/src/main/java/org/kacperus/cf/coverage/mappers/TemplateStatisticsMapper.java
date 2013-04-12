package org.kacperus.cf.coverage.mappers;

import org.kacperus.cf.coverage.TemplateStatistics;
import org.kacperus.cf.coverage.dto.TemplateStatisticsDto;


public class TemplateStatisticsMapper {

	public static TemplateStatisticsDto map(TemplateStatistics ts){
		TemplateStatisticsDto dto = new TemplateStatisticsDto(ts.getTemplatePath(), ts.getCoveredLineCount(), ts.getVisitedLineCount());
		dto.setCoveredLines( ts.getCoveredLineNumbers() );
		dto.setVisitedLines( ts.getVisitedLineNumbers() );
		return dto;
	}
	
}
