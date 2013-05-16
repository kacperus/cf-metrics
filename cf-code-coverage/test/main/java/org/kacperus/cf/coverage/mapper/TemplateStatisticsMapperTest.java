package org.kacperus.cf.coverage.mapper;

import static org.junit.Assert.assertEquals;

import org.junit.Test;
import org.kacperus.cf.coverage.TemplateStatistics;
import org.kacperus.cf.coverage.dto.TemplateStatisticsDto;
import org.kacperus.cf.coverage.mappers.TemplateStatisticsMapper;


public class TemplateStatisticsMapperTest {
	
	private String templatePath1 = "/some/path/file.cfm";
	
	@Test
	public void testMapping(){
		TemplateStatistics page = new TemplateStatistics(templatePath1);
		page.markLineAsCovered(1);
		page.markLineAsCovered(2);
		page.markLineAsCovered(3);
		page.markLineAsVisited(1);
		page.markLineAsVisited(3);
		
		TemplateStatisticsDto dto = TemplateStatisticsMapper.map( page );
		assertEquals(dto.getTemplatePath(), page.getTemplatePath());
		assertEquals(dto.getCoveredLinesCount(), page.getCoveredLineCount());
		assertEquals(dto.getVisitedLinesCount(), page.getVisitedLineCount());
	}

}
