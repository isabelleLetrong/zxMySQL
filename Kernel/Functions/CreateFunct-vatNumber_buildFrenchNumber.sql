delimiter $$

DROP							FUNCTION	IF EXISTS	zxitMySQL.vatNumber_buildFrenchNumber	$$
CREATE DEFINER=`iletrong`@`%`	FUNCTION 				zxitMySQL.vatNumber_buildFrenchNumber	(

$InSIREN						VARCHAR(16)									

) RETURNS 						VARCHAR(13) 			CHARSET utf8

								DETERMINISTIC
								CONTAINS SQL

COMMENT							'Version 1.0 - Calcul du numéro de TVA intracommunautaire français'
BEGIN
/* ======================================================================================================================
**	vatNumber_buildFrenchNumber()	Calcul du numéro de TVA intracommunautaire français
**	---------------------------------------------------------------------------------------------------------------------
**	Auteur			:	IT-Daas	-	Isabelle LE TRONG
**
**	Versions 		:	1.0		2017-07-10	Version initiale
**	---------------------------------------------------------------------------------------------------------------------
**	PARAMETRES
**
**	$InSIREN						VARCHAR(16)	:	Numéro SIREN
** ======================================================================================================================
**
**	(V)	Variables locales
*/
DECLARE	$Version		DECIMAL(4,2)	UNSIGNED	DEFAULT	1.0															;
DECLARE	$A				TINYINT(3)		UNSIGNED																		;
DECLARE	$Divisor		TINYINT(3)					DEFAULT	97															;
DECLARE	$SirenSize		TINYINT(3)					DEFAULT	9															;
DECLARE	$VatNumberKey	DECIMAL(10,0)																					;
DECLARE	$SIREN			VARCHAR(16)																						;
DECLARE	$VatNumber		VARCHAR(13)																						;
DECLARE	$France			CHAR(2)						DEFAULT	'FR'														;
/*
**	(H) HANDLERs
*/
DECLARE	EXIT	HANDLER	FOR SQLEXCEPTION	
BEGIN
		SET		$VatNumber	=	NULL																					;
		RETURN	$VatNumber																								;
END																														;
/*
**	(0)	Set internal datas
*/
SET		$VatNumber	=	NULL																							;
SET		$SIREN		=	LEFT(zxitMySQL.sirenSiret_getCleanupAndChecked($InSIREN), $SirenSize)							;

IF		($SIREN	IS NOT NULL)
/*
**	(2)	Build VatNumber
*/		
THEN	SET	$VatNumberKey	=	CAST($SIREN AS DECIMAL(10,0) )															;
		SET	$VatNumberKey	=	12 + 3 * ($VatNumberKey - FLOOR($VatNumberKey / $Divisor) * $Divisor	)				;
		SET	$VatNumberKey	=	$VatNumberKey - FLOOR($VatNumberKey / $Divisor) * $Divisor								;
		SET	$VatNumber		=	CONCAT($France, LPAD(RIGHT(CAST($VatNumberKey AS CHAR),2),2,'0'), $SIREN)				;
END IF																													;
/*
**	(EXIT)
*/
RETURN	$VatNumber																										;

END
$$

