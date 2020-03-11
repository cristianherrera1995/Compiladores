lex.yy.c:	lexico.l
	flex lexico.l

comp:	main.c hash.c
	gcc -o a.out main.c hash.c -I.

main.c:	lex.yy.c

