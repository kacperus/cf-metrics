package org.kacperus.cf.coverage.dto;

import org.junit.Test;
import org.kacperus.cf.coverage.TemplateStatistics;
import org.kacperus.cf.coverage.dto.TemplateStatisticsDto;
import org.kacperus.cf.coverage.mappers.TemplateStatisticsMapper;


public class TemplateStatisticsDtoTest {
	
	@Test
	public void testMappings(){
		TemplateStatistics page = new TemplateStatistics("X");
		page.markLineAsCovered(1);
		page.markLineAsCovered(2);
		page.markLineAsCovered(3);
		page.markLineAsVisited(1);
		page.markLineAsVisited(2);
		page.markLineAsVisited(3);
		TemplateStatisticsDto dto = TemplateStatisticsMapper.map( page );
		dto.setVisitedLinesAsString( dto.getVisitedLinesAsString() );
	}

}
