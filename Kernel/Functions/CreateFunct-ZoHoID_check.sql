delimiter $$

DROP 							FUNCTION	IF	EXISTS	zxitMySQL.ZoHoID_check	$$
CREATE DEFINER=`iletrong`@`%` 	FUNCTION 				zxitMySQL.ZoHoID_check	(

$ZoHoID							BIGINT(20)

) RETURNS 						BIT(1)

								DETERMINISTIC
								CONTAINS SQL

COMMENT							'Version 1.0 - Valide la syntaxe d\'un identifiant ZoHo CRM'
BEGIN
/* ===================================================================================================================
**	ZoHoID_check()		Valide la syntaxe d'un identifiant ZoHo CRM
**	------------------------------------------------------------------------------------------------------------------
**	Auteur			:		Isabelle LE TRONG
**
**	Versions 		:		1.0		2017-04-25	Version initiale
**	------------------------------------------------------------------------------------------------------------------
**	PARAMETRES
**
**	$Email					VARCHAR(255)	:	Numéro de téléphone à vérifier
** ===================================================================================================================
**
**	(V)	Variables locales
*/
DECLARE	$Version			DECIMAL(4,2)	UNSIGNED	DEFAULT	1.0													;
DECLARE	$StringZohoID		VARCHAR(32)																				;
DECLARE	$CheckZoHoID		BIT(1)																					;
DECLARE	$RegExpStatus		TINYINT(1)																				;
/*
**	(H) HANDLERs
*/
DECLARE	EXIT	HANDLER	FOR SQLEXCEPTION	
BEGIN
		SET		$CheckZoHoID	=	NULL																			;
		RETURN	$CheckZoHoID																						;
END																													;
/*
**	(0)	Set internal datas
*/
SET		$CheckZoHoID		=	b'0'																				;
SET		$StringZohoID		=	CAST($ZoHoID AS	CHAR)																;
/*
**	(1)	Check character set
*/
SELECT	$StringZohoID	REGEXP	'^[+(0-9]{18}$'
INTO	$RegExpStatus																								;

IF		($RegExpStatus			=	1)
THEN	SET	$CheckZoHoID		=	b'1'																			;
END IF																												;
/*
**	(EXIT)
*/
RETURN	$CheckZoHoID																								;

END
$$

