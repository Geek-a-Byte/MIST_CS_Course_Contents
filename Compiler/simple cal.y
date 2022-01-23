%{
#include<stdio.h>
#define YYSTYPE double
int yylex();
FILE *yyin, *yyout;
int yyerror(const char *s) 
{
fprintf(yyout,"%s\n", s);
}
%}

%token NEWLINE NUMBER LPAREN RPAREN
%left PLUS MINUS
%left MUL DIV

%%
stmt : line
| stmt line
;
line: expr NEWLINE		{fprintf(yyout,"Result:%lf\n", $1); }	
;
expr : expr PLUS expr	{$$=$1+$3;}
| expr MINUS expr		{$$=$1-$3;}
| expr MUL expr 		{$$=$1*$3;}
| expr DIV expr 		
						{if($3==0) yyerror("Div by 0 error.");
						else $$=$1/$3;}
| LPAREN expr RPAREN	{$$=$2;}
| NUMBER				{$$=$1; }
;

%%
void main(){
yyin=fopen("input.txt", "r");
yyout=fopen("ou.txt", "w");
yyparse();
}