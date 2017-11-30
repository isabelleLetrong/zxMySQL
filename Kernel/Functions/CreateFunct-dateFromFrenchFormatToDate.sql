delimiter $$

DROP							FUNCTION	IF EXISTS	zxitMySQL.dateFromFrenchFormatToDate	$$
CREATE DEFINER=`iletrong`@`%` 	FUNCTION 				zxitMySQL.dateFromFrenchFormatToDate	(

$FrenchDate						VARCHAR(10)

) RETURNS 						DATE

								DETERMINISTIC
								CONTAINS SQL

COMMENT 						'Version 1.1 - Convertie une Date au format JJ/MM/AAAA - Utilisation de STR_TO_DATE()'

BEGIN
/* ======================================================================================================
**	dateFromFrenchFormatToDate()		Convertie une Date au format JJ/MM/AAAA
**										vers le format AAAA-MM-JJ
**	-----------------------------------------------------------------------------------------------------
**	Auteur			:	IT-DaaS	-	Isabelle LE TRONG
**
**	Versions 		:	2.0		2017-11-24	Utilisation de STR_TO_DATE()
**						1.0		2017-05-17	Version initiale
**	-----------------------------------------------------------------------------------------------------
**	PARAMETRES
**
**	$FrenchDate			VARCHAR(10)		:	Date au format français
** ======================================================================================================
**
** (V) Variables Locales
*/
DECLARE	$Version	DECIMAL(4,2)	UNSIGNED	DEFAULT	2.0												;
/*
**	(H) HANDLERs
*/
DECLARE	EXIT	HANDLER	FOR SQLEXCEPTION	
BEGIN
		RETURN	NULL																					;
END																										;
/*
**	(1)	Convert string
**
*/
RETURN	(SELECT	STR_TO_DATE($FrenchDate,'%d/%m/%Y'))													;

END
$$

