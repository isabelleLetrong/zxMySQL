SELECT 	*
FROM 	INFORMATION_SCHEMA.ROUTINES

WHERE 	ROUTINE_TYPE	=	'FUNCTION' 
	AND ROUTINE_SCHEMA	=	'zxitMySQL'
	AND	ROUTINE_NAME	=	'$Statics_set'
;
