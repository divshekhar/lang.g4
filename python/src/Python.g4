grammar Python;
import PythonLexerRules;

@header {
package antlr;
}

tokens {
	DEDENT
}

// Python program
program: (statement)+;

// python statement
statement:
	blankStat				# blankStatement
	| assignmentStat		# assignmentStatement
	| augmentedAssignStat	# augmentedAssignStatement
	| functionDefStat		# functionDefinition
	| classDefStat			# classDefinition
	| expressionStat		# expressionStatement
	| passStat				# passStatement
	| delStat				# delStatement
	| returnStat			# returnStatement
	| yieldStat				# yieldStatement
	| raiseStat				# raiseStatement
	| breakStat				# breakStatement
	| continueStat			# continueStatement
	| importStat			# importStatement
	| globalStat			# globalStatement
	| nonlocalStat			# nonlocalStatement
	| assertStat			# assertStatement
	| ifStat				# ifStatement
	| whileStat				# whileStatement
	| forStat				# forStatement
	| tryStat				# tryStatement
	| withStat				# withStatement
	| decoratedDefStat		# decoratedDefinition
	| asyncStat				# asyncStatement
	| compoundStat			# compoundStatement;

// Blank statement, example: ;
blankStat: NEWLINE;

// Import statement, example: import os, sys as system
importStat:
	IMPORT module (AS IDENTIFIER)? (
		COMMA module (AS IDENTIFIER)?
	)*;
module: IDENTIFIER (DOT IDENTIFIER)*;

// Global statement, example: global a, b
globalStat: GLOBAL IDENTIFIER (COMMA IDENTIFIER)*;

// Nonlocal statement, example: nonlocal a, b
nonlocalStat: NONLOCAL IDENTIFIER (COMMA IDENTIFIER)*;

// Function definition, example: def f(a, b): pass
functionDefStat:
	DEF IDENTIFIER LPAREN parameterList? RPAREN COLON suite;
parameterList: parameter (COMMA parameter)*;
parameter: IDENTIFIER (ASSIGN expression)?;

// Class definition, example: class C: pass
classDefStat:
	CLASS IDENTIFIER (LPAREN IDENTIFIER RPAREN)? COLON suite;

// Suite, block of statements
suite: NEWLINE? (INDENT)*? (statement)+ DEDENT NEWLINE?;

// Assignment, example: a = 1
assignmentStat: IDENTIFIER ASSIGN expression NEWLINE?;

// Augmented operators
augmentedOperator:
	PLUS_ASSIGN
	| MINUS_ASSIGN
	| TIMES_ASSIGN
	| DIV_ASSIGN
	| MOD_ASSIGN
	| AND_ASSIGN
	| OR_ASSIGN
	| XOR_ASSIGN
	| LSHIFT_ASSIGN
	| RSHIFT_ASSIGN
	| POW_ASSIGN
	| IDIV_ASSIGN;

// Augmented assignment, example: a += 1
augmentedAssignStat:
	IDENTIFIER augmentedOperator expression NEWLINE?;

// Expression statement, example: 1 + 1
expressionStat: expression NEWLINE?;

// Pass statement, example: pass
passStat: PASS NEWLINE?;

// Del statement, example: del a
delStat: DEL expression NEWLINE?;

// Return statement, example: return 1
returnStat: RETURN expression? NEWLINE?;

// Yield statement, example: yield 1
yieldStat: YIELD expression? NEWLINE?;

// Raise statement, example: raise Exception
raiseStat: RAISE expression? NEWLINE?;

// Break statement, example: break
breakStat: BREAK NEWLINE?;

// Continue statement, example: continue
continueStat: CONTINUE NEWLINE?;

// Assert statement, example: assert a == 1
assertStat: ASSERT expression (COMMA expression)? NEWLINE?;

// If statement, example: if a == 1: pass
ifStat:
	IF expression COLON suite (ELIF expression COLON suite)* (
		ELSE COLON suite
	)?;
elifStat: ELIF expression COLON suite;

// While statement, example: while a == 1: pass
whileStat: WHILE expression COLON suite (ELSE COLON suite)?;

// For statement, example: for i in range(10): pass
forStat:
	FOR IDENTIFIER IN expression COLON suite (ELSE COLON suite)?;

