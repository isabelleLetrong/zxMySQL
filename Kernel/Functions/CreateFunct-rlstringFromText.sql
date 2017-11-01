delimiter $$

DROP							FUNCTION	IF EXISTS	zxitMySQL.rlstringFromText	$$
CREATE DEFINER=`iletrong`@`%`	FUNCTION 				zxitMySQL.rlstringFromText	(

$Text							TEXT												,
$LeadingString					VARCHAR(252)

) RETURNS 						TEXT					CHARSET utf8

								DETERMINISTIC
								CONTAINS SQL

COMMENT							'Version 1.0 - Remove leading string from text'
BEGIN
/* ==========================================================================================================================
**	rlstringFromText()		Remove leading string from text
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
DECLARE	$LeadingStringSize				SMALLINT(5)																			;
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
SET		$LeadingStringSize	=	CHAR_LENGTH($LeadingString)																	;
SET		$TextSize			=	CHAR_LENGTH($Text)	-		$LeadingStringSize												;	
SET		$TargetTextPosition	=	$LeadingStringSize	+	1																	;


IF		($LeadingStringSize	>	0)

THEN	WHILE	(	$TextSize	>	0
				AND	LOCATE($LeadingString, $TargetText)	=	1
				)

			DO	SET	$TargetText		=	SUBSTRING($TargetText FROM $TargetTextPosition FOR $TextSize)						;
				SET	$TextSize		=	$TextSize	-	$LeadingStringSize													;
			END WHILE																										;
END IF																														;
/*
**	(EXIT)
*/
RETURN	($TargetText)																										;

END
$$

