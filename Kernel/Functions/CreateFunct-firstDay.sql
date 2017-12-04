delimiter $$

DROP							FUNCTION	IF EXISTS	zxitMySQL.firstDay	$$
CREATE DEFINER=`iletrong`@`%`	FUNCTION 				zxitMySQL.firstDay	(

$Date							DATE	

) RETURNS 						DATE

								DETERMINISTIC
								CONTAINS SQL

COMMENT 						'Version 1.0 - Retourne le premier jour du mois de la date spécifiée'
BEGIN
/* ===============================================================================================
**	firstDay()			Retourne le premier jour du mois de la date spécifiée
**
**	Auteur			:	IT-DaaS - Isabelle LE TRONG
**	Version 		:	1.0
**	Date de version	:	2015-09-15
**	---------------------------------------------------------------------------------------------------
**	TRANSACTIONNELLE 		NON
**	---------------------------------------------------------------------------------------------------
**	PARAMETRES
**
**	$Date		DATE		:	Date courante
** ===============================================================================================
**
** (V) Variables Locales
*/
DECLARE	$Version	DECIMAL(4,2)	UNSIGNED	DEFAULT	1.0			;
/*
**	(1)		Return requested date
*/
RETURN	CAST(CONCAT(YEAR($Date),'-',MONTH($Date),'-01') AS DATE)	;

END
$$

