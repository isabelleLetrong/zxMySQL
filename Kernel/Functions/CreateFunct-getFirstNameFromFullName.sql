delimiter $$

DROP							FUNCTION	IF EXISTS	zxitMySQL.getFirstNameFromFullName	$$
CREATE DEFINER=`iletrong`@`%` 	FUNCTION 				zxitMySQL.getFirstNameFromFullName	(

$FullName						VARCHAR(193)

) RETURNS 						VARCHAR(64) 			CHARSET utf8

								DETERMINISTIC
								CONTAINS SQL

COMMENT							'Version 1.0 - Extraction du Prénom à partir du nom complet'

BEGIN
/*	===================================================================================================================================
**	getFirstNameFromFullName()	Extraction du Prénom à partir du nom complet
**	-----------------------------------------------------------------------------------------------------------------------------------
**	TRANSACTIONNELLE	:	NON
**	CHECK-IN			:	OUI
**	ETAT				:	Testée
**	-----------------------------------------------------------------------------------------------------------------------------------
**	Auteur				:	IT-DaaS - Isabelle LE TRONG
**
**	Versions 			:	1.0		2017-06-05	Version initiale
**	-----------------------------------------------------------------------------------------------------------------------------------
**	PARAMETRES
**
**	$FullName				VARCHAR(193)				:	Nom complet
** ====================================================================================================================================
**
** (V) Variables Locales
*/
DECLARE	$Version			DECIMAL(4,2)	UNSIGNED		DEFAULT	1.0																;
DECLARE	$Status				INTEGER(10)		UNSIGNED																				;
DECLARE	$FirstNameLastChar	TINYINT(3)		UNSIGNED																				;
DECLARE	$Name				VARCHAR(193)																							;
DECLARE	$FirstName			VARCHAR(64)		CHARSET	utf8																			;
/*
** (H) HANDLERs
*/
DECLARE	EXIT	HANDLER	FOR SQLEXCEPTION	
BEGIN
	SET		$FirstName		=	NULL																								;
	RETURN	$FirstName																												;
END																																	;
/*		
**	(0)		Set internal datas	and miscellaneous output arguments
*/
SET			$Status			=	zxitMySQL.$Statics_set()																				;
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
THEN		SET	$FirstName	=	SUBSTRING($Name	FROM	1	FOR	$FirstNameLastChar)													;

ELSE		SET	$FirstName	=	NULL											/* Unformated Full Name							*/	;		
END IF																																;
/*
**	(EXIT)
*/
RETURN		$FirstName																												;
	
END
$$

