delimiter $$

DROP							FUNCTION	IF	EXISTS	zxitMySQL.sirenSiret_getCleanupAndChecked	$$
CREATE DEFINER=`iletrong`@`%` 	FUNCTION 				zxitMySQL.sirenSiret_getCleanupAndChecked	(

$SiretToCheck					VARCHAR(32)

) RETURNS 						VARCHAR(32)				CHARSET utf8

								DETERMINISTIC
								CONTAINS SQL

COMMENT							'Version 1.1 - Nettoyage d\'un numéro de SIRET/SIREN et vérification jeu caractères'
BEGIN
/*	=====================================================================================================================================
**	sirenSiret_getCleanupAndChecked()	Nettoyage d'un numéro de SIRET/SIREN et vérification jeu caractères 
**	-------------------------------------------------------------------------------------------------------------------------------------
**	TRANSACTIONNELLE	:	NON
**	CHECK-IN			:	OUI
**	ETAT				:	Testée
**	-------------------------------------------------------------------------------------------------------------------------------------
**	Auteur				:	IT-DaaS - Isabelle LE TRONG
**
**	Versions 			:	1.1		2017-07-26	Substitution de LENGTH() par CHAR_LENGTH()
**							1.0		2017-05-11	Version initiale
**	-------------------------------------------------------------------------------------------------------------------------------------
**	PARAMETRES
**
**	$SiretToCheck			VARCHAR(32)					:	SIREN ou SIRET à nettoyer et vérifier
** ======================================================================================================================================
**
** (V) Variables Locales
*/
DECLARE	$Version					DECIMAL(4,2)	UNSIGNED	DEFAULT	1.1																;
DECLARE	$InterferencesStringSize	TINYINT(5)		UNSIGNED																			;
DECLARE	$InterferencesStringIndex	TINYINT(5)																							;
DECLARE	$RegExpStatus				TINYINT(1)																							;
DECLARE	$EmptyString				VARCHAR(1)					DEFAULT	''																;
DECLARE	$InterferencesString		VARCHAR(8)					DEFAULT	' .,;:-_'														;
DECLARE	$Siret						VARCHAR(32)																							;
/*
** (H) HANDLERs
*/
DECLARE	EXIT	HANDLER	FOR SQLEXCEPTION	
BEGIN
	SET		$Siret					=	NULL																							;
	RETURN	$Siret																														;
END																																		;
/*		
**	(0)		Set internal datas
*/
SET		$InterferencesStringSize	=	CHAR_LENGTH($InterferencesString)																;	
SET		$InterferencesStringIndex	=	$InterferencesStringSize																		;
SET		$Siret						=	$SiretToCheck																					;
/*
**	(1)		Cleanup Siret	(Take off interference characters)
*/
WHILE		($InterferencesStringIndex	>	0)
	DO		SET	$Siret						=	REPLACE($Siret, SUBSTRING($InterferencesString, $InterferencesStringIndex,1), $EmptyString)	;
			SET	$InterferencesStringIndex	=	$InterferencesStringIndex		-	1													;
	END WHILE																															;
/*
**	(2)		Checkactual target Siret
*/
SET			$RegExpStatus	=	$Siret	REGEXP	'^[0-9]{9}$|^[0-9]{14}$'																;

IF			($RegExpStatus	!=	1)
THEN		SET		$Siret	=	NULL																									;
END IF																																	;		
/*
**	(EXIT)
*/
RETURN		$Siret																														;
END
$$

