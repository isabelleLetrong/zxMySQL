delimiter $$

DROP							FUNCTION	IF	EXISTS	zxitMySQL.emails_getCleanupAndChecked	$$
CREATE DEFINER=`iletrong`@`%` 	FUNCTION 				zxitMySQL.emails_getCleanupAndChecked	(

$EmailToCheck					VARCHAR(255)

) RETURNS 						VARCHAR(255)			CHARSET utf8

								DETERMINISTIC
								CONTAINS SQL

COMMENT							'Version 1.1 - Nettoyage d\'une adresse email et vérification syntaxe'

BEGIN
/*	=================================================================================================================================
**	emails_getCleanupAndChecked()	Nettoyage d'une adresse email et vérification syntaxe 
**	---------------------------------------------------------------------------------------------------------------------------------
**	TRANSACTIONNELLE	:	NON
**	CHECK-IN			:	OUI
**	ETAT				:	Testée
**	---------------------------------------------------------------------------------------------------------------------------------
**	Auteur				:	IT-DaaS - Isabelle LE TRONG
**
**	Versions 			:	1.1		2017-07-26	Substitution de LENGTH() par CHAR_LENGTH()
**							1.0		2017-05-09	Version initiale
**	---------------------------------------------------------------------------------------------------------------------------------
**	PARAMETRES
**
**	$EmailToCkeck			VARCHAR(255)					:	adresse email à nettoyer et vérifier
** ==================================================================================================================================
**
** (V) Variables Locales
*/
DECLARE	$Version					DECIMAL(4,2)	UNSIGNED	DEFAULT	1.1															;
DECLARE	$InterferencesStringSize	TINYINT(5)		UNSIGNED																		;
DECLARE	$InterferencesStringIndex	TINYINT(5)																						;
DECLARE	$Dot						CHAR(1)						DEFAULT	'.'															;
DECLARE	$Space						VARCHAR(1)					DEFAULT	' '															;
DECLARE	$EmptyString				VARCHAR(1)					DEFAULT	''															;
DECLARE	$InterferencesString		VARCHAR(16)					DEFAULT	',;:'														;
DECLARE	$Email						VARCHAR(255)																					;
DECLARE	$OK							BIT(1)						DEFAULT	b'1'														;
/*
** (H) HANDLERs
*/
DECLARE	EXIT	HANDLER	FOR SQLEXCEPTION	
BEGIN
	SET		$Email					=	NULL																						;
	RETURN	$Email																													;
END																																	;
/*		
**	(0)		Set internal datas
*/
SET		$InterferencesStringSize	=	CHAR_LENGTH($InterferencesString)															;	
SET		$InterferencesStringIndex	=	$InterferencesStringSize																	;
/*
**	(1)		Cleanup email
**
**	(1.1)	Remove spaces
*/
SET			$Email	=	REPLACE($EmailToCheck, $Space, $EmptyString)																		;
/*
**	(1.2)	Convert to lower case
*/
SET			$Email	=	LOWER($Email)																								;

/*
**	(1.3)	Replace interference characters
*/
WHILE		($InterferencesStringIndex	>	0)
	DO		SET	$Email						=	REPLACE($Email, SUBSTRING($InterferencesString, $InterferencesStringIndex,1), $Dot)	;
			SET	$InterferencesStringIndex	=	$InterferencesStringIndex		-	1												;
	END WHILE																														;
/*
**	(2)		Checkactual target email
*/
IF			(zxitMySQL.emails_check($Email)	!=	$OK)
THEN		SET	$Email	=	NULL																	/* Invalid syntaxe email	*/	;
END IF																																;
/*
**	(EXIT)
*/
RETURN		$Email																													;
END
$$

