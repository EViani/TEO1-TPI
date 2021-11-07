package codigo;
import java_cup.runtime.Symbol;
import java.util.ArrayList;



%%


/*%cupsym Simbolo*/
%cup
%public
%class Lexico
%line
%column
%char
%eofval{
    return null;
%eofval}
%eofclose


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
		boolean flag;
		flag = true;
		if(simbolo.size()>0){
			for (Simbolos s:simbolo){
				switch  (t){
					case "ID" :
						if(s.getNombre().equals(l)){
							flag=false;
						}
						break;
					case "CONST_STRING":
						if(s.getNombre().equals(l.substring(1,l.length()-1))){
							flag=false;
						}
						break;
					default :
						if(s.getValor().equals(l)){
							flag=false;
						}
						break;
				}
			}
		}
		if (flag){
			simbolo.add(new Simbolos(l,t));
		}
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

{PR_AND}		{setLexemas(yytext(),"PR_AND");}
{PR_OR}		{setLexemas(yytext(),"PR_OR");}
{PR_IF}		{setLexemas(yytext(),"PR_IF");}
{PR_ELSE}		{setLexemas(yytext(),"PR_ELSE");}
{PR_ENDIF}		{setLexemas(yytext(),"PR_ENDIF");}
{PR_WRITE}		{setLexemas(yytext(),"PR_WRITE");}

{PR_DECLARE} {setLexemas(yytext(),"PR_DECLARE");}
{PR_ENDDECLARE} {setLexemas(yytext(),"PR_ENDDECLARE");}
{PR_PROGRAM} {setLexemas(yytext(),"PR_PROGRAM");}
{PR_ENDPROGRAM} {setLexemas(yytext(),"PR_ENDPROGRAM");}
{PR_FLOAT} {setLexemas(yytext(),"PR_FLOAT");}
{PR_INT} {setLexemas(yytext(),"PR_INT");}
{PR_STRING} {setLexemas(yytext(),"PR_STRING");}
{COMA} {setLexemas(yytext(),"COMA");}
{PUNTOYCOMA} {setLexemas(yytext(),"PUNTOYCOMA");}
{PR_WHILE} {setLexemas(yytext(),"PR_WHILE");}
{PR_ENDWHILE} {setLexemas(yytext(),"PR_ENDWHILE");}
{PR_PROMR} {setLexemas(yytext(),"PR_PROMR");}

{ID}		{setLexemas(yytext(),"ID"); 
				setSimbolos(yytext(),"ID");}


{ASSIGN}		{setLexemas(yytext(),"ASSIGN");}

{CONST_INT}		{controlEntero(yytext());
				setLexemas(yytext(),"CONST_INT");
                setSimbolos(yytext(),"CONST_INT");}


{CONST_STRING} {controlString(yytext()); 
				setLexemas(yytext(),"CONST_STRING");
                setSimbolos(yytext(),"CONST_STRING");} 

{CONST_FLOAT}	{controlReal(yytext()); 
                setLexemas(yytext(),"CONST_FLOAT");
                setSimbolos(yytext(),"CONST_FLOAT");}


{CORCHA}		{setLexemas(yytext(),"CORCHA");}
{CORCHC}		{setLexemas(yytext(),"CORCHC");}
{PARENA}		{setLexemas(yytext(),"PARENA");}
{PARENC}		{setLexemas(yytext(),"PARENC");}

{SUMA}		{setLexemas(yytext(),"SUMA");}
{RESTA}		{setLexemas(yytext(),"RESTA");}
{DIVI}		{setLexemas(yytext(),"DIVISION");}
{MULTI}		{setLexemas(yytext(),"MULTIPLICAION");}
{MAYOR}		{setLexemas(yytext(),"MAYOR");}
{MAYOROIGUAL}		{setLexemas(yytext(),"MAYOROIGUAL");}
{MENOR}		{setLexemas(yytext(),"MENOR");}
{MENOROIGUAL}		{setLexemas(yytext(),"MENOROIGUAL");}
{DISTINTO}		{setLexemas(yytext(),"DISTINTO");}
{IGUAL}		{setLexemas(yytext(),"IGUAL");}


{COMEN}		{}
{ESPACIO} {}
{SALTO} {}

}

[^]		{setError("Caracter no permitido: <" + yytext() + "> en la linea " + yyline); }