// Try statement, example: try: pass except: pass
tryStat:
	TRY COLON suite (
		EXCEPT expression? AS IDENTIFIER? COLON suite
	)* (ELSE COLON suite)? (FINALLY COLON suite)?;
exceptStat: EXCEPT expression? AS IDENTIFIER? COLON suite;

// With statement, example: with open('file.txt') as f: pass
withStat: WITH expression AS IDENTIFIER COLON suite;

// Decorated definition, example: @decorator def f(): pass
decoratedDefStat: AT IDENTIFIER+ functionDefStat;

// Async statement, example: async def f(): pass
asyncStat: ASYNC statement;

// Compound statement, example: { a = 1; b = 2; }
compoundStat: LBRACE statement* RBRACE NEWLINE?;

// Expression
expression:
	// Group expression, example: (a)
	groupExpr # groupExpression

	// Power expression, example: a ** b
	| expression POW expression # powerExpression

	// Multiplicative expression, example: a * b
	| expression op = multiplicativeOperator expression # multiplicativeExpression

	// Additive expression, example: a + b
	| expression op = additiveOperator expression # additiveExpression

	// Shift expression, example: a << b
	| expression (op = shiftOperator) expression # shiftExpression

	// Comparison expression, example: a == b
	| expression co = comparisonOperator expression # comparisonExpression

	// Membership expression, example: a < b
	| expression (op = membershipOperators) expression # relationalExpression

	// Bitwise expression, example: a & b
	| expression op = bitwiseOperator expression # bitwiseExpression

	// Conditional expression, example: a if b else c
	| expression IF expression ELSE expression # conditionalExpression

	// Or expression, example: a or b
	| expression OR expression # orExpression

	// And expression, example: a and b
	| expression AND expression # andExpression

	// Call expression, example: f(1, 2)
	| callExpr # callExpression

	// Attribute expression, example: a.b
	| expression DOT (IDENTIFIER | callExpr) # attributeExpression

	// Subscript expression, example: a[1]
	| expression LBRACKET expression RBRACKET # subscriptExpression

	// Slice expression, example: a[1:2]
	| expression LBRACKET expression? COLON expression? RBRACKET	# sliceExpression
	| notExpr														# notExpression
	| unaryExpr														# unaryExpression
	| lambdaExpr													# lambdaExpression
	| primaryExpr													# primaryExpression;

// Grouped Expression, example: (a)
groupExpr: LPAREN expression RPAREN;

// Call expression, example: f(1, 2)
callExpr: IDENTIFIER LPAREN expressionList? RPAREN;

// Lambda expression, example: lambda a, b: a + b
lambdaExpr: LAMBDA parameterList? COLON expression;

// Not expression, example: not a
notExpr: NOT expression;

// membership operators, example: a in b, a is b
membershipOperators: IN | IS;

// Comparison operators
comparisonOperator: EQ | NE | LT | LE | GT | GE;

// Bitwise operators
bitwiseOperator: BIT_AND | BIT_OR | XOR;

// Shift operators
shiftOperator: LSHIFT | RSHIFT;

// Additive operators
additiveOperator: PLUS | MINUS;

// Multiplicative operators
multiplicativeOperator: TIMES | DIV | MOD | IDIV;

// Unary operators
unaryOperator: op = (MINUS | PLUS | NOT);

// Unary expression, example: -a
unaryExpr: unaryOperator expression;

// Primary expression
primaryExpr:
	identifier
	| numberLiteral
	| stringLiteral
	| booleanLiteral
	| noneLiteral
	| tupleLiteral
	| listLiteral
	| setLiteral;

// Expression list, example: 1, 2, 3
expressionList: expression (COMMA expression)*;

// identifier
identifier: IDENTIFIER;

// String literal
stringLiteral: STRING;

// Number Literal
numberLiteral: NUMBER;

// Boolean literal
booleanLiteral: TRUE | FALSE;

// None literal
noneLiteral: NONE;

// Tuple literal
tupleLiteral: LBRACKET expressionList? RBRACKET;

// List literal
listLiteral: LBRACKET expressionList? RBRACKET;

// Set literal
setLiteral: LBRACE expressionList? RBRACE;
