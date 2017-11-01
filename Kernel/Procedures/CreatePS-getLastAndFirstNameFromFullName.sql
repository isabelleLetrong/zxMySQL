delimiter $$

DROP							PROCEDURE	IF EXISTS	zxitMySQL.getLastAndFirstNameFromFullName	$$
CREATE DEFINER=`iletrong`@`%` 	PROCEDURE 				zxitMySQL.getLastAndFirstNameFromFullName	(

OUT		$Status					INTEGER(10)				UNSIGNED									,
OUT		$Step					INTEGER(10)				UNSIGNED									,
OUT		$LastName				VARCHAR(128)														,
OUT		$FirstName				VARCHAR(64)															,

IN		$FullName				VARCHAR(193)
)
								DETERMINISTIC
								CONTAINS SQL

COMMENT							'Version 1.1 - Split Nom, Prénom à partir du nom complet'
BEGIN
/*	===================================================================================================================================
**	getLastAndFirstNameFromFullName()	Split Nom, Prénom à partir du nom complet
**	-----------------------------------------------------------------------------------------------------------------------------------
**	TRANSACTIONNELLE	:	NON
**	CHECK-IN			:	OUI
**	ETAT				:	Testée
**	-----------------------------------------------------------------------------------------------------------------------------------
**	Auteur				:	IT-DaaS - Isabelle LE TRONG
**
**	Versions 			:	1.1		2017-08-17	appel à la bibliothèque zxitMySQL.$Statics_set()	
**							1.0		2017-06-05	Version initiale
**	-----------------------------------------------------------------------------------------------------------------------------------
**	PARAMETRES
**
**	OUT		$Status			INTEGER(10) 	UNSIGNED	:	Code Retour 0 = OK 
**	OUT		$Step			INTEGER(10) 	UNSIGNED	:	Etape Atteinte
**	OUT		$LastName		VARCHAR(128)				:	Nom
**	OUT		$FirstName		VARCHAR(64)					:	Prénom
**
**	IN		$FullName		VARCHAR(193)				:	Nom complet
** ====================================================================================================================================
**
** (V) Variables Locales
*/
DECLARE	$Signature			INTEGER(10)		UNSIGNED	DEFAULT 900300																;
DECLARE	$Version			DECIMAL(4,2)	UNSIGNED	DEFAULT	1.1																	;
DECLARE	$FirstNameLastChar	TINYINT(3)		UNSIGNED																				;
DECLARE	$Name				VARCHAR(193)																							;
/*
** (H) HANDLERs
*/
DECLARE	EXIT	HANDLER	FOR SQLEXCEPTION	
BEGIN
	SET		$Status			=	$Signature																							;
END																																	;
/*		
**	(0)		Set internal datas	and miscellaneous output arguments
*/
SET			$Status			=	zxitMySQL.$Statics_set()																				;
SET			$Step			=	$Signature																							;
SET			$Name			=	TRIM($FullName)																						;

/*
**	(1)		Locate	LastName
*/
SET			$FirstNameLastChar	=	LOCATE(@zxitMySQL$Statics$Space, $Name) - 1														;

IF			(	$FirstNameLastChar	>	0
			AND	$FirstNameLastChar	<	65
			)
/*
**	(2)		Extract	FirstName
*/
THEN		SET	$Step		=	$Signature	+	1																					;
			SET	$FirstName	=	SUBSTRING($Name	FROM	1	FOR	$FirstNameLastChar)													;
/*
**	(3)		Extract	LastName
*/
			SET	$Step		=	$Signature	+	2																					;
			SET	$LastName	=	LEFT(LTRIM(SUBSTRING($Name, $FirstNameLastChar + 2)), 128)											;

ELSE		SET	$Status		=	$Signature	+	1												/* Unformated Full Name			*/	;		
END IF																																;
/*
**	(EXIT)
*/
END
$$

