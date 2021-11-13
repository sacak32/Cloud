/* cloud_parser.y */

%{
#include <stdio.h>
%}

%token INT_LITERAL
%token CHAR_LITERAL	L_PAREN	R_PAREN	ASSIGN_OP
%token PLUS_OP	MINUS_OP	MULT_OP	MODULUS_OP
%token DIVIDE_OP	COMMA  
%token SEMICOLON
%token BEGIN_STMT	END_STMT	END_IF	END_WHILE   	END_FOR	END_FUNC
%token TYPE_VOID	TYPE_INT	TYPE_STRING	TYPE_CHAR	TYPE_BOOL	AND    
%token OR	NOT	RETURN	STRING_LITERAL
%token PRINT     SCAN     PRINT_TO_FILE     SCAN_FROM_FILE
%token IF	ELIF	ELSE	FOR	WHILE    
%token GET_INCLINATION   	 GET_ALTITUDE    GET_TEMPERATURE
%token GET_ACCELERATION   	 TURN_ON_CAMERA    TURN_OFF_CAMERA
%token TAKE_PICTURE    GET_TIMESTAMP     CONNECT_BASE    IS_CAMERA_ACTIVE  
%token IDENTIFIER
%token TRUE_LITERAL  FALSE_LITERAL
%token EQUAL_OP	INEQUAL_OP	LESS_THAN_OP	GREATER_THAN_OP
%token LESS_OR_EQ_OP	GREATER_OR_EQ_OP 	PLUS_AND_ASSIGN_OP	MINUS_AND_ASSIGN_OP
%token MULT_AND_ASSIGN_OP	DIVIDE_AND_ASSIGN_OP	MODULUS_AND_ASSIGN_OP	 
%token UNIDENTIFIED

%%


program    	 :     BEGIN_STMT stmts END_STMT
   			 {printf("Input program is valid\n"); return 0;}
   		 |    function_def program
   			 {printf("Input program is valid\n"); return 0;}
   		 ;

stmts   		 :     
   		 |    stmt stmts
   		 ;

stmt   		 :     function_call SEMICOLON
   		 |     assignment SEMICOLON
   		 |    while_stmt
   		 |    if_stmt
   		 |    for_stmt
   		 |    variable_declaration SEMICOLON
   		 |    return_stmt SEMICOLON   				      
   		 ;

variable_declaration    :     variable_type ident_init     
   		 |    variable_declaration COMMA ident_init
   		 ;

variable_type   	 :    TYPE_INT    
   		 |     TYPE_CHAR
   		 |     TYPE_STRING
   		 |    TYPE_BOOL    
   		 ;
   	 
ident_init    	 :     assignment
   		 |     IDENTIFIER
   		 ;    

assignment   	 :     IDENTIFIER assignment_op assignment_expr
   		 ;

assignment_expr     :    logical_or
   		 |    assignment   		      
   		 ;

assignment_op    	 :    ASSIGN_OP    	 
   		 |    PLUS_AND_ASSIGN_OP
   		 |    MINUS_AND_ASSIGN_OP
   		 |    MULT_AND_ASSIGN_OP
   		 |    DIVIDE_AND_ASSIGN_OP
   		 |     MODULUS_AND_ASSIGN_OP
   		 ;

expression    	 :    assignment_expr
   		 ;
   		 
logical_or   	 :     logical_or OR logical_and
   		 |     logical_and
   		 ;

logical_and    	 :     logical_and AND equality_expr
   		 |    equality_expr   			 
   		 ;

equality_expr   	 :     equality_expr equality_op relat_expr
   		 |    relat_expr   			 
   		 ;

equality_op    	 :    EQUAL_OP
   		 |    INEQUAL_OP   			 
   		 ;

relat_expr   	 :     relat_expr relat_op additive_expr
   		 |    additive_expr   			 
   		 ;

relat_op   	 :     LESS_THAN_OP    
   		 |    LESS_OR_EQ_OP
   		 |    GREATER_THAN_OP
   		 |    GREATER_OR_EQ_OP
   		 ;

additive_expr    	 :    additive_expr additive_op multiplicative_exp
   		 |    multiplicative_exp    
   		 ;

