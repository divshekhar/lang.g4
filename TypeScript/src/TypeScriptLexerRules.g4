lexer grammar TypeScriptLexerRules;

// Data types
ANY: 'any';
BOOLEAN: 'boolean';
NUMBER: 'number';
STRING: 'string';
SYMBOL: 'symbol';
VOID: 'void';

// Keywords
VAR: 'var';
LET: 'let';
NEW: 'new';
NULL: 'null';
BREAK: 'break';
CONTINUE: 'continue';
CATCH: 'catch';
CASE: 'case';
DO: 'do';
ELSE: 'else';
ENUM: 'enum';
EXPORT: 'export';
EXTENDS: 'extends';
TRUE: 'true';
FALSE: 'false';
FINALLY: 'finally';
FOR: 'for';
FROM: 'from';
FUNCTION: 'function';
GET: 'get';
IF: 'if';
CONSTRUCTOR: 'constructor';
DECLARE: 'declare';
MODULE: 'module';
TYPE: 'type';
AS: 'as';
CLASS: 'class';
CONST: 'const';
DEBUGGER: 'debugger';
DEFAULT: 'default';
DELETE: 'delete';
IMPLEMENTS: 'implements';
IMPORT: 'import';
IN: 'in';
INSTANCEOF: 'instanceof';
INTERFACE: 'interface';
PACKAGE: 'package';
PRIVATE: 'private';
PROTECTED: 'protected';
PUBLIC: 'public';
RETURN: 'return';
SET: 'set';
STATIC: 'static';
SUPER: 'super';
SWITCH: 'switch';
THIS: 'this';
THROW: 'throw';
TRY: 'try';
TYPEOF: 'typeof';
WHILE: 'while';
WITH: 'with';

// Operators
BANG: '!';
TILDE: '~';
DEC: '--';
INC: '++';
PLUS: '+';
MINUS: '-';
MUL: '*';
DIV: '/';
MOD: '%';
LT: '<';
GT: '>';
LTEQ: '<=';
GTEQ: '>=';
EQ: '==';
NOTEQ: '!=';
STRICT_EQ: '===';
STRICT_NOTEQ: '!==';
AND: '&';
OR: '|';
XOR: '^';
LOGICAL_AND: '&&';
LOGICAL_OR: '||';
LSHIFT: '<<';
RSHIFT: '>>';
URSHIFT: '>>>';

// Assignment operators
ASSIGN: '=';
MUL_ASSIGN: '*=';
DIV_ASSIGN: '/=';
MOD_ASSIGN: '%=';
PLUS_ASSIGN: '+=';
MINUS_ASSIGN: '-=';
LSHIFT_ASSIGN: '<<=';
RSHIFT_ASSIGN: '>>=';
URSHIFT_ASSIGN: '>>>=';
AND_ASSIGN: '&=';
XOR_ASSIGN: '^=';
OR_ASSIGN: '|=';
ARROW: '=>';

// Punctuators
LPAREN: '(';
RPAREN: ')';
LBRACE: '{';
RBRACE: '}';
LBRACK: '[';
RBRACK: ']';
COLON: ':';
SEMICOLON: ';';
COMMA: ',';
DOT: '.';
ELLIPSIS: '...';
QUESTION: '?';
AT: '@';

// Literals
IDENTIFIER: [a-zA-Z_$][a-zA-Z_$0-9]*;
NUM: [0-9]+;
STR: '"' (~["\r\n\\] | '\\' .)* '"';
REGEX: '/' (~[/\r\n\\] | '\\' .)* '/' [gimuy]*;
TEMPLATE_STRING: '`' (~[`\\] | '\\' .)* '`';

// Comments
SCOMMENT: '//' (~[\r\n])*;
MCOMMENT: '/*' .*? '*/';

// Whitespace
WS: [ \t\r\n]+ -> skip;
