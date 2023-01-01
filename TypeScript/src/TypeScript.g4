grammar TypeScript; // Grammar for TypeScript

import TypeScriptLexerRules;

@header {
package antlr;
}

// Source Unit, example: module foo { export = foo; }
sourceUnit: moduleElements* EOF;

// Module elements, example: import foo = require('foo'); export = foo;
moduleElements: moduleElement (SEMICOLON moduleElement)*;

moduleElement:
	importDeclaration
	| externalModuleReference
	| ambientModuleDeclaration
	| statement
	| functionDeclaration
	| classDeclaration
	| interfaceDeclaration
	| enumDeclaration
	| typeAliasDeclaration
	| block;

/* ---------------------------- Types ---------------------------- */
type:
	typeReference
	| typeQuery
	| typeLiteral
	// Array type, example: number[]
	| type '[]'
	| LPAREN type RPAREN;

// Type reference, example: foo
typeReference: ANY | NUMBER | BOOLEAN | STRING | SYMBOL | VOID;

// Type query, example: typeof foo
typeQuery: TYPEOF IDENTIFIER;

// Type literal, example: { x: number; y: number; }
typeLiteral: LBRACE typeMemberList RBRACE;

// Type member list, example: x: number; y: number;
typeMemberList: typeMember (COMMA typeMember)*;

// Type member, example: x: number
typeMember: IDENTIFIER COLON type;

// Type parameters
typeParameters: '<' typeParameterList '>';
typeParameterList: typeParameter (COMMA typeParameter)*;
typeParameter: IDENTIFIER;

// Type arguments
typeArguments: '<' typeArgumentList '>';
typeArgumentList: typeArgument (COMMA typeArgument)*;
typeArgument: type;

// Type constraints
typeConstraint: EXTENDS type;

// Type annotations
typeAnnotation: COLON type;
/* ---------------------------- Types ---------------------------- */

/* ---------------------------- Import Declaration ---------------------------- */
// Import declaration, example: import foo = require('foo');
importDeclaration:
	IMPORT IDENTIFIER ('=' IDENTIFIER)? ('.' '*' AS IDENTIFIER)? FROM STRING;

// external module reference, example: /// <reference path="foo.ts" />
externalModuleReference:
	'///' '<reference' 'path' '=' STRING '/>';

// Ambient module declaration, example: declare module foo { export = foo; }
ambientModuleDeclaration:
	DECLARE MODULE IDENTIFIER (
		LBRACE moduleElements RBRACE
		| STRING
	);
/* ---------------------------- Import Declaration ---------------------------- */

/* ---------------------------- Function Declaration ---------------------------- */

// Function declarations, example: function foo(x: number, y: number): number { }
functionDeclaration:
	FUNCTION IDENTIFIER LPAREN formalParameterList? RPAREN COLON type LBRACE functionBody RBRACE
	| FUNCTION IDENTIFIER LPAREN formalParameterList? RPAREN LBRACE functionBody RBRACE
	| FUNCTION GET IDENTIFIER LPAREN RPAREN COLON type LBRACE functionBody RBRACE
	| FUNCTION SET IDENTIFIER LPAREN IDENTIFIER COLON type RPAREN LBRACE functionBody RBRACE;
formalParameterList: IDENTIFIER (COMMA IDENTIFIER)*;
functionBody: sourceUnit;

/* ---------------------------- Function Declaration ---------------------------- */

/* ---------------------------- Class Declaration ---------------------------- */

// Class declarations, example: class Point { x: number; y: number; }
classDeclaration:
	CLASS IDENTIFIER (EXTENDS type)? LBRACE classElements RBRACE;
classElements: classElement (SEMICOLON classElement)*;
classElement:
	propertyDeclaration
	| constructorDeclaration
	| methodDeclaration
	| accessorDeclaration;

// Property declaration, example: var x: number;
propertyDeclaration:
	VAR IDENTIFIER COLON type
	| LET IDENTIFIER COLON type
	| CONST IDENTIFIER COLON type;

// Constructor declaration, example: constructor(x: number, y: number) { }
constructorDeclaration:
	CONSTRUCTOR LPAREN formalParameterList? RPAREN LBRACE functionBody RBRACE;

// Method declaration, example: foo(x: number, y: number): number { }
methodDeclaration:
	FUNCTION IDENTIFIER LPAREN formalParameterList? RPAREN COLON type LBRACE functionBody RBRACE
	| FUNCTION IDENTIFIER LPAREN formalParameterList? RPAREN LBRACE functionBody RBRACE;