additive_op   	 : 	 PLUS_OP
   		 |    MINUS_OP   			 
   		 ;

multiplicative_exp    :     multiplicative_exp multiplicative_op unary_exp
   		 |    unary_exp
   		 ;

multiplicative_op    :     MULT_OP
   		 |     DIVIDE_OP
   		 |     MODULUS_OP
   		 ;
   		 
unary_exp   	 :     unary_op unary_exp    
   		 |    parenth    
   		 ;

unary_op   	 :     PLUS_OP    
   		 |    MINUS_OP
   		 |    NOT
   		 ;

parenth   	 :     L_PAREN expression R_PAREN
   		 |     function_call    		 
   		 |    const   			 
   		 |    IDENTIFIER
   		 ;

const   		 :     INT_LITERAL    
   		 |    STRING_LITERAL    
   		 |     CHAR_LITERAL    
   		 |    bool_literal
   		 ;

bool_literal   	 :     TRUE_LITERAL
   		 |    FALSE_LITERAL
   		 ;

while_stmt   	 :    WHILE L_PAREN expression R_PAREN stmts END_WHILE
   		 ;


for_stmt   	 :     FOR L_PAREN for_init SEMICOLON expression SEMICOLON for_assignment R_PAREN stmts END_FOR
   		 ;


for_init   	 :     variable_declaration
   		 |    assignment
   		 ;

for_assignment   	 :    /* empty */
   		 |    assignment

if_stmt   	 :    IF L_PAREN expression R_PAREN stmts END_IF    	 
   		 |    IF L_PAREN expression R_PAREN stmts ELSE stmts END_IF
   		 |    IF L_PAREN expression R_PAREN stmts elif_stmts END_IF
   		 ;

elif_stmts   	 :     ELIF L_PAREN expression R_PAREN stmts   		 
   		 |    ELIF L_PAREN expression R_PAREN stmts ELSE stmts    
   		 |    ELIF L_PAREN expression R_PAREN stmts elif_stmts
   		 ;

function_def   	 :     func_return_type func_name L_PAREN parameters R_PAREN stmts END_FUNC
   		 ;

func_return_type    :     TYPE_VOID
   		 |    variable_type
   		 ;

parameters   	 :     /* empty */
   		 |    parameter_list
   		 
parameter_list     :     parameter
   		 |     parameter COMMA parameter_list
   		 ;


parameter   	 :     variable_type IDENTIFIER
   		 ;
   		 
func_name    	 :    IDENTIFIER
   		 ;
   		 
return_stmt   	 : 	 RETURN expression
   		 |    RETURN
   		 ;

function_call    	 :    defined_function_call
   		 |    primitive_function_call
   		 |    input_output_function_call
   		 ;

defined_function_call    :    defined_function_name L_PAREN arguments R_PAREN
   		 ;
   		 
arguments   	 : 	 /* empty */
   		 |    argument_list
   		 ;

argument_list   	 :    argument
   		 |    argument COMMA argument_list
   		 ;

argument   	 :    expression
   		 ;
   		 
defined_function_name    : 	 IDENTIFIER    	     	 
   		 ;

input_output_function_call    :     input_output_function_name L_PAREN arguments R_PAREN
   			 ;

input_output_function_name    :     PRINT
   			 |     SCAN
   			 |    PRINT_TO_FILE
   			 |    SCAN_FROM_FILE
   			 ;

primitive_function_call :    primitive_function_name L_PAREN R_PAREN

primitive_function_name :    GET_INCLINATION     
   		 |    GET_ALTITUDE    
   		 |    GET_TEMPERATURE     
   		 |     GET_ACCELERATION    
   		 |    TURN_ON_CAMERA    	 
   		 |    TURN_OFF_CAMERA   	 
   		 |    TAKE_PICTURE     
   		 |    GET_TIMESTAMP    
   		 |    CONNECT_BASE    
   		 |     IS_CAMERA_ACTIVE
   		 ;
   		 
%%

#include "lex.yy.c"
yyerror(char *s) { extern int lineno; printf("%s on line %d!\n", s, lineno); }
main() {
	return yyparse();
}
