/* lexical-analysis.l */
%{
int lineno = 1;
int i;
char str[100000];
%}

alphabetic            	[A-Za-z_$]
digit                	[0-9]
alphanumeric            	({alphabetic}|{digit})
sign                	[+-]
start_comment             	\#\-
end_comment            	\-\#
between_quotes            	\".*?\"
%%    
begin                	return BEGIN_STMT ;
end                		return END_STMT ;
endif                	return END_IF ;
endwhile            	return END_WHILE ;
endfor            		return END_FOR ;
endfunc            		return END_FUNC ;
True                	return TRUE_LITERAL ;
False                	return FALSE_LITERAL ;
void                	return TYPE_VOID ;
int                		return TYPE_INT ;
string                	return TYPE_STRING ;
char                	return TYPE_CHAR ;
bool                	return TYPE_BOOL ;
AND                		return AND ;
OR                		return OR ;
NOT                		return NOT ;
if                		return IF ;
elif                	return ELIF ;
else                	return ELSE ;
for                		return FOR ;
while                	return WHILE ;
return            		return RETURN ;
\(                		return L_PAREN ;
\)                		return R_PAREN ;
\=                		return ASSIGN_OP ;
\=\=                	return EQUAL_OP ;
\!\=                	return INEQUAL_OP ;
\<                		return LESS_THAN_OP ;
\>                		return GREATER_THAN_OP ;
\<\=                	return LESS_OR_EQ_OP ;
\>\=                	return GREATER_OR_EQ_OP ;
\+                		return PLUS_OP ;
\-                		return MINUS_OP ;
\*                		return MULT_OP ;
\+\=                	return PLUS_AND_ASSIGN_OP ;
\-\=                	return MINUS_AND_ASSIGN_OP ;
\*\=                	return MULT_AND_ASSIGN_OP ;
\/\=                	return DIVIDE_AND_ASSIGN_OP ;
\%\=                	return MODULUS_AND_ASSIGN_OP ;
\%                		return MODULUS_OP ;
\/                		return DIVIDE_OP ;
\,                		return COMMA ;
\;                		return SEMICOLON ;
print                	return PRINT ;
scan                	return SCAN ;
print_to_file         	return PRINT_TO_FILE;
scan_from_file         	return SCAN_FROM_FILE;
get_inclination        	return GET_INCLINATION ;
get_altitude            return GET_ALTITUDE ;
get_temperature        	return GET_TEMPERATURE ;
get_acceleration       	return GET_ACCELERATION ;
turn_on_camera        	return TURN_ON_CAMERA ;
turn_off_camera     	return TURN_OFF_CAMERA ;
take_picture            return TAKE_PICTURE ;
get_timestamp        	return GET_TIMESTAMP ;
connect_base        	return CONNECT_BASE ;
is_camera_active        return IS_CAMERA_ACTIVE ;
{alphabetic}{alphanumeric}*    	return IDENTIFIER ;
{digit}+            	return INT_LITERAL ;
{between_quotes}        return STRING_LITERAL ;
\'.\'                	return CHAR_LITERAL ;
{start_comment}(\n|[^#])*{end_comment} 	{ for(i = 0; yytext[i]!='\0'; i++){
                            	if( yytext[i]  == '\n' ){
                                	lineno++;
                            	}
                        	}
                      	}

\#.*\n                	lineno++ ;
[ \t]+                	/* spaces are ignored */ ;
\n             			lineno++;
.                		return UNIDENTIFIED ;
%%
int yywrap() { return 1; }