// Accessor declaration, example: get foo(): number { }
accessorDeclaration:
	GET IDENTIFIER LPAREN RPAREN COLON type LBRACE functionBody RBRACE
	| SET IDENTIFIER LPAREN IDENTIFIER COLON type RPAREN LBRACE functionBody RBRACE;

/* ---------------------------- Class Declaration ---------------------------- */

/* ---------------------------- Interface Declaration ---------------------------- */
// Interface declaration, example: interface IPoint { x: number; y: number; }
interfaceDeclaration:
	INTERFACE IDENTIFIER LBRACE interfaceElements RBRACE;

// Interface elements, example: x: number; y: number;
interfaceElements:
	interfaceElement (SEMICOLON interfaceElement)*;

interfaceElement:
	propertySignature
	| callSignature
	| constructSignature
	| indexSignature
	| methodSignature;

// Property signature, example: x: number
propertySignature: IDENTIFIER COLON type;

// Call Signature, example: (x: number, y: number): number
callSignature: LPAREN formalParameterList? RPAREN COLON type;

// Construct Signature, example: new (x: number, y: number): number
constructSignature:
	NEW LPAREN formalParameterList? RPAREN COLON type;

// Index Signature, example: [x: number]: number
indexSignature: '[' IDENTIFIER COLON type ']' COLON type;

// Method Signature, example: foo(x: number, y: number): number
methodSignature:
	IDENTIFIER LPAREN formalParameterList? RPAREN COLON type;
/* ---------------------------- Interface Declaration ---------------------------- */

/* ---------------------------- Enum Declaration ---------------------------- */
// Enum declaration, example: enum Color { Red, Green, Blue }
enumDeclaration: ENUM IDENTIFIER LBRACE enumElements RBRACE;
// Enum Elements, example: Red, Green, Blue
enumElements: enumElement (COMMA enumElement)*;
// Enum Element, example: Red = 1
enumElement: IDENTIFIER ('=' expression)?;
/* ---------------------------- Enum Declaration ---------------------------- */

/* ---------------------------- Type Alias Declaration ---------------------------- */
// Type alias declaration, example: type Point = { x: number; y: number; }
typeAliasDeclaration: TYPE IDENTIFIER '=' type;
/* ---------------------------- Type Alias Declaration ---------------------------- */

statement:
	block
	| exportStatement
	| variableStatement
	| emptyStatement
	| expression
	| ifStatement
	| iterationStatement
	| continueStatement
	| breakStatement
	| returnStatement
	| withStatement
	| labelledStatement
	| switchStatement
	| throwStatement
	| tryStatement;

// Block Statement, example: { var x = 10; return x; }
block: LBRACE statement* RBRACE;

// Export Statement, example: export default foo;
exportStatement: EXPORT (DEFAULT | exportType) exports;
exportType: CLASS | FUNCTION | VAR | LET | CONST | ENUM | TYPE;
exports:
	IDENTIFIER SEMICOLON?
	| classDeclaration
	| functionDeclaration
	| interfaceDeclaration
	| enumDeclaration
	| variableDeclaration
	| typeAliasDeclaration;

// Variable Statement, example: var x = 10;
variableStatement: VAR variableDeclarationList SEMICOLON?;
// example: var x: number = 10, y: number = 20;
variableDeclarationList:
	variableDeclaration (COMMA variableDeclaration)*;
// example: x: number = 10
variableDeclaration: IDENTIFIER COLON type ('=' expression)?;

// Empty Statement, example: ;
emptyStatement: SEMICOLON;

// If Statement, example: if (x > 10) { return x; } else { return y; }
ifStatement:
	IF LPAREN expression RPAREN statement ('else' statement)?;

// Iteration Statement, example: while (x > 10) { x = x - 1; }
iterationStatement: DO statement WHILE LPAREN expression RPAREN;

// Continue Statement, example: continue;
continueStatement: CONTINUE IDENTIFIER? SEMICOLON?;

// Break Statement, example: break;
breakStatement: BREAK IDENTIFIER? SEMICOLON?;

// Return Statement, example: return x;
returnStatement: RETURN expression? SEMICOLON?;

// With Statement, example: with (x) { return x; }
withStatement: WITH LPAREN expression RPAREN statement;

// Labelled Statement, example: label: return x;
labelledStatement: IDENTIFIER COLON statement;

// Switch Statement, example: switch (x) { case 1: return x; default: return y; }
switchStatement:
	SWITCH LPAREN expression RPAREN LBRACE switchClauses RBRACE;
switchClauses: switchClause+;
switchClause: caseClause | defaultClause;
caseClause: CASE expression COLON statementList;
defaultClause: DEFAULT COLON statementList;
statementList: statement*;

