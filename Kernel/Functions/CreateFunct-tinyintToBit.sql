delimiter $$

DROP							FUNCTION	IF EXISTS	zxitMySQL.tinyintToBit	$$	
CREATE DEFINER=`iletrong`@`%` 	FUNCTION 				zxitMySQL.tinyintToBit	(

$Tinyint_1						TINYINT(1)

) RETURNS						BIT(1)

								DETERMINISTIC
								CONTAINS SQL

COMMENT							'Version 1.0 - Convertion d\'un entier booléen en bit'
BEGIN
/* ===================================================================================================================
**	tinyintToBit()		Convertion d'un entier booléen en bit
**	------------------------------------------------------------------------------------------------------------------
**	Auteur			:	IT-DaaS	-	Isabelle LE TRONG
**
**	Versions 		:	1.0		2017-04-24	Version initiale
**	------------------------------------------------------------------------------------------------------------------
**	PARAMETRES
**
**	$Tinyint_1			TINYINT(1)	:	Entier à convertir
** ===================================================================================================================
**
**	(V)	Variables locales
*/
DECLARE	$ConvertedBit	BIT(1)																			;
															
/*
**	(H) HANDLERs
*/
DECLARE	EXIT	HANDLER	FOR SQLEXCEPTION	
BEGIN
		SET		$ConvertedBit	=	NULL																;
		RETURN	$ConvertedBit																			;
END																										;
/*
**	(0)	Set $ConvertedBit
*/
IF		($Tinyint_1		=	0)
THEN	SET	$ConvertedBit	=	b'0'																	;
ELSE	SET	$ConvertedBit	=	b'1'																	;
END IF																									;
/*
**	(EXIT)
*/
RETURN	$ConvertedBit																					;

END
$$

