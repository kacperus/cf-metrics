package coldfusion.compiler;

import coldfusion.compiler.NeoTranslationContext;
import coldfusion.compiler.TemplateAssembler;
import coldfusion.compiler.ASTstart;

import org.kacperus.cf.coverage.TemplateCoverageTool;

aspect TemplateAssemblerAspect {

	pointcut assemplePagePointCut(TemplateAssembler templateAssember, ASTstart start, NeoTranslationContext tc):
		call(java.util.Map TemplateAssembler.assemble(ASTstart, NeoTranslationContext))
		&& target(templateAssember)
		&& args(start, tc);

	before(TemplateAssembler templateAssember, ASTstart start, NeoTranslationContext tc): assemplePagePointCut(templateAssember, start, tc){
		TemplateCoverageTool.getInstance().preparePageCoverage(tc.getPagePath());
	}
	
}