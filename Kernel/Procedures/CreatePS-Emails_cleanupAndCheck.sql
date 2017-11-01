delimiter $$

DROP							PROCEDURE	IF EXISTS	zxitMySQL.Emails_cleanupAndCheck	$$		
CREATE 	DEFINER=`iletrong`@`%`	PROCEDURE 				zxitMySQL.Emails_cleanupAndCheck	(

OUT		$Status					INTEGER(10)	UNSIGNED									,
OUT		$Step					INTEGER(10)	UNSIGNED									,

INOUT	$Email					VARCHAR(255)
)
								DETERMINISTIC
								CONTAINS SQL

COMMENT							'Version 2.0 - 2017-04-09	Nettoyage d\'une adresse email et vérification syntaxe'
BEGIN
/*	============================================================================================================================
**	Emails_cleanupAndCheck()	Nettoyage d'une adresse email et vérification syntaxe 
**	----------------------------------------------------------------------------------------------------------------------------
**	TRANSACTIONNELLE	:	OUI
**	CHECK-IN			:	OUI
**	ETAT				:	Testée
**	----------------------------------------------------------------------------------------------------------------------------
**	Auteur				:	IT-DaaS - Isabelle LE TRONG
**
**	Versions 			:	2.0		2017-04-09	Utilisation de la fonction	emails_getCleanupAndChecked()
**							1.0		2017-03-26	Version initiale
**	-----------------------------------------------------------------------------------------------------------------------------
**	PARAMETRES
**
**	OUT		$Status				INTEGER(10) 	UNSIGNED		:	Code Retour 0 = OK 
**	OUT		$Step				INTEGER(10) 	UNSIGNED		:	Etape Atteinte
**	
**	INOUT	$Email				VARCHAR(255)					:	adresse email à traiter
** ==============================================================================================================================
**
** (V) Variables Locales
*/
DECLARE	$Signature					INTEGER(10)		UNSIGNED	DEFAULT 900100													;
DECLARE	$Version					DECIMAL(4,2)	UNSIGNED	DEFAULT	2.0														;
DECLARE	$CheckedEmail				VARCHAR(255)																				;
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
SET		$Status			=	0																									;
SET		$Step			=	$Signature																							;
/*
**	(1)		Cleanup email and check it
*/
SET		$CheckedEmail	=	zxitMySQL.emails_getCleanupAndChecked($Email)														;
SET		$Step			=	$Signature	+	1																					;

IF		($CheckedEmail	IS	NULL)
THEN	SET	$Status		=	$Signature	+	1													/* Invalid email syntax		*/	;
ELSE	SET	$Email		=	$CheckedEmail																						;
END IF																															;
/*
**	(EXIT)
*/
END
$$

