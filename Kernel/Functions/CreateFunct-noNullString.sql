delimiter $$

DROP							FUNCTION	IF EXISTS	zxitMySQL.noNullString	$$
CREATE 	DEFINER=`iletrong`@`%`	FUNCTION 				zxitMySQL.noNullString	(

$InputString					VARCHAR(255)

) RETURNS						VARCHAR(255)			CHARSET utf8

								DETERMINISTIC
								CONTAINS SQL

COMMENT							'Version 1.0 - retourne un string vide si le  string est marqué NULL'
BEGIN
/* ======================================================================================================================
**	noNullString()		Retourne :	- un string vide si le  string est marqué NULL
**									- le string d'origine dans le cas contraire
**	---------------------------------------------------------------------------------------------------------------------
**	Auteur			:	IT-Daas	-	Isabelle LE TRONG
**
**	Versions 		:	1.0		2017-05-04	Version initiale
**	---------------------------------------------------------------------------------------------------------------------
**	PARAMETRES
**
**	$InputString		VARCHAR(255)	:	string à traiter
** ======================================================================================================================
**
**	(V)	Variables locales
*/
DECLARE	$OutputString	VARCHAR(255)			DEFAULT	''						;
/*
**	(H) HANDLERs
*/
DECLARE	EXIT	HANDLER	FOR SQLEXCEPTION	
BEGIN
		SET		$OutputString	=	NULL										;
		RETURN	$OutputString													;
END																				;
/*
**	(1)	Check NULL case
*/
IF		($InputString	IS NOT NULL)
THEN	SET		$OutputString	=	$InputString								;
END IF																			;		
/*
**	(EXIT)
*/
RETURN	$OutputString															;

END
$$

