delimiter $$

DROP							FUNCTION	IF EXISTS	zxitMySQL.dateFromFrenchFormatToDate	$$
CREATE DEFINER=`iletrong`@`%` 	FUNCTION 				zxitMySQL.dateFromFrenchFormatToDate	(

$FrenchDate						VARCHAR(10)

) RETURNS 						DATE

								DETERMINISTIC
								CONTAINS SQL

COMMENT							'Version 1.0 - Convertie une Date au format JJ/MM/AAAA'

BEGIN
/* ======================================================================================================
**	dateFromFrenchFormatToDate()		Convertie une Date au format JJ/MM/AAAA
**										vers le format AAAA-MM-JJ
**	------------------------------------------------------------------------------------------------------------------
**	Auteur			:	IT-DaaS	-	Isabelle LE TRONG
**
**	Versions 		:	1.0		2017-05-17	Version initiale
**	------------------------------------------------------------------------------------------------------------------
**	PARAMETRES
**
**	$FrenchDate			VARCHAR(10)		:	Date au format français
** ===================================================================================================================
**
** (V) Variables Locales
*/
DECLARE	$Version	DECIMAL(4,2)	UNSIGNED	DEFAULT	1.0												;
DECLARE	$Date		DATE						DEFAULT	NULL											;
DECLARE	$Year		VARCHAR(4)																			;
DECLARE	$Month		VARCHAR(7)																			;
DECLARE	$Day		VARCHAR(2)																			;
DECLARE	$Delimiter	VARCHAR(1)		DEFAULT'/'															;
DECLARE	$Index1		TINYINT(3)																			;
DECLARE	$Index2		TINYINT(3)																			;
DECLARE	$NextIdx	TINYINT(3)																			;
/*
**	(H) HANDLERs
*/
DECLARE	EXIT	HANDLER	FOR SQLEXCEPTION	
BEGIN
		SET		$Date	=	NULL																		;
		RETURN	$Date																					;
END																										;
/*
**	(1)	$Get $Year, $Month and $Day
**
*/
SET		$Index1		=	LOCATE($Delimiter,$FrenchDate)													;
SET		$NextIdx	=	$Index1	+	1																	;
IF		($Index1	<=	3)
THEN	SET	$Day	=	SUBSTRING($FrenchDate,1,$Index1-1)												;
		SET	$Index2	=	LOCATE($Delimiter,$FrenchDate,$NextIdx)											;

		IF		($Index2	<=	6)
		THEN	SET	$Month	=	SUBSTRING($FrenchDate,$NextIdx,$Index2-$NextIdx)						;
				
				SET		$NextIdx	=	$Index2	+	1													;
				IF		(LOCATE($Delimiter,$FrenchDate,$NextIdx)	=	0)
				THEN	SET		$Year	=	SUBSTRING($FrenchDate,$NextIdx,4)							;
						SET		$Date	=	CAST(	CONCAT($Year,'-', $Month,'-', $Day)	AS	DATE)		;
				END IF																					;
		END IF																							;
END IF																									;
/*
**	(EXIT)
*/
RETURN($Date)																							;			
END
$$

