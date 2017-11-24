delimiter $$

DROP							FUNCTION	IF EXISTS	zxitMySQL.dateToFrenchFormat	$$
CREATE DEFINER=`iletrong`@`%`	FUNCTION 				zxitMySQL.dateToFrenchFormat	(

$DateReference					DATE

) RETURNS 						VARCHAR(10) CHARSET 	utf8

								DETERMINISTIC
								CONTAINS SQL

COMMENT							'Version 1.0 - Convertie une Date au format JJ/MM/AAAA'

BEGIN
/* ===============================================================================================
**	dateToFrenchFormat()		-	Convertie une Date au format JJ/MM/AAAA
** ===============================================================================================
**
** (V) Variables Locales
*/
DECLARE	$Version			DECIMAL(4,2)	UNSIGNED	DEFAULT	1.0		;
/*
**	(1)	Convert Date
*/
RETURN	(SELECT	DATE_FORMAT($DateReference,'%d/%m/%Y'))					;			
END
$$

