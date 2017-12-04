delimiter $$

DROP							FUNCTION	IF EXISTS	zxitMySQL.timeToDecimal	$$
CREATE DEFINER=`iletrong`@`%`	FUNCTION 				zxitMySQL.timeToDecimal	(

$Time							TIME

) RETURNS 						DECIMAL(7,4)

								DETERMINISTIC
								CONTAINS SQL

COMMENT 						'Version 1.0 - Convertie un temps/durée en decimal'

BEGIN
/* ===============================================================================================
**	timeToDecimal()				Convertie un temps en decimal - le temps doit être positif
**								Ex : 1h30 = 1.5000
**	----------------------------------------------------------------------------------------------
**	Auteur				:		IT-DaaS - Isabelle LE TRONG
**	Version 			:		1.0
**	Date de version		:		2015-09-15
**	----------------------------------------------------------------------------------------------
**	TRANSACTIONNELLE 	:		NON
**	----------------------------------------------------------------------------------------------
**	PARAMETRES
**
**	$Time						TIME		:	Durée (temps)
** ===============================================================================================
**
**	(V)	Variables locales
*/
DECLARE	$Version				DECIMAL(4,2)	UNSIGNED	DEFAULT	1.0							;
DECLARE	$DecimalTime			DECIMAL(7,4)													;
/*
**	(1)	Compute Decimal Time
*/
IF	($Time > 0)
THEN	SET	$DecimalTime	=	CAST(	HOUR($Time)+MINUTE($Time)/60 +SECOND($Time)/3600
								AS	DECIMAL(7,4))												;
ELSE	SET	$DecimalTime	=	NULL															;
END IF																							;
/*
**	(EXIT)
*/
RETURN($DecimalTime)																			;
END
$$

