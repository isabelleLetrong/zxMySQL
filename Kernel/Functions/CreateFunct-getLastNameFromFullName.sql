delimiter $$

DROP							FUNCTION	IF EXISTS	zxitMySQL.getLastNameFromFullName	$$
CREATE DEFINER=`iletrong`@`%` 	FUNCTION 				zxitMySQL.getLastNameFromFullName	(

$FullName						VARCHAR(193)

) RETURNS 						VARCHAR(128) 			CHARSET utf8

								DETERMINISTIC
								CONTAINS SQL

COMMENT							'Version 1.0 - Extraction du Nom à partir du nom complet'
BEGIN
/*	===================================================================================================================================
**	getLastNameFromFullName()	Extraction du Nom à partir du nom complet
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
DECLARE	$LastName			VARCHAR(128)																							;
/*
** (H) HANDLERs
*/
DECLARE	EXIT	HANDLER	FOR SQLEXCEPTION	
BEGIN
	SET		$LastName		=	NULL																								;
	RETURN	$LastName																												;
END																																	;
/*		
**	(0)		Set internal datas	and miscellaneous output arguments
*/
SET			$Status			=	players_repository.$Statics_set()																	;
SET			$Name			=	TRIM($FullName)																						;

/*
**	(1)		Locate	LastName
*/
SET			$FirstNameLastChar	=	LOCATE(@players_repository$Statics$Space, $Name) - 1											;

IF			(	$FirstNameLastChar	>	0
			AND	$FirstNameLastChar	<	65
			)
/*
**	(2)		Extract	LastName
*/
THEN		SET	$LastName	=	LEFT(LTRIM(SUBSTRING($Name, $FirstNameLastChar + 2)), 128)											;

ELSE		SET	$LastName	=	NULL															/* Unformated Full Name			*/	;		
END IF																																;
/*
**	(EXIT)
*/
RETURN		$LastName																												;
	
END
$$

