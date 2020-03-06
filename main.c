#include <stdio.h>
#include <stdlib.h>
#include "lexico.h"

extern char *yytext;
extern int  yyleng;
extern FILE *yyin;
extern int yylex();
FILE *fich;
int main()
{
    int i;
    char nombre[80];
    int errores = 0;
    printf("INTRODUCE NOMBRE DE FICHERO FUENTE:");
    scanf("%s",nombre);
	printf("\n");
    if ((fich=fopen(nombre,"r"))==NULL) {
        printf("***ERROR, no puedo abrir el fichero\n");
        exit(1);		}
    yyin=fich;
    while (i=yylex()) {
        if (i == ERR) {
		errores++;
		printf("ERROR: %s\n", yytext);
	}
	else
		printf("TOKEN %d",i);
        if(i==ID) printf(", LEXEMA %s LONGITUD %d\n",yytext,yyleng);
        else printf("\n");}
    printf("----------------------\n");
    printf("Errores : %d\n", errores);
    fclose(fich);
    return 0;
}
