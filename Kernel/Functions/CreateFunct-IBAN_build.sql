delimiter $$

DROP							FUNCTION	IF EXISTS	zxitMySQL.IBAN_build	$$
CREATE DEFINER=`iletrong`@`%`	FUNCTION 				zxitMySQL.IBAN_build	(

$CodePays						CHAR(2)											,
$BBAN							VARCHAR(32)									

) RETURNS 						VARCHAR(64) 			CHARSET utf8

								DETERMINISTIC
								CONTAINS SQL

COMMENT							'Version 1.1 - Construction d\'un code IBAN'

BEGIN
/* ======================================================================================================================
**	IBAN_build()		Construction d'un code IBAN
**	---------------------------------------------------------------------------------------------------------------------
**	Auteur			:	IT-Daas	-	Isabelle LE TRONG
**
**	Versions 		:	1.1		2017-07-26	Substitution de LENGTH() par CHAR_LENGTH()
**						1.0		2017-03-31	Version initiale
**	---------------------------------------------------------------------------------------------------------------------
**	PARAMETRES
**
**	$CodePays						CHAR(2)				: 	Code Pays (Alpha2)
**	$BBAN							VARCHAR(32)			:	BBAN (Basic Bank Account Identifier)
** ======================================================================================================================
**
**	(V)	Variables locales
*/
DECLARE	$Version		DECIMAL(4,2)	UNSIGNED	DEFAULT	1.1															;
DECLARE	$A				TINYINT(3)		UNSIGNED																		;
DECLARE	$Divisor		TINYINT(3)					DEFAULT	97															;
DECLARE	$Idx			TINYINT(3)		UNSIGNED																		;
DECLARE	$wIbanSize		TINYINT(3)		UNSIGNED																		;
DECLARE	$RegExpStatus	TINYINT(1)																						;
DECLARE	$IBAN_DEC		DECIMAL(64,0)																					;
DECLARE	$CC				VARCHAR(2)																						;
DECLARE	$IBAN			VARCHAR(64)																						;
DECLARE	$wIban			VARCHAR(64)																						;
DECLARE	$TemporaryIban	VARCHAR(64)																						;
DECLARE	$wBBAN			VARCHAR(32)																						;
DECLARE	$zWork			VARCHAR(4)																						;
DECLARE	$wChar			VARCHAR(1)																						;
DECLARE	$Space			VARCHAR(1)					DEFAULT	' '															;
DECLARE	$EmptyString	VARCHAR(1)					DEFAULT	''															;
DECLARE	$France			CHAR(2)						DEFAULT	'FR'														;

/*
**	(H) HANDLERs
*/
DECLARE	EXIT	HANDLER	FOR SQLEXCEPTION	
BEGIN
		SET		$IBAN	=	NULL																						;
		RETURN	$IBAN																									;
END																														;
/*
**	(0)	Set internal datas
*/
SET		$IBAN		=	NULL																							;
SET		$wBBAN		=	UPPER(REPLACE($BBAN, $Space, $EmptyString))														;
SET		$A			=	ASCII('A')																						;
/*
**	(1)	Check character set
*/
IF		($CodePays	=	$France)

THEN	SELECT	$wBBAN	REGEXP	'^[0-9]{10}[A-Z0-9]{11}[0-9]{2}$'		INTO	$RegExpStatus							;
ELSE	SELECT	$wBBAN	REGEXP	'^[A-Z0-9]$'							INTO	$RegExpStatus							;
END IF																													;

IF		($RegExpStatus	=	1)
/*
**	(2)	Build IBAN
*/		
THEN	SET	$TemporaryIban	=	CONCAT($CodePays, '00',$wBBAN)															;
		SET	$zWork			=	SUBSTRING($TemporaryIban FROM 1 FOR	4)													;
		SET	$wIban			=	CONCAT(SUBSTRING($TemporaryIban, 5), $zWork )											;

		SET	$wIbanSize		=	CHAR_LENGTH($wIban)																		;
		SET	$Idx			=	1																						;
		SET	$IBAN			=	''																						;

		WHILE	($Idx 		<=	$wIbanSize)

			DO	SET	$wChar	=	SUBSTRING($wIban	FROM	$Idx	FOR	1)												;

				IF		(	$wChar	>=	'A'
						AND	$wChar	<=	'Z'
						)
				THEN	SET	$IBAN	=	CONCAT($IBAN, CAST((10 + ASCII($wChar) - $A) AS CHAR(2)) )						;
				ELSE	SET	$IBAN	=	CONCAT($IBAN, $wChar)															;
				END IF																									;

				SET		$Idx	=	$Idx	+	1																		;
			END WHILE																									;

		SET	$IBAN_DEC	=	CAST($IBAN	AS	DECIMAL(64,0))																;
					
		SET	$CC			=	CAST($Divisor + 1 - ($IBAN_DEC - FLOOR($IBAN_DEC / $Divisor) * $Divisor	)	AS CHAR(2)	)	;
		
		SET	$IBAN		=	CONCAT(	SUBSTRING($TemporaryIban FROM 1 FOR 2)	,
									LPAD($CC, 2,'0')																	,
									SUBSTRING($TemporaryIban, 5)			)											;
END IF																													;
/*
**	(EXIT)
*/
RETURN	$IBAN																											;

END
$$

