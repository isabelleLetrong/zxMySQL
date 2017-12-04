delimiter $$

DROP							FUNCTION	IF EXISTS	zxitMySQL.firstDayOfYear	$$
CREATE DEFINER=`iletrong`@`%`	FUNCTION 				zxitMySQL.firstDayOfYear	(

$Year							YEAR(4)	

) RETURNS 						DATE

								DETERMINISTIC
								CONTAINS SQL

COMMENT 						'Version 1.0 - Retourne le premier jour de l\'année spécifiée'

BEGIN
/* ===============================================================================================
**	firstDayOfYear()	Retourne le premier jour de l'année spécifiée
**
**	Auteur			:	IT-DaaS - Isabelle LE TRONG
**	Version 		:	1.0
**	Date de version	:	2015-11-09
**	----------------------------------------------------------------------------------------------
**	TRANSACTIONNELLE 		NON
**	----------------------------------------------------------------------------------------------
**	PARAMETRES
**
**	$Date		DATE		:	Date de référence
** ===============================================================================================
**
** (V) Variables Locales
*/
DECLARE	$Version	DECIMAL(4,2)	UNSIGNED	DEFAULT	1.0				;
/*
**	(1)		Return requested date
*/
RETURN	CAST(CONCAT($Year,'-01-01') AS DATE)							;

END
$$

