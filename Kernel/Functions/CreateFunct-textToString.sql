delimiter $$

DROP							FUNCTION	IF	EXISTS	zxitMySQL.textToString	$$
CREATE DEFINER=`iletrong`@`%` 	FUNCTION 				zxitMySQL.textToString	(

$InputText						TEXT

) RETURNS 						VARCHAR(255) 			CHARSET utf8

								DETERMINISTIC
								CONTAINS SQL

COMMENT							'Version 1.0 - Nettoie le paramètre text et retourne un varchar(255)'
BEGIN
/* ======================================================================================================================
**	textToString()		Nettoie le paramètre text et retourne un varchar(255)
**	---------------------------------------------------------------------------------------------------------------------
**	Auteur			:	IT-Daas	-	Isabelle LE TRONG
**
**	Versions 		:	1.0		2017-05-04	Version initiale
**	---------------------------------------------------------------------------------------------------------------------
**	PARAMETRES
**
**	$InputText			TEXT	:	Text à traiter
** ======================================================================================================================
**
**	(V)	Variables locales
*/
DECLARE	$Version			DECIMAL(4,2)	UNSIGNED	DEFAULT	1.0														;
DECLARE	$OutputString		VARCHAR(255)																				;
DECLARE	$UnwelcomeString	VARCHAR(16)					DEFAULT	'\b\n\r\t'												;
DECLARE	$Space				VARCHAR(1)					DEFAULT	' '														;

/*
**	(H) HANDLERs
*/
DECLARE	EXIT	HANDLER	FOR SQLEXCEPTION	
BEGIN
		SET		$OutputString	=	NULL																				;
		RETURN	$OutputString																							;
END																														;
/*
**	(1)	Truncate InputText
*/
SET		$OutputString	=	LEFT($InputText, 255)																		;
SET		$OutputString	=	zxitMySQL.string_cleanUp($OutputString, $UnwelcomeString, $Space)							;
/*
**	(EXIT)
*/
RETURN	$OutputString																									;

END
$$

