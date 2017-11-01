delimiter $$

DROP							FUNCTION	IF	EXISTS	zxitMySQL.$UserException_set	$$
CREATE	DEFINER=`iletrong`@`%`	FUNCTION 				zxitMySQL.$UserException_set	(

$Status							INTEGER(10)	UNSIGNED									,
$Step							INTEGER(10)	UNSIGNED

) RETURNS 						INTEGER(10)	UNSIGNED

								DETERMINISTIC
								CONTAINS SQL

COMMENT							'Version 1.0 - Générère une Exception utilisateur'

BEGIN
/* =======================================================================================================
**	$UserException_set()		Générère une Exception utilisateur
**	------------------------------------------------------------------------------------------------------
**	Auteur			:	IT-DaaS	-	Isabelle LE TRONG
**
**	Versions 		:	1.0		2017-03-24	Version initiale
**	------------------------------------------------------------------------------------------------------
**	PARAMETRES
**
**	$Status		INTEGER(10) 	UNSIGNED		:	Valeur du CodeRetour $Status
**	$Step		INTEGER(10)		UNSIGNED		:	Etape atteinte
**												
** =======================================================================================================
**
**	(V)	Variables locales
*/
DECLARE	$Version	DECIMAL(4,2)	UNSIGNED	DEFAULT	1.0												;
DECLARE	$Msg		VARCHAR(128)																		;
DECLARE	$MsgMaxSize	TINYINT(3)		UNSIGNED	DEFAULT	128												;
/*
**	(2)	Get $Status Description
*/
SET		$Msg	=	SUBSTRING(	CONCAT(	'Exception : Step '							,
										CAST($Step	AS	CHAR)						,
										' - '										,
										zxitMySQL.$Status_getDescription($Status)	)	,
								1, $MsgMaxSize											)				;
/*
**	(EXIT)
*/
SIGNAL	SQLSTATE				'45000'										/*	$User Exception'	*/
		SET	MESSAGE_TEXT 	=	$Msg																	,
			MYSQL_ERRNO 	= 	1644																	;

RETURN	$Status																							;
END
$$