// Throw Statement, example: throw x;
throwStatement: THROW expression SEMICOLON?;

// Try Statement, example: try { return x; } catch (e) { return y; } finally { return z; }
tryStatement: TRY block catchClause finallyClause?;
catchClause: CATCH LPAREN IDENTIFIER RPAREN block;
finallyClause: FINALLY block;

expression:
	assignmentExpr # AssignmentExpression
	// Conditional Expression, example: x > 10 ? x : y
	| expression '?' expression ':' expression # ConditionalExpression

	// logical Or Expression, example: x || y
	| expression LOGICAL_OR expression # LogicalOrExpression

	// Logical And Expression, example x && y
	| expression LOGICAL_AND expression # LogicalAndExpression

	// Bitwise Or Expression, example: x | y
	| expression OR expression # BitwiseOrExpression

	// Bitwise Xor Expression, example: x ^ y
	| expression XOR expression # BitwiseXorExpression

	// Bitwise And Expression, example: x & y
	| expression AND expression # BitwiseAndExpression

	// Equality Expression, example: x == y
	| expression (op = equalityOperator) expression # EqualityExpression

	// Relational Expression, example: x < y
	| expression (op = relationalOperator) expression # RelationalExpression

	// Shift Expression, example: x << y
	| expression (op = shiftOperator) expression # ShiftExpression

	// Additive Expression, example: x + y
	| expression (op = additiveOperator) expression # AdditiveExpression

	// Multiplicative Expression, example: x * y
	| expression (op = multiplicativeOperator) expression # MultiplicativeExpression

	// Unary Expression, example: -x
	| (op = unaryOperator) expression # UnaryExpression

	// Postfix Expression, example: x++
	| postfixExpr	# PostfixExpression
	| primaryExpr	# PrimaryExpression;

// Unary operators
unaryOperator: BANG | MINUS | TILDE;

// Equality operators
equalityOperator: EQ | NOTEQ | STRICT_EQ | STRICT_NOTEQ;

// Relational operators
relationalOperator: LT | LTEQ | GT | GTEQ;

// Shift operators
shiftOperator: LSHIFT | RSHIFT | URSHIFT;

// Additive operators
additiveOperator: PLUS | MINUS;

// Multiplicative operators
multiplicativeOperator: MUL | DIV | MOD;

// Assignment operators
assignmentOperator:
	ASSIGN
	| PLUS_ASSIGN
	| MINUS_ASSIGN
	| MUL_ASSIGN
	| DIV_ASSIGN
	| MOD_ASSIGN
	| AND_ASSIGN
	| XOR_ASSIGN
	| OR_ASSIGN
	| LSHIFT_ASSIGN
	| RSHIFT_ASSIGN
	| URSHIFT_ASSIGN;

// Assignment Expression, example: x = 10;
assignmentExpr:
	IDENTIFIER (op = assignmentOperator) expression SEMICOLON?;

// Postfix operators
postfixOperator: INC | DEC;

// Postfix Expression, example: x++
postfixExpr: IDENTIFIER (op = postfixOperator) SEMICOLON?;

// Primary Expression, example: 10
primaryExpr:
	IDENTIFIER
	| NUM
	| STR
	| TRUE
	| FALSE
	| REGEX
	| groupedExpression
	| arrayLiteral
	| objectLiteral
	| functionExpression
	| classExpression
	| newExpression
	| memberExpression
	| callExpression;

// Grouped Expression, example: (x)
groupedExpression: LPAREN expression RPAREN;

// Array Literal, example: [1, 2, 3]
arrayLiteral: LBRACK elementList? RBRACK;
elementList: expression (COMMA expression)*;

// Object Literal, example: { x: 10, y: 20 }
objectLiteral: LBRACE propertyAssignmentList? RBRACE;
propertyAssignmentList:
	propertyAssignment (COMMA propertyAssignment)*;
propertyAssignment: IDENTIFIER COLON expression;

// Function Expression, example: function(x: number): number { return x; }
functionExpression:
	FUNCTION IDENTIFIER? LPAREN formalParameterList? RPAREN COLON type LBRACE functionBody RBRACE;

// Class Expression, example: class X { x: number; }
classExpression: CLASS IDENTIFIER? LBRACE classBody RBRACE;
classBody: classElement*;

// New Expression, example: new X();
newExpression: NEW memberExpression;
memberExpression: IDENTIFIER;

// Call Expression, example: x();
callExpression: IDENTIFIER LPAREN argumentList? RPAREN;
argumentList: expression (COMMA expression)*;
