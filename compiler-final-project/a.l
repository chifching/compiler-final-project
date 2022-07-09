%{
   #include "y.tab.h"
%}

digit       		[0-9]
digit_1     	[1-9]

number      	0|{digit_1}{digit}*|\-{digit_1}{digit}*
%%
"print-num"     {return printnum;}
"print-bool"    {return printbool;}
{number}        {yylval.ival = atoi(yytext); return(number);}
"#t"			{return true;}
"#f"			{return false;}
"+"     		{return(yytext[0]);}
"-"    		{return(yytext[0]);}
"*"     		{return(yytext[0]);}
"/"     		{return(yytext[0]);}
"mod"           	{return modulus;}
"and"           	{return And;}
"or"            	{return Or;}
"not"          	{return Not;}
[\t\n\r ]       	{}
.			{return(yytext[0]);}
%%
