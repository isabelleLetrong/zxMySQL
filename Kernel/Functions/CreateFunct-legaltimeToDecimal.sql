delimiter $$

DROP							FUNCTION	IF EXISTS	zxitMySQL.legaltimeToDecimal	$$
CREATE DEFINER=`iletrong`@`%`	FUNCTION 				zxitMySQL.legaltimeToDecimal	(

$Time							TIME

) RETURNS 						DECIMAL(6,4)

								DETERMINISTIC
								CONTAINS SQL

COMMENT 						'Version 1.0 - Converti une variable time legal positive en la valeur decimale correspondante'

BEGIN
/* ===============================================================================================
**	legaltimeToDecimal()		Converti une variable time legal (de 00:00:00 à 23:59:59)
**								positive en la valeur decimale correspondante
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
DECLARE	$DecimalTime			DECIMAL(6,4)													;
/*
**	(1)	Compute Time
*/
IF		(isLegalTime($Time) = 1)
THEN	SET	$DecimalTime	=	zxitMySQL.timeToDecimal($Time)									;
ELSE	SET	$DecimalTime	=	NULL															;
END IF																							;
/*
**	(EXIT)	Return time value
*/
RETURN($DecimalTime)																			;

END$$

