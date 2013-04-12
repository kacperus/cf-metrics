package org.kacperus.cf.coverage;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertFalse;

import org.junit.Before;
import org.junit.Test;
import org.kacperus.cf.coverage.TemplateCoverageTool;
import org.kacperus.cf.coverage.TemplateStatistics;

public class TemplateCoverageToolTest {
	
	private TemplateCoverageTool tool;
	private String templatePath1 = "/some/path/file.cfm";
	
	@Before
	public void setUp(){
		tool = TemplateCoverageTool.getInstance();
		tool.preparePageCoverage(templatePath1);
	}
	
	@Test
	public void testMarkLineAsCovered(){
		tool.markLineAsCovered(templatePath1, 1);
		assertNotNull(tool.getCFPageCoverage(templatePath1));
	}

	@Test
	public void testMarkLineAsVisited(){
		tool.markLineAsVisited(templatePath1, 1);
		assertNotNull(tool.getCFPageCoverage(templatePath1));
	}
	
	@Test
	public void testPreparePageCoverage(){
		tool.markLineAsCovered(templatePath1, 1);
		tool.preparePageCoverage(templatePath1);
		TemplateStatistics page = tool.getCFPageCoverage(templatePath1);
		assertNotNull(page);
		tool.preparePageCoverage(templatePath1);
		assertFalse(page.wasCovered(1));
	}

}
