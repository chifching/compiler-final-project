%{
    #include <stdio.h>
    void yyerror(const char*);
%}

%union{
    int ival;
}

%token printnum
%token printbool
%token <ival> number
%token true false
%token modulus
%token And Or Not
%type <ival> EXP
%type <ival> bool_val
%type <ival> Num_Op
%type <ival> Plus Plus_Recursion
%type <ival> Multiply Multiply_Recursion
%type <ival> Minus
%type <ival> Divide
%type <ival> Modulus
%type <ival> Logical_Op
%type <ival> AND_OP AND_OP_Recursion
%type <ival> OR_OP OR_OP_Recursion
%type <ival> NOT_OP
%%
//This is Grammar and Behavior Definition
//1. Program
STMTs : STMTs STMT| STMT
	;
STMT :Print_STMT
 	   |EXP
	   ;
//2. Print
Print_STMT: '(' printnum EXP ')'  
			{ 
				printf("%d\n",$3); 
			}
			| '(' printbool EXP ')' 
			{ 
				if(1==$3) 
					printf("#t\n");
				else  
					printf("#f\n");
     			 }
		;
//3. Expression(EXP)
EXP  : bool_val 
	| number 
	| Num_Op 
	| Logical_Op 
	;
bool_val : true  { $$=1; } 
		| false { $$=0; }
		; 
//4. Numerical Operations(NUM-OP)
Num_Op: Plus 
		| Minus 
		| Multiply 
		| Divide 
		| Modulus 
		; 
Plus  : '(' Plus_Recursion ')'  
	    { $$=$2; }
	   ;
Plus_Recursion  :  '+' EXP EXP  
				{ $$=$2+$3; }
				| Plus_Recursion EXP  
				{ $$=$1+$2; }
   				;
Multiply : '(' Multiply_Recursion ')'  
		{ $$=$2; }
		;
Multiply_Recursion : '*' EXP EXP  
				    { $$=$2*$3; }
				  | Multiply_Recursion EXP  
				   { $$=$1*$2; }
				   ;
Minus : '(' '-' EXP EXP ')' 
		{ $$=$3-$4; } 
		;

Divide  : '(' '/' EXP EXP ')' 
		{ $$=$3/$4; }
		;
Modulus : '(' modulus EXP EXP ')'
		{ $$=$3%$4; }
		;
//5. Logical Operations(LOGICAL-OP)
Logical_Op 	: AND_OP 
			| OR_OP 
			|NOT_OP
			;
AND_OP  : '(' AND_OP_Recursion ')'  
		  { $$=$2; }
		  ;
AND_OP_Recursion :  And EXP EXP 
					{ if(1==$2 && 1==$3) 
						$$=1; 
				  	else   
						$$=0; 
					}
				    | AND_OP_Recursion EXP  
					{ if(1==$1 && 1==$2) 
							$$=1;
      			  		else   
							$$=0;
   					}
		;
OR_OP  : '('  OR_OP_Recursion ')'  
		{ $$=$2; }
		;
OR_OP_Recursion : Or EXP EXP 
				{ if(0==$2 && 0==$3) 
						$$=0;
       			 	 else   
						$$=1;
     				}
				| OR_OP_Recursion EXP  
				{ if(0==$1 && 0==$2) 
						$$=0;
       			 	 else   
						$$=1;
     				}					
   		;
NOT_OP  : '(' Not EXP ')' 
				{ if(1==$3)  
						$$=0;
				  else   
						$$=1;
				}
		;
  
%%

void yyerror(const char *message) {
   printf("syntax error\n");
}

int main(void) {
    yyparse();
    return (0);
}