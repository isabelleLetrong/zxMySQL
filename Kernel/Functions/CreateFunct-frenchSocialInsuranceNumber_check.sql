delimiter $$

DROP							FUNCTION	IF EXISTS	zxitMySQL.frenchSocialInsuranceNumber_check	$$
CREATE DEFINER=`iletrong`@`%` 	FUNCTION 				zxitMySQL.frenchSocialInsuranceNumber_check	(

$SocialInsuranceNumber			VARCHAR(16)

) RETURNS 						BIT(1)

								DETERMINISTIC
								CONTAINS SQL

COMMENT							'Version 1.0 - Vérification d\'un numéro de sécurité sociale français'

BEGIN
/* ===================================================================================================================
**	frenchSocialInsuranceNumber_check()		Vérification d'un numéro de sécurité sociale français
**	------------------------------------------------------------------------------------------------------------------
**	Auteur			:	IT-DaaS	-	Isabelle LE TRONG
**
**	Versions 		:	1.0		2017-04-14	Version initiale
**	------------------------------------------------------------------------------------------------------------------
**	PARAMETRES
**
**	$SocialInsuranceNumber		VARCHAR(16)	:	Numero de sécurité sociale à vérifier
** ===================================================================================================================
**
**	(V)	Variables locales
*/
DECLARE	$Version					DECIMAL(4,2)	UNSIGNED	DEFAULT	1.0											;
DECLARE	$CheckSocialInsuranceNumber	BIT(1)																			;
DECLARE	$RegExpStatus				TINYINT(1)																		;
DECLARE	$CC							TINYINT(3)																		;
DECLARE	$Divisor					TINYINT(3)					DEFAULT	97											;
DECLARE	$SSN						DECIMAL(13,0)																	;
DECLARE	$AdjustSSN					VARCHAR(16)																		;															
/*
**	(H) HANDLERs
*/
DECLARE	EXIT	HANDLER	FOR SQLEXCEPTION	
BEGIN
		SET		$CheckSocialInsuranceNumber	=	NULL																;
		RETURN	$CheckSocialInsuranceNumber																			;
END																													;
/*
**	(0)	Set internal datas
*/
SET		$CheckSocialInsuranceNumber	=	b'0'																		;
/*
**	(1)	Check character set
*/
SELECT	$SocialInsuranceNumber	REGEXP	'^[123478][0-9]{2}[016][0-9](2[A-B]|[0-9]{2})[0-9]{7}[0-9]$'	
INTO	$RegExpStatus																								;

IF		($RegExpStatus	=	1)
/*
**	(2)	Check Control
*/
THEN	SET	$AdjustSSN	=	REPLACE(REPLACE($SocialInsuranceNumber,'2A','19'),'2B','18')							;
		SET	$SSN		=	CAST(SUBSTRING($AdjustSSN FROM 1 	FOR 13) AS	DECIMAL(13,0))							;
		SET	$CC			=	CAST(SUBSTRING($AdjustSSN FROM 14 	FOR 2) 	AS	UNSIGNED)								;

		IF		($CC	=	CAST($Divisor - ($SSN	-	FLOOR($SSN / $Divisor) * $Divisor	)	AS 	UNSIGNED))

		THEN	SET	$CheckSocialInsuranceNumber		=	b'1'														;
		END IF																										;
END IF																												;
/*
**	(EXIT)
*/
RETURN	$CheckSocialInsuranceNumber																					;

END
$$

