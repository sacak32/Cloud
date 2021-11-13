parser: y.tab.c lex.yy.c
	gcc -o parser y.tab.c
y.tab.c: cloud.yacc lex.yy.c
	yacc cloud.yacc
lex.yy.c: cloud.lex
	lex cloud.lex
clean:
	rm -f lex.yy.c y.tab.c parser


