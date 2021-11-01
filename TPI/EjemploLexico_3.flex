package ejemplojavacup;
import java_cup.runtime.*;

%%


%cup
%public
%class Lexico
%line
%column
%char


LETRA = [a-zA-Z]
DIGITO = [0-9]
ESPACIO = [ \t\f\n\r\n]+
ID = {LETRA}({LETRA}|{DIGITO}|_)*
CONST_INT = {DIGITO}+
CONST_STRING = {COM}({LETRA}|{DIGITO}|{ESPACIO})*{COM}
COMENTARIO = "</" ~ "</" ~ "/>" ~ "/>" | "</" ~ "/>"


%%

<YYINITIAL> {

"("				{return new Symbol(sym.PAR_A,yytext());}
")"				{return new Symbol(sym.PAR_C,yytext());}
"/"				{return new Symbol(sym.OP_DIV,yytext());}
"*"				{return new Symbol(sym.OP_POR,yytext());}
"+"				{return new Symbol(sym.OP_SUMA,yytext());}
"-"				{return new Symbol(sym.OP_RESTA,yytext());}
":="			{return new Symbol(sym.ASIGN,yytext());}
{COMENTARIO}	{}		
{ID}			{return new Symbol(sym.ID,yytext());}
{CONST_INT}		{return new Symbol(sym.CONST_INT,yytext());}
{ESPACIO}		{}

}

[^]		{ throw new Error("Caracter no permitido: <" + yytext() + "> en la linea " + yyline); }
<<EOF>> {return new Symbol(sym.EOF);}