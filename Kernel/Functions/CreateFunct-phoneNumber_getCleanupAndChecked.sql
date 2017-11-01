delimiter $$

DROP							FUNCTION	IF EXISTS	zxitMySQL.phoneNumber_getCleanupAndChecked	$$
CREATE DEFINER=`iletrong`@`%` 	FUNCTION				zxitMySQL.phoneNumber_getCleanupAndChecked	(

$PhoneNumberToCheck				VARCHAR(64)

) RETURNS						VARCHAR(64)				CHARSET utf8

								DETERMINISTIC
								CONTAINS SQL

COMMENT							'Version 1.1 - Nettoyage d\'un numéro de téléphone et vérification syntaxe'
BEGIN
/*	============================================================================================================================
**	phoneNumber_getCleanupAndChecked()	Nettoyage d'un numéro de téléphone et vérification syntaxe 
**	----------------------------------------------------------------------------------------------------------------------------
**	TRANSACTIONNELLE	:	NON
**	CHECK-IN			:	OUI
**	ETAT				:	Testée
**	----------------------------------------------------------------------------------------------------------------------------
**	Auteur				:	IT-DaaS - Isabelle LE TRONG
**
**	Versions 			:	1.1		2017-07-26	Substitution de LENGTH() par CHAR_LENGTH()
**							1.0		2017-05-09	Version initiale
**	-----------------------------------------------------------------------------------------------------------------------------
**	PARAMETRES
**
**	$PhoneNumber			VARCHAR(64)						:	Numéro de téléphone à traiter
** ==============================================================================================================================
**
** (V) Variables Locales
*/
DECLARE	$Version					DECIMAL(4,2)	UNSIGNED	DEFAULT	1.1														;
DECLARE	$InterferencesStringSize	TINYINT(5)		UNSIGNED																	;
DECLARE	$InterferencesStringIndex	TINYINT(5)																					;
DECLARE	$Space						VARCHAR(1)					DEFAULT	' '														;
DECLARE	$InterferencesString		VARCHAR(16)					DEFAULT	'.,;:-'													;
DECLARE	$PhoneNumber				VARCHAR(64)																					;
DECLARE	$OK							BIT(1)						DEFAULT	b'1'													;
/*
** (H) HANDLERs
*/
DECLARE	EXIT	HANDLER	FOR SQLEXCEPTION	
BEGIN
	SET		$PhoneNumber			=	NULL																					;
	RETURN	$PhoneNumber																										;
END																																;
/*		
**	(0)		Set internal datas
*/
SET		$InterferencesStringSize	=	CHAR_LENGTH($InterferencesString)														;	
SET		$InterferencesStringIndex	=	$InterferencesStringSize																;
SET		$PhoneNumber				=	$PhoneNumberToCheck																		;
/*
**	(1)		Cleanup PhoneNumber
**
**	(1.1)	Replace interference characters
*/
WHILE		($InterferencesStringIndex	>	0)
	DO		SET	$PhoneNumber				=	REPLACE(	$PhoneNumber													,
															SUBSTRING($InterferencesString, $InterferencesStringIndex,1)	,
															$Space															)	;
			SET	$InterferencesStringIndex	=	$InterferencesStringIndex		-	1											;
	END WHILE																													;
/*
**	(1.2)	TRIM	$PhoneNumber
*/
SET		$PhoneNumber	=	TRIM($PhoneNumber)																					;
/*
**	(1.3)	Shring $PhoneNumber
*/
CALL		zxitMySQL.shrinkCharFromString($PhoneNumber,$Space)																	;			
/*
**	(2)		Check actual target PhoneNumber
*/

IF			(zxitMySQL.phoneNumber_check($PhoneNumber)	!=	$OK)
THEN		SET	$PhoneNumber	=	NULL													/* Invalid syntax Phone number	*/	;
END IF																															;
/*
**	(EXIT)
*/
RETURN		$PhoneNumber																										;
END
$$

