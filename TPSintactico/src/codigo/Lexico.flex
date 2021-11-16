package codigo;
import java_cup.runtime.Symbol;

%%


%cup
%public
%class Lexico
%line
%column
%char


%{


%}




ESPACIO = (\t|\f|" ")
SALTO = (\r|\n|\r\n)

LETRAS = [a-zA-Z]

ASSIGN = ("::=")
NUMERO = [0-9]
PUNTO = (".")



CORCHA = ("[")
CORCHC = ("]")
PARENA = ("(")
PARENC = (")")
SUMA = ("+")
RESTA = ("-") 
MULTI = ("*")
DIVI = ("/")

MAYOR = (">")
MENOR = ("<")
MAYOROIGUAL = (">=")
MENOROIGUAL = ("<=")
DISTINTO = ("!=")
IGUAL = ("=")

PR_AND = ("&")
PR_OR = ("||")

COMEA = ("//*")
COMEC = ("*//")

COM = \"
COMA = (",")
PUNTOYCOMA =(";")
SIMBOLO = ("@"|"_"|":"|"%"|"+"|"-")

ID ={LETRAS}(({LETRAS}|{NUMERO})*_({LETRAS}|{NUMERO})|({LETRAS}|{NUMERO}))*


CONST_INT = {NUMERO}+
CONST_FLOAT = ( {PUNTO}{NUMERO}+ | {NUMERO}+{PUNTO}{NUMERO}+ | {NUMERO}+{PUNTO} )
CONST_STRING = {COM}({LETRAS}|{NUMERO}|{ESPACIO}|{SIMBOLO}|{PUNTO}|{COMA}|{PUNTOYCOMA})*{COM}

PR_IF = ("IF")
PR_ENDIF = ("ENDIF")
PR_ELSE = ("ELSE")
PR_WRITE = ("WRITE")
PR_DECLARE = ("DECLARE.SECTION")
PR_ENDDECLARE = ("ENDDECLARE.SECTION")
PR_PROGRAM = ("PROGRAM.SECTION")
PR_ENDPROGRAM = ("ENDPROGRAM.SECTION")
PR_FLOAT =("FLOAT")
PR_INT =("INT")
PR_STRING =("STRING")
PR_WHILE = ("WHILE")
PR_ENDWHILE =("ENDWHILE")
PR_PROMR = ("PROMR")


COMEN = {COMEA}({LETRAS}|{NUMERO}|{SIMBOLO}|{ESPACIO}|{SALTO})* ({COMEA}({LETRAS}|{NUMERO}|{SIMBOLO}|{ESPACIO}|{SALTO})*{COMEC})* ({LETRAS}|{NUMERO}|{SIMBOLO}|{ESPACIO}|{SALTO})*  {COMEC}



%%

<YYINITIAL> {

{PR_AND}		{return new Symbol(sym.PR_AND,(yyline+1),(yycolumn+1),yytext());}
{PR_OR}		{return new Symbol(sym.PR_OR,(yyline+1),(yycolumn+1),yytext());}
{PR_IF}		{return new Symbol(sym.PR_IF,(yyline+1),(yycolumn+1),yytext());}
{PR_ELSE}		{return new Symbol(sym.PR_ELSE,(yyline+1),(yycolumn+1),yytext());}
{PR_ENDIF}		{return new Symbol(sym.PR_ENDIF,(yyline+1),(yycolumn+1),yytext());}
{PR_WRITE}		{return new Symbol(sym.PR_WRITE,(yyline+1),(yycolumn+1),yytext());}

{PR_DECLARE} {return new Symbol(sym.PR_DECLARE,(yyline+1),(yycolumn+1),yytext());}
{PR_ENDDECLARE} {return new Symbol(sym.PR_ENDDECLARE,(yyline+1),(yycolumn+1),yytext());}
{PR_PROGRAM} {return new Symbol(sym.PR_PROGRAM,(yyline+1),(yycolumn+1),yytext());}
{PR_ENDPROGRAM} {return new Symbol(sym.PR_ENDPROGRAM,(yyline+1),(yycolumn+1),yytext());}
{PR_INT} {return new Symbol(sym.PR_INT,(yyline+1),(yycolumn+1),yytext());}
{PR_FLOAT} {return new Symbol(sym.PR_FLOAT,(yyline+1),(yycolumn+1),yytext());}
{PR_STRING} {return new Symbol(sym.PR_STRING,(yyline+1),(yycolumn+1),yytext());}
{PUNTOYCOMA} {return new Symbol(sym.PUNTOYCOMA,(yyline+1),(yycolumn+1),yytext());}
{PR_WHILE} {return new Symbol(sym.PR_WHILE,(yyline+1),(yycolumn+1),yytext());}
{PR_ENDWHILE} {return new Symbol(sym.PR_ENDWHILE,(yyline+1),(yycolumn+1),yytext());}
{PR_PROMR} {return new Symbol(sym.PR_PROMR,(yyline+1),(yycolumn+1),yytext());}

{ID}		{return new Symbol(sym.ID,(yyline+1),(yycolumn+1),yytext()); }



{ASSIGN}		{return new Symbol(sym.ASSIGN,(yyline+1),(yycolumn+1),yytext());}


{CONST_INT}		{return new Symbol(sym.CONST_INT,(yyline+1),(yycolumn+1),yytext());}


{CONST_STRING} {return new Symbol(sym.CONST_STRING,(yyline+1),(yycolumn+1),yytext());} 

{CONST_FLOAT}	{return new Symbol(sym.CONST_FLOAT,(yyline+1),(yycolumn+1),yytext());}


{COMA} {return new Symbol(sym.COMA,(yyline+1),(yycolumn+1),yytext());}
{CORCHA}		{return new Symbol(sym.CORCHA,(yyline+1),(yycolumn+1),yytext());}
{CORCHC}		{return new Symbol(sym.CORCHC,(yyline+1),(yycolumn+1),yytext());}
{PARENA}		{return new Symbol(sym.PARENA,(yyline+1),(yycolumn+1),yytext());}
{PARENC}		{return new Symbol(sym.PARENC,(yyline+1),(yycolumn+1),yytext());}

{SUMA}		{return new Symbol(sym.SUMA,(yyline+1),(yycolumn+1),yytext());}
{RESTA}		{return new Symbol(sym.RESTA,(yyline+1),(yycolumn+1),yytext());}
{DIVI}		{return new Symbol(sym.DIVI,(yyline+1),(yycolumn+1),yytext());}
{MULTI}		{return new Symbol(sym.MULTI,(yyline+1),(yycolumn+1),yytext());}
{MAYOR}		{return new Symbol(sym.MAYOR,(yyline+1),(yycolumn+1),yytext());}
{MAYOROIGUAL}		{return new Symbol(sym.MAYOROIGUAL,(yyline+1),(yycolumn+1),yytext());}
{MENOR}		{return new Symbol(sym.MENOR,(yyline+1),(yycolumn+1),yytext());}
{MENOROIGUAL}		{return new Symbol(sym.MENOROIGUAL,(yyline+1),(yycolumn+1),yytext());}
{DISTINTO}		{return new Symbol(sym.DISTINTO,(yyline+1),(yycolumn+1),yytext());}
{IGUAL}		{return new Symbol(sym.IGUAL,(yyline+1),(yycolumn+1),yytext());}


{COMEN}		{}
{ESPACIO} {}
{SALTO} {}


}

[^]		{return new Symbol(sym.EXCEP,(yyline+1),(yycolumn+1),yytext()); }
<<EOF>> {return new Symbol(sym.EOF);}

