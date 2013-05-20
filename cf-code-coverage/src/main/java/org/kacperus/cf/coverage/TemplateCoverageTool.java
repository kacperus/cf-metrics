package org.kacperus.cf.coverage;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.apache.log4j.Logger;

import coldfusion.filter.FusionContext;

public class TemplateCoverageTool {
	
	private static Logger log = Logger.getLogger(TemplateCoverageTool.class);
	static {
		log.info("ColdFusion Code Coverage enabled");
	}
	
	private static TemplateCoverageTool _instance = new TemplateCoverageTool();
	private Set<TemplateStatistics> pages = new HashSet<TemplateStatistics>();
	
	
	private TemplateCoverageTool(){
	}
	
	public static TemplateCoverageTool getInstance(){
		return _instance;
	}
	
	public void markLineAsVisitedForCurrentTemplate(int lineNumber){
		FusionContext fContext = FusionContext.getCurrent();
		String pagePath = fContext.getPagePath();
		markLineAsVisited(pagePath, lineNumber);
	}
	
	public void markLineAsCovered(String pagePath, int lineNumber){
		if( pagePath == null ){
			throw new IllegalArgumentException("Page name cannot be null");
		}
		synchronized(pages){
			TemplateStatistics page = getCFPageCoverage(pagePath);
			if( page != null ){
				if( log.isDebugEnabled() ) log.debug("Line marked as covered for: " + pagePath);
				page.markLineAsCovered(lineNumber);
			}
		}
	}

	public void markLineAsVisited(String pagePath, int lineNumber){
		if( pagePath == null ){
			throw new IllegalArgumentException("Page name cannot be null");
		}
		synchronized(pages){
			TemplateStatistics page = getCFPageCoverage(pagePath);
			if( page != null ){
				if( log.isDebugEnabled() ) log.debug("Line marked as visited for: " + pagePath);
				page.markLineAsVisited(lineNumber);
			}else{
				if( log.isDebugEnabled() ) log.debug("Line was marked as visited but page was not recored before: " + pagePath);
			}
		}
	}

	public void preparePageCoverage(String pagePath){
		synchronized(pages){
			if( log.isDebugEnabled() )  log.debug("New CFPageCoverage prepared for: " + pagePath);
			TemplateStatistics page = getCFPageCoverage(pagePath);
			pages.remove(page);
			pages.add(new TemplateStatistics(pagePath));
		}
	}
	
	public TemplateStatistics getCFPageCoverage(String pagePath){
		synchronized(pages){
			for(TemplateStatistics page : pages){
				if( page.getTemplatePath().equals(pagePath)){
					return page;
				}
			}
		}
		return null;
	}
	
	public List<TemplateStatistics> listCFPageCoverages(){
		List<TemplateStatistics> toReturn = new ArrayList<TemplateStatistics>();
		synchronized(pages){
			for(TemplateStatistics page : pages){
				toReturn.add(page);
			}
		}
		return toReturn;
	}
	
	/**
	 * Used to reset statistics for all templates. 
	 */
	public void resetStatistics(){
		synchronized(pages){
			for(TemplateStatistics page : pages){
				page.reset();
			}
		}
	}

}
