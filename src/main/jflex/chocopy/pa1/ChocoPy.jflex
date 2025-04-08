package chocopy.pa1;
import java_cup.runtime.*;

%%

/*** Do not change the flags below unless you know what you are doing. ***/

%unicode
%line
%column

%class ChocoPyLexer
%public

%cupsym ChocoPyTokens
%cup
%cupdebug

%eofclose false

/*** Do not change the flags above unless you know what you are doing. ***/

/* The following code section is copied verbatim to the
 * generated lexer class. */
%{
    /* The code below includes some convenience methods to create tokens
     * of a given type and optionally a value that the CUP parser can
     * understand. Specifically, a lot of the logic below deals with
     * embedded information about where in the source code a given token
     * was recognized, so that the parser can report errors accurately.
     * (It need not be modified for this project.) */

    /** Producer of token-related values for the parser. */
    final ComplexSymbolFactory symbolFactory = new ComplexSymbolFactory();

    /** Return a terminal symbol of syntactic category TYPE and no
     *  semantic value at the current source location. */
    private Symbol symbol(int type) {
        return symbol(type, yytext());
    }

    /** Return a terminal symbol of syntactic category TYPE and semantic
     *  value VALUE at the current source location. */
    private Symbol symbol(int type, Object value) {
        return symbolFactory.newSymbol(ChocoPyTokens.terminalNames[type], type,
            new ComplexSymbolFactory.Location(yyline + 1, yycolumn + 1),
            new ComplexSymbolFactory.Location(yyline + 1,yycolumn + yylength()),
            value);
    }

%}

/* Macros (regexes used in rules below) */

WhiteSpace = [ \t]
LineBreak  = \r|\n|\r\n

IntegerLiteral = 0 | [1-9][0-9]*

IdStringLiteral = \"[a-zA-Z_][\w]*\"

/* Macro to \", \\, \n and \r, respectively. All the escaped characters of chocopy defined with hexadecimal */
ScapedChars = \\\"|\\\\|\\n|\\r

/* 
    This Macro defines a subset of ASCII from code 32 to code 127, without double quote and backslash.
    The definition include space, ! and the ranges: 
        # to [
        ] to DEL, 
    ignoring the double quote and backslash.
 */
