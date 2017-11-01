delimiter $$

DROP							FUNCTION		IF	EXISTS	zxitMySQL.luhnAlgorithm	$$
CREATE DEFINER=`iletrong`@`%` 	FUNCTION 					zxitMySQL.luhnAlgorithm	(

$StringToCheck					VARCHAR(32)

) RETURNS 						CHAR(1) 		CHARSET 	latin1

								DETERMINISTIC
								CONTAINS SQL

COMMENT							'Version 1.1 - Calcul du chiffre de controle par algorithme de Luhn'

BEGIN
/* ===================================================================================================================
**	luhnAlgorithm()		Calcul du chiffre de controle par algorithme de Luhn
**	------------------------------------------------------------------------------------------------------------------
**	Auteur			:	Isabelle LE TRONG -Inspired by Mats Gefvert
**
**	Versions 		:	1.1		2017-07-26	Substitution de LENGTH() par CHAR_LENGTH()
**						1.0		2017-03-25	Version initiale
**	------------------------------------------------------------------------------------------------------------------
**	PARAMETRES
**
**	$StringToCheck		VARCHAR(32)	:	Adresse email à vérifier
** ===================================================================================================================
**
**	(V)	Variables locales
*/
DECLARE	$Version		DECIMAL(4,2)	UNSIGNED	DEFAULT	1.1														;
DECLARE	$Index			TINYINT(3)																					;
DECLARE	$Sum			TINYINT(3)																					;
DECLARE	$Weight			TINYINT(3)																					;
DECLARE	$DigitValue		TINYINT(3)																					;
DECLARE	$CheckSum		CHAR(1)																						;
/*
**	(H) HANDLERs
*/
DECLARE	EXIT	HANDLER	FOR SQLEXCEPTION	
BEGIN
		SET		$CheckSum	=	NULL																				;
		RETURN	$CheckSum																							;
END																													;
/*
**	(0)	Set internal datas
*/
SET	 	$Weight	=	2																								;
SET 	$Sum	= 	0																								;
SET	 	$Index 	= 	CHAR_LENGTH($StringToCheck)																		;
/*
**	(1)	Check character set
*/
WHILE	($Index > 0)

	DO  SET $DigitValue	=	CAST(SUBSTRING($StringToCheck, $Index, 1)	AS	SIGNED INTEGER) * $Weight				;
        SET $Sum 		= 	$Sum 	+	IF($DigitValue > 9, $DigitValue - 9, $DigitValue)							;
        SET $Index 		= 	$Index 	- 	1																			;
        SET $Weight 	= 	3		-	$Weight																		;
    END WHILE																										;
/*
**	(EXIT)
*/
    SET		$CheckSum	=	CAST(	((10	-	$Sum	% 10)	% 10)	AS	 CHAR(1))								;
	RETURN	$CheckSum																								;
END
$$

