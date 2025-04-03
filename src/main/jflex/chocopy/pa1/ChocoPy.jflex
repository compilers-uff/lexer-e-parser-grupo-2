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
ScapedChars = \x5c\x22|\x5c\x5c|\x5cn|\x5cr

/* This Macro defines a subset of ASCII from code 32 to code 127, without double quote and backslash */
ASCIIWithoutScapeReserved = [\x20-\x21\x23-\x5b\x5d-\x7f]

StringLiteral = \"({ASCIIWithoutScapeReserved}|{ScapedChars})*\" 

Identifier = [a-zA-Z_][a-zA-Z_0-9]*

%%

{IdStringLiteral}           {  return symbol(ChocoPyTokens.IDSTRING, yytext()); }

{StringLiteral}           {  return symbol(ChocoPyTokens.STRING, yytext()); }

<YYINITIAL> {

  /* Delimiters. */
  {LineBreak}                 { return symbol(ChocoPyTokens.NEWLINE); }

  /* Literals. */
  {IntegerLiteral}            { return symbol(ChocoPyTokens.NUMBER,
                                                 Integer.parseInt(yytext())); }

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

  /* Identifiers. */
 {Identifier}                 { return symbol(ChocoPyTokens.IDENTIFIER, yytext()); }

  /* Whitespace. */
  {WhiteSpace}                { /* ignore */ }
}

<<EOF>>                       { return symbol(ChocoPyTokens.EOF); }

/* Error fallback. */
[^]                           { return symbol(ChocoPyTokens.UNRECOGNIZED); }
