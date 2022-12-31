lexer grammar PythonLexerRules;

// INDENT and DEDENT tokens
INDENT: '\t' | '    ';

NEWLINE: '\n';

SKIPS: ( SPACES | COMMENT | LINE_JOINING) -> skip;

fragment INT: DIGIT DIGIT* | '0';

fragment DIGIT: [0-9];

fragment SPACES: [ \t]+;

fragment COMMENT: '#' ~[\r\n\f]*;

fragment LINE_JOINING: '\\' SPACES? ( '\r'? '\n' | '\r' | '\f');

// Tokens for python
NUMBER: INT | FLOAT;
FLOAT: DIGIT+ .DIGIT+;

// String with escape sequences
STRING: '"' (ESC | .)*? '"' | '\'' (ESC | .)*? '\'';

// Escape sequences
fragment ESC: '\\' UNICODE;
fragment UNICODE: 'u' HEX HEX HEX HEX;
fragment HEX: [0-9a-fA-F];

// decorator
AT: '@';

// Operators
PLUS: '+';
MINUS: '-';
TIMES: '*';
DIV: '/';
IDIV: '//';
MOD: '%';
POW: '**';

// Bitwise operators
BIT_AND: '&';
BIT_OR: '|';
XOR: '^';
BIT_NOT: '~';
LSHIFT: '<<';
RSHIFT: '>>';

// Comparison operators
EQ: '==';
NE: '!=';
LT: '<';
LE: '<=';
GT: '>';
GE: '>=';

// Boolean operators
AND: 'and';
OR: 'or';
NOT: 'not';

// Assignment operators
ASSIGN: '=';
PLUS_ASSIGN: '+=';
MINUS_ASSIGN: '-=';
TIMES_ASSIGN: '*=';
DIV_ASSIGN: '/=';
MOD_ASSIGN: '%=';
AND_ASSIGN: '&=';
OR_ASSIGN: '|=';
XOR_ASSIGN: '^=';
LSHIFT_ASSIGN: '<<=';
RSHIFT_ASSIGN: '>>=';
POW_ASSIGN: '**=';
IDIV_ASSIGN: '//=';

// Other operators
LPAREN: '(';
RPAREN: ')';
LBRACE: '{';
RBRACE: '}';
LBRACKET: '[';
RBRACKET: ']';
COMMA: ',';
COLON: ':';
SEMI: ';';
DOT: '.';
ELLIPSIS: '...';

// Keywords
BREAK: 'break';
CONTINUE: 'continue';
RETURN: 'return';
RAISE: 'raise';
FROM: 'from';
IMPORT: 'import';
AS: 'as';
GLOBAL: 'global';
NONLOCAL: 'nonlocal';
ASSERT: 'assert';
IF: 'if';
ELIF: 'elif';
ELSE: 'else';
WHILE: 'while';
FOR: 'for';
IN: 'in';
TRY: 'try';
EXCEPT: 'except';
FINALLY: 'finally';
WITH: 'with';
LAMBDA: 'lambda';
IS: 'is';
NONE: 'None';
TRUE: 'True';
FALSE: 'False';
CLASS: 'class';
DEF: 'def';
PASS: 'pass';
DEL: 'del';
YIELD: 'yield';
ASYNC: 'async';

// Identifiers
IDENTIFIER: [a-zA-Z_][a-zA-Z0-9_]*;