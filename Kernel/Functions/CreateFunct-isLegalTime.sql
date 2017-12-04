delimiter $$

DROP							FUNCTION	IF EXISTS	zxitMySQL.isLegalTime	$$
CREATE DEFINER=`iletrong`@`%`	FUNCTION 				zxitMySQL.isLegalTime	(

$Time							TIME

) RETURNS 						BIT(1)

								DETERMINISTIC
								CONTAINS SQL

COMMENT 						'Version 1.0 - Retourne 1 si \'00:00:00\' <= $Time < \'24:00:00\''

BEGIN
/* ===============================================================================================
**	isLegalTime()				Retourne 1 si '00:00:00' <= $Time < '24:00:00'
**	----------------------------------------------------------------------------------------------
**	Auteur				:		IT-DaaS - Isabelle LE TRONG
**	Version 			:		1.0
**	Date de version		:		2015-09-15
**	----------------------------------------------------------------------------------------------
**	TRANSACTIONNELLE 	:		NON
**	----------------------------------------------------------------------------------------------
**	PARAMETRES
**
**	$Time						TIME		:	Heure légale
** ===============================================================================================
**
** (V) Variables Locales
*/
DECLARE	$Version				DECIMAL(4,2)	UNSIGNED	DEFAULT	1.0							;
DECLARE	$MidNight				TIME			DEFAULT	'00:00:00'								;
DECLARE	$NextDay				TIME			DEFAULT	'24:00:00'								;
DECLARE	$IsLegalTime			BIT(1)															;
/*
**	(1)	Test supplied legal time
*/
IF		(	$Time	>=	$MidNight
		AND	$Time	<	$NextDay
		)
THEN	SET	$IsLegalTime	=	1																;
ELSE	SET	$IsLegalTime	=	0																;
END IF																							;
/*
**	(EXIT)	Return time value
*/
RETURN($IsLegalTime)																			;

END
$$

