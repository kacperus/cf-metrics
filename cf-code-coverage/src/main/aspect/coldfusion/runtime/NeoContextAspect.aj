package coldfusion.runtime;

import coldfusion.runtime.NeoPageContext;
import org.kacperus.cf.coverage.TemplateCoverageTool;

aspect NeoContextAspect {

	pointcut neoPageContextSetCurrentLineNo(int lineNumber):
		call(void NeoPageContext.setCurrentLineNo(int))
		&& args(lineNumber);
		
	after(int lineNumber) returning: neoPageContextSetCurrentLineNo(lineNumber){
		TemplateCoverageTool.getInstance().markLineAsVisitedForCurrentTemplate(lineNumber);
	}

}