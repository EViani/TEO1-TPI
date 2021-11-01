package codigo;
import java_cup.runtime.Symbol;
import java.util.ArrayList;



%%


%cup
%public
%class Lexico
%line
%column
%char


%{
	/*Entero 16 Bits*/
	private final int max_int = Short.MAX_VALUE;
	/*real 32 bits*/
	private final float max_float = Float.MAX_VALUE;
	/*constantes string no mayor a 30 caracteres*/
	 private final int max_string = 32; /* 32 YA QUE CUENTA LAS COMILLAS*/
    private ArrayList<Lexema> Lexemas = new ArrayList<>();
    private ArrayList<Simbolos> simbolo = new ArrayList<>();
    private ArrayList<String> error = new ArrayList<>();
	
	private void controlString(String s){
		if (s.length()> max_string ){
			setError(String.format("Tamanio de string superior a 30, tamanio actual: %d En linea %d %n",(s.length()-2),yyline+1));
		}	
	}
	
	private void controlReal(String s){
		float r = Float.parseFloat(s);
		if(r < 0 || r> max_float){
			setError(String.format("Valor real fuera de rango %d - %d , valor actual: %d En linea %d %n",0,max_float,r,yyline+1));
		}
	}
	
	private void controlEntero(String s){
		int i =Integer.parseInt(s);
	 	if(i < 0 || i > max_int){
           setError(String.format("Valor Entero fuera de rango %d - %d, valor actual: %d En linea %d %n",0,max_int, i,yyline+1));
        }
	}
	
	private void setError(String s ){
		error.add(s);
	}
	
	private void setLexemas(String l,String t){
		Lexemas.add(new Lexema(l,t));
	}
	
	public String getLexemas(){
		String s ="";
		for(Lexema l:Lexemas) {
			s +=String.format("Token %s, encontrado Lexema %s %n",l.getToken(),l.getLexema());
		}
		return s;
	};
	
	private void setSimbolos(String l, String t){
		simbolo.add(new Simbolos(l,t));
	}
	
	
	public ArrayList<Simbolos> getSimbolos(){
		return simbolo;
	};
	
	public ArrayList<String> getError(){
		return error;
	}

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
CONST_STRING = {COM}({LETRAS}|{NUMERO}|{ESPACIO}|{SIMBOLO})*{COM}

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






---------------------------------------------------------------
{PR_AND}		{return new Symbol(sym.PR_AND,yytext());}
{PR_OR}		{return new Symbol(sym.PR_OR,yytext());}
{PR_IF}		{return new Symbol(sym.PR_IF,yytext());}
{PR_ELSE}		{return new Symbol(sym.PR_ELSE,yytext());}
{PR_ENDIF}		{return new Symbol(sym.PR_ENDIF,yytext());}
{PR_WRITE}		{return new Symbol(sym.PR_WRITE,yytext());}

{PR_DECLARE} {return new Symbol(sym.PR_DECLARE,yytext());}
{PR_ENDDECLARE} {return new Symbol(sym.PR_ENDDECLARE,yytext());}
{PR_PROGRAM} {return new Symbol(sym.PR_PROGRAM,yytext());}
{PR_ENDPROGRAM} {return new Symbol(sym.PR_ENDPROGRAM,yytext());}
{PR_INT} {return new Symbol(sym.PR_INT,yytext());}
{PR_FLOAT} {return new Symbol(sym.PR_FLOAT,yytext());}
{PR_STRING} {return new Symbol(sym.PR_STRING,yytext());}
{PUNTOYCOMA} {return new Symbol(sym.PUNTOYCOMA,yytext());}
{PR_WHILE} {return new Symbol(sym.PR_WHILE,yytext());}
{PR_ENDWHILE} {return new Symbol(sym.PR_ENDWHILE,yytext());}
{PR_PROMR} {return new Symbol(sym.PR_PROMR,yytext());}

{ID}		{return new Symbol(sym.ID,yytext()); }



{ASSIGN}		{return new Symbol(sym.ASSIGN,yytext());}


{CONST_INT}		{controlEntero(yytext());
				return new Symbol(sym.CONST_INT,yytext());}


{CONST_STRING} {controlString(yytext()); 
				setLexemas(yytext(),"CONST_STRING");
                setSimbolos(yytext(),"CONST_STRING");} 

{CONST_FLOAT}	{controlReal(yytext()); 
                setLexemas(yytext(),"CONST_FLOAT");
                setSimbolos(yytext(),"CONST_FLOAT");}


{COMA} {return new Symbol(sym.COMA,yytext());}
{CORCHA}		{return new Symbol(sym.CORCHA,yytext());}
{CORCHC}		{return new Symbol(sym.CORCHC,yytext());}
{PARENA}		{return new Symbol(sym.PARENA,yytext());}
{PARENC}		{return new Symbol(sym.PARENC,yytext());}

{SUMA}		{return new Symbol(sym.SUMA,yytext());}
{RESTA}		{return new Symbol(sym.RESTA,yytext());}
{DIVI}		{return new Symbol(sym.DIVI,yytext());}
{MULTI}		{return new Symbol(sym.MULTI,yytext());}
{MAYOR}		{return new Symbol(sym.MAYOR,yytext());}
{MAYOROIGUAL}		{return new Symbol(sym.MAYOROIGUAL,yytext());}
{MENOR}		{return new Symbol(sym.MENOR,yytext());}
{MENOROIGUAL}		{return new Symbol(sym.MENOROIGUAL,yytext());}
{DISTINTO}		{return new Symbol(sym.DISTINTO,yytext());}
{IGUAL}		{return new Symbol(sym.IGUAL,yytext());}


{COMEN}		{}
{ESPACIO} {}
{SALTO} {}


}

[^]		{setError("Caracter no permitido: <" + yytext() + "> en la linea " + yyline); }
<<EOF>> {return new Symbol(sym.EOF);}