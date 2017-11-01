delimiter $$

DROP							PROCEDURE	IF EXISTS	zxitMySQL.PhoneNumber_cleanupAndCheck	$$
CREATE DEFINER=`iletrong`@`%` 	PROCEDURE 				zxitMySQL.PhoneNumber_cleanupAndCheck	(

OUT		$Status					INTEGER(10)	UNSIGNED											,
OUT		$Step					INTEGER(10)	UNSIGNED											,

INOUT	$PhoneNumber			VARCHAR(64)
)
								DETERMINISTIC
								CONTAINS SQL

COMMENT							'Version 2.0 - Nettoyage d\'un numéro de téléphone et vérification syntaxe'
BEGIN
/*	============================================================================================================================
**	PhoneNumber_cleanupAndCheck()	Nettoyage d'un numéro de téléphone et vérification syntaxe 
**	----------------------------------------------------------------------------------------------------------------------------
**	TRANSACTIONNELLE	:	OUI
**	CHECK-IN			:	OUI
**	ETAT				:	Testée
**	----------------------------------------------------------------------------------------------------------------------------
**	Auteur				:	IT-DaaS - Isabelle LE TRONG
**
**	Versions 			:	2.0		2017-04-09	Utilisation de la fonction	phonenumber_getCleanupAndChecked()
**							1.0		2017-04-25	Version initiale
**	-----------------------------------------------------------------------------------------------------------------------------
**	PARAMETRES
**
**	OUT		$Status				INTEGER(10) 	UNSIGNED		:	Code Retour 0 = OK 
**	OUT		$Step				INTEGER(10) 	UNSIGNED		:	Etape Atteinte
**	
**	INOUT	$PhoneNumber		VARCHAR(64)						:	Numéro de téléphone à traiter
** ==============================================================================================================================
**
** (V) Variables Locales
*/
DECLARE	$Signature					INTEGER(10)		UNSIGNED	DEFAULT 900200													;
DECLARE	$Version					DECIMAL(4,2)	UNSIGNED	DEFAULT	2.0														;
DECLARE	$CheckedPhoneNumber			VARCHAR(64)																					;
/*
** (H) HANDLERs
*/
DECLARE	EXIT	HANDLER	FOR SQLEXCEPTION	
BEGIN
	SET		$Status		=	$Signature																							;
END																																;
/*		
**	(0)		Set internal datas
*/
SET		$Status					=	0																							;
SET		$Step					=	$Signature																					;
/*
**	(1)		Cleanup PhoneNumber and check it
*/
SET		$CheckedPhoneNumber		=	zxitMySQL.phoneNumber_getCleanupAndChecked($PhoneNumber)										;
SET		$Step					=	$Signature	+	1																			;

IF		($CheckedPhoneNumber	IS	NULL)
THEN	SET	$Status				=	$Signature	+	1										/* Invalid syntax Phone number	*/	;
ELSE	SET	$PhoneNumber		=	$CheckedPhoneNumber																			;
END IF																															;
/*
**	(EXIT)
*/
END
$$

