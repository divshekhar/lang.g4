grammar Python;
import PythonLexerRules;

@header {
package antlr;
}

// Python program
program: (statement)+;

// python statement
statement:
	blankStatement
	| assignment
	| augmentedAssignment
	| functionDefinition
	| classDefinition
	| expressionStatement
	| passStatement
	| delStatement
	| returnStatement
	| yieldStatement
	| raiseStatement
	| breakStatement
	| continueStatement
	| importStatement
	| globalStatement
	| nonlocalStatement
	| assertStatement
	| ifStatement
	| whileStatement
	| forStatement
	| tryStatement
	| withStatement
	| decoratedDefinition
	| asyncStatement
	| compoundStatement;

// Blank statement, example: ;
blankStatement: NEWLINE;

// Import statement, example: import os, sys as system
importStatement:
	IMPORT module (AS IDENTIFIER)? (
		COMMA module (AS IDENTIFIER)?
	)*;
module: IDENTIFIER (DOT IDENTIFIER)*;

// Global statement, example: global a, b
globalStatement: GLOBAL IDENTIFIER (COMMA IDENTIFIER)*;

// Nonlocal statement, example: nonlocal a, b
nonlocalStatement: NONLOCAL IDENTIFIER (COMMA IDENTIFIER)*;

// Function definition, example: def f(a, b): pass
functionDefinition:
	DEF IDENTIFIER LPAREN parameterList? RPAREN COLON suite;
parameterList: parameter (COMMA parameter)*;
parameter: IDENTIFIER (ASSIGN expression)?;

// Class definition, example: class C: pass
classDefinition:
	CLASS IDENTIFIER (LPAREN IDENTIFIER RPAREN)? COLON suite;

// Suite, block of statements
suite: NEWLINE? (INDENT)*? (statement)+ NEWLINE? NEWLINE?;

// Assignment, example: a = 1
assignment: IDENTIFIER ASSIGN expression NEWLINE?;

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
augmentedAssignment:
	IDENTIFIER augmentedOperator expression NEWLINE?;

// Expression statement, example: 1 + 1
expressionStatement: expression NEWLINE?;

// Pass statement, example: pass
passStatement: PASS NEWLINE?;

// Del statement, example: del a
delStatement: DEL expression NEWLINE?;

// Return statement, example: return 1
returnStatement: RETURN expression? NEWLINE?;

// Yield statement, example: yield 1
yieldStatement: YIELD expression? NEWLINE?;

// Raise statement, example: raise Exception
raiseStatement: RAISE expression? NEWLINE?;

// Break statement, example: break
breakStatement: BREAK NEWLINE?;

// Continue statement, example: continue
continueStatement: CONTINUE NEWLINE?;

// Assert statement, example: assert a == 1
assertStatement: ASSERT expression (COMMA expression)? NEWLINE?;

// If statement, example: if a == 1: pass
ifStatement:
	IF expression COLON suite (ELIF expression COLON suite)* (
		ELSE COLON suite
	)?;
elifStatement: ELIF expression COLON suite;

// While statement, example: while a == 1: pass
whileStatement:
	WHILE expression COLON suite (ELSE COLON suite)?;

// For statement, example: for i in range(10): pass
forStatement:
	FOR IDENTIFIER IN expression COLON suite (ELSE COLON suite)?;

// Try statement, example: try: pass except: pass
tryStatement:
	TRY COLON suite (
		EXCEPT expression? AS IDENTIFIER? COLON suite
	)* (ELSE COLON suite)? (FINALLY COLON suite)?;
exceptStatement: EXCEPT expression? AS IDENTIFIER? COLON suite;

// With statement, example: with open('file.txt') as f: pass
withStatement: WITH expression AS IDENTIFIER COLON suite;

// Decorated definition, example: @decorator def f(): pass
decoratedDefinition: AT IDENTIFIER+ functionDefinition;

// Async statement, example: async def f(): pass
asyncStatement: ASYNC statement;

// Compound statement, example: { a = 1; b = 2; }
compoundStatement: LBRACE statement* RBRACE NEWLINE?;

// Expression
expression:
	// Conditional expression, example: a if b else c
	expression IF expression ELSE expression

	// Or expression, example: a or b
	| expression OR expression

	// And expression, example: a and b
	| expression AND expression

	// Comparison expression, example: a == b
	| expression comparisonOperator expression

	// Arithmetic expression, example: a + b
	| expression arithmeticOperator expression

	// Bitwise expression, example: a & b
	| expression bitwiseOperator expression

	// Shift expression, example: a << b
	| expression shiftOperator expression

	// Additive expression, example: a + b
	| expression additiveOperator expression

	// Multiplicative expression, example: a * b
	| expression multiplicativeOperator expression

	// Power expression, example: a ** b
	| expression POW expression

	// Attribute expression, example: a.b
	| expression DOT IDENTIFIER

	// Subscript expression, example: a[1]
	| expression LBRACKET expression RBRACKET

	// Slice expression, example: a[1:2]
	| expression LBRACKET expression? COLON expression? RBRACKET

	// Call expression, example: f(1, 2)
	| IDENTIFIER LPAREN expressionList? RPAREN
	| notExpression
	| unaryExpression
	| lambdaExpression
	| primaryExpression;

// Lambda expression, example: lambda a, b: a + b
lambdaExpression: LAMBDA parameterList? COLON expression;

// Not expression, example: not a
notExpression: NOT expression;

// Comparison operators
comparisonOperator: EQ | NE | LT | LE | GT | GE;

// Arithmetic operators
arithmeticOperator:
	PLUS
	| MINUS
	| TIMES
	| DIV
	| MOD
	| IDIV
	| POW;

// Bitwise operators
bitwiseOperator: BIT_AND | BIT_OR | XOR;

// Shift operators
shiftOperator: LSHIFT | RSHIFT;

// Additive operators
additiveOperator: PLUS | MINUS;

// Multiplicative operators
multiplicativeOperator: TIMES | DIV | MOD | IDIV;

// Unary operators
unaryOperator: MINUS | PLUS | NOT;

// Unary expression, example: -a
unaryExpression: unaryOperator expression;

// Primary expression
primaryExpression:
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
