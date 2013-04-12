package coldfusion.compiler;

import coldfusion.compiler.StmtAssembler;
import coldfusion.compiler.ExprAssembler;
import coldfusion.compiler.StatementNode;
import coldfusion.compiler.Node;

import java.lang.reflect.Method;

import org.kacperus.cf.coverage.TemplateCoverageTool;

aspect StmtAssemblerAspect {
	
	pointcut assembleStatementPointCut(StmtAssembler stmtAssembler,Node node):
		call(Object StmtAssembler.assembleStatement(Node))
		&& target(stmtAssembler)
		&& args(node);
		
	pointcut patchBreaksPointCut(StmtAssembler stmtAssembler,StatementNode targetNode, StatementNode node):
		call(Object StmtAssembler.cfbreak(StatementNode, StatementNode))
		&& target(stmtAssembler)
		&& args(targetNode,node);
		
	before(StmtAssembler stmtAssembler, Node node): assembleStatementPointCut(stmtAssembler, node){
		emitExtraLineNumber(stmtAssembler, node);
	}

	after(StmtAssembler stmtAssembler, Node node): assembleStatementPointCut(stmtAssembler, node){
		emitExtraLineNumber(stmtAssembler, node);
	}
	
	before(StmtAssembler stmtAssembler,StatementNode targetNode, StatementNode node): patchBreaksPointCut(stmtAssembler, targetNode, node){
		emitExtraLineNumber(stmtAssembler, node);
	}
	
	private void emitExtraLineNumber(StmtAssembler stmtAssembler,Node node){
		int lineNo = node.getLine();
		if( lineNo > -1 ){
			// generate additional line numbers
			stmtAssembler.generateLineNo(lineNo);
			// mark the line as covered for the current page path 
			TemplateCoverageTool.getInstance().markLineAsCovered(stmtAssembler.tc.getPagePath(),lineNo);
		}
	}
	
}