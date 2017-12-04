delimiter $$

DROP							FUNCTION	IF EXISTS	zxitMySQL.decimalToTime	$$
CREATE DEFINER=`iletrong`@`%`	FUNCTION 				zxitMySQL.decimalToTime	(

$DecimalTime					DECIMAL(18,9)

) RETURNS 						TIME

								DETERMINISTIC
								CONTAINS SQL

COMMENT 						'Version 1.0 - Retourne la valeur d\'un decimal converti en unité time'

BEGIN
/* ===================================================================================================================
**	decimalToTime()				Retourne la valeur d'un decimal converti en unité time
**	------------------------------------------------------------------------------------------------------------------
**	Auteur				:		IT-DaaS - Isabelle LE TRONG
**	Version 			:		1.0
**	Date de version		:		2015-09-15
**	------------------------------------------------------------------------------------------------------------------
**	TRANSACTIONNELLE 	:		NON
**	------------------------------------------------------------------------------------------------------------------
**	PARAMETRES
**
**	$DecimalTime				DECIMAL(18,9)		:	Durée exprimée en décimale Ex : 1h30 = 1.5000
** ===================================================================================================================
**
** (V) Variables Locales
*/
DECLARE	$Version			DECIMAL(4,2)	UNSIGNED	DEFAULT	1.0													;
DECLARE	$HourUnit			DECIMAL(18,0)																			;
DECLARE	$MinuteUnit			DECIMAL(18,0)																			;
DECLARE	$SecondUnit			DECIMAL(18,0)																			;
/*
**	(1)	Initialise Local variables
*/
IF		($DecimalTime >=	0)
THEN	SET	$HourUnit	=	FLOOR($DecimalTime)																		;
		SET	$MinuteUnit	=	FLOOR(($DecimalTime-$HourUnit)	*	60	)												;
		SET	$SecondUnit	=	FLOOR(3600*($DecimalTime - $HourUnit) - 60*$MinuteUnit)									;
ELSE	SET	$HourUnit	=	CEIL($DecimalTime)																		;
		SET	$MinuteUnit	=	FLOOR(($HourUnit - $DecimalTime)	*	60	)											;
		SET	$SecondUnit	=	FLOOR(3600*($HourUnit - $DecimalTime) - 60*$MinuteUnit)									;
END IF																												;
/*
**	(EXIT)	Return time value
*/
RETURN(CAST(CONCAT(CAST($HourUnit AS CHAR),':',CAST($MinuteUnit AS CHAR),':',CAST($SecondUnit AS CHAR)) AS TIME))	;

END
$$

