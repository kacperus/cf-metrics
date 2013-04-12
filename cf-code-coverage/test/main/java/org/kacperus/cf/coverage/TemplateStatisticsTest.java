package org.kacperus.cf.coverage;

import static org.junit.Assert.assertEquals;

import org.junit.Test;
import org.kacperus.cf.coverage.TemplateStatistics;

public class TemplateStatisticsTest {
	
	private String pagePath1 = "/some/page/sample.cfm";
	
	@Test
	public void testMarkLineAsCovered(){
		TemplateStatistics page = new TemplateStatistics(pagePath1);
		page.markLineAsCovered(1);

		int[] covered = page.getCoveredLineNumbers();
		assertEquals(covered.length, 1);
		
		page.markLineAsCovered(2);
		page.markLineAsCovered(3);
		covered = page.getCoveredLineNumbers();
		assertEquals(covered.length, 3);
	}

	@Test
	public void testMarkLineAsVisited(){
		TemplateStatistics page = new TemplateStatistics(pagePath1);
		page.markLineAsCovered(1);
		page.markLineAsCovered(2);
		page.markLineAsCovered(3);
		
		page.markLineAsVisited(1);
		int[] visited = page.getVisitedLineNumbers();
		assertEquals(visited.length, 1);
		assertEquals(visited[0], 1);
		
		page.markLineAsVisited(3);
		visited = page.getVisitedLineNumbers();
		assertEquals(visited.length, 2);
		assertEquals(visited[0], 1);
		assertEquals(visited[1], 3);
	}
	
	@Test
	public void testMarkLineAsVisitedWhenNotCovered(){
		TemplateStatistics page = new TemplateStatistics(pagePath1);
		page.markLineAsCovered(1);
		page.markLineAsVisited(2);
		
		int[] visited = page.getVisitedLineNumbers();
		assertEquals(visited.length, 0);
	}

	@Test
	public void testVisitedPercentage(){
		TemplateStatistics page = new TemplateStatistics(pagePath1);
		page.markLineAsCovered(1);
		page.markLineAsCovered(5);
		page.markLineAsCovered(10);
		page.markLineAsCovered(15);
		
		assertEquals(page.getVisitedPercentage(), 0);

		page.markLineAsVisited(5);
		assertEquals(page.getVisitedPercentage(), 25);

		page.markLineAsVisited(1);
		assertEquals(page.getVisitedPercentage(), 50);
		
		page.markLineAsVisited(15);
		assertEquals(page.getVisitedPercentage(), 75);

		page.markLineAsVisited(10);
		assertEquals(page.getVisitedPercentage(), 100);
	}
	
}