ASCIIWithoutScapeReserved = [ !#-\[\]-\x7f]

StringLiteral = \"({ASCIIWithoutScapeReserved}|{ScapedChars})*\" 

Identifier = [a-zA-Z_][a-zA-Z_0-9]*

%state COMMENT_HANDLER

%%

{IdStringLiteral}           {  return symbol(ChocoPyTokens.IDSTRING, yytext()); }

{StringLiteral}           {  return symbol(ChocoPyTokens.STRING, yytext()); }

<COMMENT_HANDLER> {

  {LineBreak}           { yybegin(YYINITIAL); }
  .                     {}

}



<YYINITIAL> {

  /* Delimiters. */
  {LineBreak}                 { return symbol(ChocoPyTokens.NEWLINE); }

  /* Literals. */
  {IntegerLiteral}            { return symbol(ChocoPyTokens.NUMBER,
                                                 Integer.parseInt(yytext())); }
  /* Keywords. */

  /* The following is a space-separated list of symbols that correspond to distinct ChocoPy tokens: 
False, None, True, and, as, assert, async, await, break, class, continue, def, del, elif, else,
except, finally, for, from, global, if, import, in, is, lambda, nonlocal, not, or, pass, raise, return,
try, while, with, yield.*/

  "False"                         { return symbol(ChocoPyTokens.FALSE, yytext()); }
  "None"                         { return symbol(ChocoPyTokens.NONE, yytext()); }
  "True"                         { return symbol(ChocoPyTokens.TRUE, yytext()); }
  "and"                        { return symbol(ChocoPyTokens.AND, yytext()); }
  "as"                         { return symbol(ChocoPyTokens.AS, yytext()); }
  "assert"                         { return symbol(ChocoPyTokens.ASSERT, yytext()); }
  "async"                         { return symbol(ChocoPyTokens.ASYNC, yytext()); }
  "await"                        { return symbol(ChocoPyTokens.AWAIT, yytext()); }
  "break"                        { return symbol(ChocoPyTokens.BREAK, yytext()); }
  "class"                        { return symbol(ChocoPyTokens.CLASS, yytext()); }
  "continue"                        { return symbol(ChocoPyTokens.CONTINUE, yytext()); }
  "def"                         { return symbol(ChocoPyTokens.DEF, yytext()); }
  "del"                         { return symbol(ChocoPyTokens.DEL, yytext()); }
  "elif"                         { return symbol(ChocoPyTokens.ELIF, yytext()); }
  "else"                         { return symbol(ChocoPyTokens.ELSE, yytext()); }
  "except"                         { return symbol(ChocoPyTokens.EXCEPT, yytext()); }
  "finally"                         { return symbol(ChocoPyTokens.FINALLY, yytext()); }
  "for"                         { return symbol(ChocoPyTokens.FOR, yytext()); }
  "from"                         { return symbol(ChocoPyTokens.FROM, yytext()); }
  "global"                        { return symbol(ChocoPyTokens.GLOBAL, yytext()); }
  "if"                        { return symbol(ChocoPyTokens.IF, yytext()); }
  "import"                        { return symbol(ChocoPyTokens.IMPORT, yytext()); }
  "in"                        { return symbol(ChocoPyTokens.IN, yytext()); }
  "is"                        { return symbol(ChocoPyTokens.IS, yytext()); }
  "lambda"                        { return symbol(ChocoPyTokens.LAMBDA, yytext()); }
  "nonlocal"                        { return symbol(ChocoPyTokens.NONLOCAL, yytext()); }
  "not"                        { return symbol(ChocoPyTokens.NOT, yytext()); }
  "or"                        { return symbol(ChocoPyTokens.OR, yytext()); }
  "pass"                        { return symbol(ChocoPyTokens.PASS, yytext()); }
  "raise"                        { return symbol(ChocoPyTokens.RAISE, yytext()); }
  "return"                        { return symbol(ChocoPyTokens.RETURN, yytext()); }
  "try"                        { return symbol(ChocoPyTokens.TRY, yytext()); }
  "while"                        { return symbol(ChocoPyTokens.WHILE, yytext()); }
  "with"                        { return symbol(ChocoPyTokens.WITH, yytext()); }
  "yield"                        { return symbol(ChocoPyTokens.YIELD, yytext()); }        

  /* Operators. */
  /* The following is a space-separated list of symbols that correspond to distinct ChocoPy tokens: 
   + - * // % < > <= >= == != = ( ) [ ] , : . -> */

  "+"                         { return symbol(ChocoPyTokens.PLUS, yytext()); }
  "-"                         { return symbol(ChocoPyTokens.MINUS, yytext()); }
  "*"                         { return symbol(ChocoPyTokens.TIMES, yytext()); }
  "//"                        { return symbol(ChocoPyTokens.INTEGER_DIVISION, yytext()); }
  "%"                         { return symbol(ChocoPyTokens.MOD, yytext()); }
  "<"                         { return symbol(ChocoPyTokens.LESS_THAN, yytext()); }
  ">"                         { return symbol(ChocoPyTokens.GREATER_THAN, yytext()); }
  "<="                        { return symbol(ChocoPyTokens.LESS_OR_EQUAL_THAN, yytext()); }
  ">="                        { return symbol(ChocoPyTokens.GREATER_OR_EQUAL_THAN, yytext()); }
  "=="                        { return symbol(ChocoPyTokens.EQUALS, yytext()); }
  "!="                        { return symbol(ChocoPyTokens.NOT_EQUALS, yytext()); }
  "="                         { return symbol(ChocoPyTokens.ASSIGN, yytext()); }
  "("                         { return symbol(ChocoPyTokens.LEFT_PARENTHESIS, yytext()); }
  ")"                         { return symbol(ChocoPyTokens.RIGHT_PARENTHESIS, yytext()); }
  "["                         { return symbol(ChocoPyTokens.LEFT_BRACKET, yytext()); }
  "]"                         { return symbol(ChocoPyTokens.RIGHT_BRACKET, yytext()); }
  ","                         { return symbol(ChocoPyTokens.COMMA, yytext()); }
  ":"                         { return symbol(ChocoPyTokens.COLON, yytext()); }
  "."                         { return symbol(ChocoPyTokens.DOT, yytext()); }
  "->"                        { return symbol(ChocoPyTokens.RIGHT_ARROW, yytext()); }

  /* Comments */
  "#"                         { yybegin(COMMENT_HANDLER);}

  /* Identifiers. */
 {Identifier}                 { return symbol(ChocoPyTokens.IDENTIFIER, yytext()); }

  /* Whitespace. */
  {WhiteSpace}                { /* ignore */ }
}

<<EOF>>                       { return symbol(ChocoPyTokens.EOF); }

/* Error fallback. */
[^]                           { return symbol(ChocoPyTokens.UNRECOGNIZED); }
