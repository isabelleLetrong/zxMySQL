delimiter $$

DROP 							FUNCTION	IF	EXISTS	zxitMySQL.phoneNumber_check	$$
CREATE DEFINER=`iletrong`@`%` 	FUNCTION 				zxitMySQL.phoneNumber_check	(

$PhoneNumber					VARCHAR(64)

) RETURNS 						BIT(1)

								DETERMINISTIC
								CONTAINS SQL

COMMENT							'Version 1.0 - Valide la syntaxe d\'une numéro de téléphone'
BEGIN
/* ===================================================================================================================
**	phoneNumber_check()		Valide la syntaxe d'une numéro de téléphone
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
DECLARE	$RegExpStatus		TINYINT(1)																				;
DECLARE	$CheckPhoneNumber	BIT(1)																					;
/*
**	(H) HANDLERs
*/
DECLARE	EXIT	HANDLER	FOR SQLEXCEPTION	
BEGIN
		SET		$CheckPhoneNumber	=	NULL																		;
		RETURN	$CheckPhoneNumber																					;
END																													;
/*
**	(0)	Set internal datas
*/
SET		$CheckPhoneNumber	=	b'0'																				;
/*
**	(1)	Check character set
*/
SELECT	$PhoneNumber	REGEXP	'^[+(0-9][+ (0-9][0-9 ()]*[0-9]$'
INTO	$RegExpStatus																								;

IF		($RegExpStatus			=	1)
THEN	SET	$CheckPhoneNumber	=	b'1'																			;
END IF																												;
/*
**	(EXIT)
*/
RETURN	$CheckPhoneNumber																							;

END
$$

