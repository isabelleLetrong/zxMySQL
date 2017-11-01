DELIMITER $$

DROP 							FUNCTION	IF	EXISTS	zxitMySQL.string_cleanUp	$$
CREATE DEFINER=`iletrong`@`%` 	FUNCTION 				zxitMySQL.string_cleanUp	(

$StringToCleanUp				VARCHAR(255)									,
$UnwelcomeString				VARCHAR(32)										,
$Joker							VARCHAR(1)

) RETURNS 						VARCHAR(255)			CHARSET utf8

								DETERMINISTIC
								CONTAINS SQL

COMMENT							'Version 2.1 - Nettoyage d\'une chaine de caractère (retrait de caractères indésirable)'
BEGIN
/*	============================================================================================================================
**	string_cleanUp()			Nettoyage d'une chaine de caractère (retrait de caractères indésirable)
**	----------------------------------------------------------------------------------------------------------------------------
**	TRANSACTIONNELLE	:	NON
**	CHECK-IN			:	OUI
**	ETAT				:	Testée
**	----------------------------------------------------------------------------------------------------------------------------
**	Auteur				:	IT-DaaS - Isabelle LE TRONG
**
**	Versions 			:	2.1		2017-07-26	Substitution de LENGTH() par CHAR_LENGTH()
**							2.0		2017-05-19	Paramétrage du caractère de substitution
**							1.0		2017-05-11	Version initiale
**	-----------------------------------------------------------------------------------------------------------------------------
**	PARAMETRES
**
**	$StringToCleanUp			VARCHAR(255)					:	Chaine de caractères à nettoyer
**	$UnwelcomeString			VARCHAR(32)						:	Caractères indésirables
**	$Joker						VARCHAR(1)						:	Caratère de substitution (espace, string vide,...)
** ==============================================================================================================================
**
** (V) Variables Locales
*/
DECLARE	$Version					DECIMAL(4,2)	UNSIGNED	DEFAULT	2.1														;
DECLARE	$UnwelcomeStringSize		TINYINT(5)		UNSIGNED																	;
DECLARE	$UnwelcomeStringIndex		TINYINT(5)																					;
DECLARE	$String						VARCHAR(255)																				;
/*
** (H) HANDLERs
*/
DECLARE	EXIT	HANDLER	FOR SQLEXCEPTION	
BEGIN
	SET		$String					=	NULL																					;
	RETURN	$String																												;
END																																;
/*		
**	(0)		Set internal datas
*/
SET			$UnwelcomeStringSize	=	CHAR_LENGTH($UnwelcomeString)															;	
SET			$UnwelcomeStringIndex	=	$UnwelcomeStringSize																	;
SET			$String					=	$StringToCleanUp																		;
/*
**	(1)		Cleanup String
*/
WHILE		($UnwelcomeStringIndex	>	0)
	DO		SET	$String					=	REPLACE($String, SUBSTRING($UnwelcomeString, $UnwelcomeStringIndex,1), $Joker)		;
			SET	$UnwelcomeStringIndex	=	$UnwelcomeStringIndex		-	1													;
	END WHILE																													;

/*
**	(EXIT)
*/
RETURN		$String																												;
END
$$

