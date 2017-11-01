delimiter $$

DROP							FUNCTION	IF EXISTS	zxitMySQL.rtstringFromText	$$
CREATE DEFINER=`iletrong`@`%`	FUNCTION 				zxitMySQL.rtstringFromText	(

$Text							TEXT												,
$TrailingString					VARCHAR(252)

) RETURNS 						TEXT					CHARSET utf8

								DETERMINISTIC
								CONTAINS SQL

COMMENT							'Version 1.0 - Remove trailing string from text'
BEGIN
/* ==========================================================================================================================
**	rtstringFromText()		Remove trailing string from text
**  -------------------------------------------------------------------------------------------------------------------------
**	Auteur			:		IT-DaaS - Isabelle LE TRONG
**
**	Versions		:		1.0		2017-09-29	Version initiale
** ==========================================================================================================================
**
** (V) Variables Locales
*/
DECLARE	$Version						DECIMAL(4,2)	DEFAULT	1.0															;
DECLARE	$TargetText						TEXT																				;
DECLARE	$TrailingStringSize				SMALLINT(5)																			;
DECLARE	$TextSize						SMALLINT(5)																			;
DECLARE	$TargetTextPosition				SMALLINT(5)																			;

/*
** (H) HANDLERs
*/
DECLARE	EXIT	HANDLER	FOR SQLEXCEPTION	
BEGIN
		SET		$TargetText	=	NULL																						;
		RETURN	$TargetText																									;
END																															;
/*
**	(1)	Set up internal data
*/
SET		$TargetText			=	$Text																						;
SET		$TrailingStringSize	=	CHAR_LENGTH($TrailingString)																;
SET		$TextSize			=	CHAR_LENGTH($Text)	-	$TrailingStringSize													;
SET		$TargetTextPosition	=	$TextSize		+	1																		;

IF		($TrailingStringSize	>	0)

THEN									
		WHILE	(	$TextSize	>	0
				AND	LOCATE($TrailingString, $TargetText, $TargetTextPosition)	=	$TargetTextPosition	
				)

			DO	SET	$TargetText			=	SUBSTRING($TargetText FROM 1 FOR $TextSize)										;
				SET	$TextSize			=	$TextSize			-	$TrailingStringSize										;
				SET	$TargetTextPosition	=	$TargetTextPosition	-	$TrailingStringSize										;
		END WHILE																											;
END IF																														;
/*
**	(EXIT)
*/
RETURN	($TargetText)																										;

END
$$

