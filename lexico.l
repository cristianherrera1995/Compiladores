%{
#include "lexico.h"
int comprobar_entero(); 
int comprobar_longitud();
%}
digito          			    [0-9]
letra                	 	 	    [a-zA-Z]
entero              			    {digito}+
id					    ({letra}|"_")({letra}|{digito}|"_")*
correctos				    ({id}|{entero}|"function"|"const"|"program"|"var"|"begin"|"end"|"if"|"then"|"else"|"while"|"do"|"for"|"to"|"write"|"read"|[;:.,():=+-/*])
%x comentario
%x panico
%x cadena
%%
		int cars = 0;
<cadena>[^"]				    yymore();
<cadena>["]				    BEGIN(0); return STRING;

<panico>[^{correctos}]			    cars+=yyleng;yymore();
<panico>{correctos} 			    yyless(cars);cars=0;BEGIN(0); return ERR; 	//yyless()
<panico><<EOF>>				    cars=0;return ERR;

"(*"					    BEGIN(comentario); yymore();
<comentario>(.|\n)			    yymore();
<comentario>"*)"  			    BEGIN(0);
"//"(.*)[\n]                                ;
[ \n\t]					    ;
iderr						printf("id error\n");
"program"    				    return PROGRAM;
"function"    				    return FUNCTION;
"const"					    return CONST;
"var"					    return VAR;
"integer"				    return INTEGER;
"begin"					    return BEGINN;
"end"					    return END;
"if"					    return IF;
"then"					    return THEN;
"else"					    return ELSE;
"while"					    return WHILE;
"do"					    return DO;
"for"					    return FOR;
"to"					    return TO;
"write"					    return WRITE;
"read"					    return READ;
["]					    BEGIN(cadena); yymore();
{id}    				    return comprobar_longitud();
{entero}                                    return comprobar_entero();
";"                                         return SEMICOLON;
":"                                         return DOSPUNTOS;
"\."                                        return PUNTO;
","                                         return COMA;
"("                                         return LPAREN;		
")"                                         return RPAREN;
":="                                        return ASIGNOP;
"+"                                         return PLUSOP;
"-"                                         return MINUSOP;
"/"                                         return DIV;
"*"                                         return MULT;
.					    BEGIN(panico); printf("%s\n", yytext);yymore();

%%

int comprobar_entero() {
	int i = atoi(yytext);
	if( i == -1) {
		printf("entero demasiado grande: %s\n", yytext);
		return ERR;
	}
	else 
		return ENTERO;
}

int comprobar_longitud(){
	printf("COMPROBANDO ID\n");
	if(yyleng > 16){
		printf("identificador demasiado largo: %s\n", yytext);
		return ERR;
	} else 
		return ID;
}
