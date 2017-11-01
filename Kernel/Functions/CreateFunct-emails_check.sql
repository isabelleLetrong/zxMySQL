delimiter $$

DROP							FUNCTION 		IF EXISTS	zxitMySQL.emails_check	$$
CREATE DEFINER=`iletrong`@`%` 	FUNCTION 					zxitMySQL.emails_check	(

$Email							VARCHAR(255)

) RETURNS 						BIT(1)

								DETERMINISTIC
								CONTAINS SQL

COMMENT							'Version 1.0 - Valide la syntaxe d\'une adresse email'

BEGIN
/* ===================================================================================================================
**	emails_check()		Valide la syntaxe d'une adresse email
**	------------------------------------------------------------------------------------------------------------------
**	Auteur			:	Isabelle LE TRONG
**
**	Versions 		:	1.0		2017-03-23	Version initiale
**	------------------------------------------------------------------------------------------------------------------
**	PARAMETRES
**
**	$Email				VARCHAR(255)	:	Adresse email à vérifier
** ===================================================================================================================
**
**	(V)	Variables locales
*/
DECLARE	$Version		DECIMAL(4,2)	UNSIGNED	DEFAULT	1.0														;
DECLARE	$RegExpStatus	TINYINT(1)																					;
DECLARE	$CheckEmail		BIT(1)																						;
/*
**	(H) HANDLERs
*/
DECLARE	EXIT	HANDLER	FOR SQLEXCEPTION	
BEGIN
		SET		$CheckEmail	=	NULL																				;
		RETURN	$CheckEmail																							;
END																													;
/*
**	(0)	Set internal datas
*/
SET		$CheckEmail	=	b'0'																						;
/*
**	(1)	Check character set
*/
SELECT	$Email	REGEXP	'^[a-zA-Z0-9][a-zA-Z0-9.@_-]*$'
INTO	$RegExpStatus																								;

IF		($RegExpStatus	=	1)
/*
**	(2)	Protect against double '.'
*/		
THEN	SELECT	$Email	NOT REGEXP	'^.*([.\'.\'][.\'.\']).*$'
		INTO	$RegExpStatus																						;

		IF		($RegExpStatus	=	1)
/*
**	(3)	Check email syntax
*/		
		THEN	SELECT	$Email	REGEXP '^[a-zA-Z0-9][a-zA-Z0-9._-]*@[a-zA-Z0-9][a-zA-Z0-9._-]*\\.[a‌​-zA-Z]{2,12}$'
				INTO	$RegExpStatus																				;

				IF		($RegExpStatus	=	1)
				THEN	SET	$CheckEmail	=	b'1'																	;
				END IF																								;
		END IF																										;
END IF																												;
/*
**	(EXIT)
*/
RETURN	$CheckEmail																									;

END
$$

