delimiter $$

DROP							FUNCTION	IF	EXISTS	zxitMySQL.bitToTinyint	$$
CREATE DEFINER=`iletrong`@`%` 	FUNCTION 				zxitMySQL.bitToTinyint	(

$BinaryDigit					BIT(1)

) RETURNS 						TINYINT(1)

								DETERMINISTIC
								CONTAINS SQL

COMMENT							'Version 1.0 - Convertion d\'un bit en entier'

BEGIN
/* ===================================================================================================================
**	bitToTinyint()		Convertion d'un bit en entier
**	------------------------------------------------------------------------------------------------------------------
**	Auteur			:	IT-DaaS	-	Isabelle LE TRONG
**
**	Versions 		:	1.0		2017-05-17	Version initiale
**	------------------------------------------------------------------------------------------------------------------
**	PARAMETRES
**
**	$BinaryDigit		BIT(1)		:	Bit à convertir
** ===================================================================================================================
**
**	(V)	Variables locales
*/
DECLARE	$Version			DECIMAL(4,2)		UNSIGNED	DEFAULT	1.0									;
DECLARE	$ConvertedInt		TINYINT(1)																	;
DECLARE	$OFF				BIT(1)				DEFAULT	b'0'											;
/*
**	(H) HANDLERs
*/
DECLARE	EXIT	HANDLER	FOR SQLEXCEPTION	
BEGIN
		SET		$ConvertedInt	=	NULL																;
		RETURN	$ConvertedInt																			;
END																										;
/*
**	(0)	Set $ConvertedInt
*/
IF		($BinaryDigit		=	$OFF)
THEN	SET	$ConvertedInt	=	0																		;
ELSE	SET	$ConvertedInt	=	1																		;
END IF																									;
/*
**	(EXIT)
*/
RETURN	$ConvertedInt																					;

END
$$

