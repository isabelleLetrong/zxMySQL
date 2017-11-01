delimiter $$

DROP							PROCEDURE	IF EXISTS	zxitMySQL.shrinkCharFromString	$$
CREATE DEFINER=`iletrong`@`%` 	PROCEDURE 				zxitMySQL.shrinkCharFromString	(

INOUT	$StringToShrink			VARCHAR(252)											,

IN		$CharToShrink			VARCHAR(1)
)
								DETERMINISTIC
								CONTAINS SQL

COMMENT							'Version 1.0 - Compression de suite de caractères dans un text'
BEGIN
/* ===================================================================================================================
**	zxitMySQL.shrinkCharFromText()		Compression de suite de caractères dans un text
**	----------------------------------------------------------------------------------------------------------------------------
**	TRANSACTIONNELLE	:	NON
**	CHECK-IN			:	NON
**	ETAT				:	Testée
**	----------------------------------------------------------------------------------------------------------------------------
**	Auteur				:	IT-DaaS - Isabelle LE TRONG
**
**	Versions 			:	1.0		2017-04-25	Version initiale
**	-----------------------------------------------------------------------------------------------------------------------------
**	PARAMETRES
**
**	INOUT	$StringToShrink				VARCHAR(252)			:	String à compresser
**	
**	IN		$CharToShrink				VARCHAR(1)				:	Caractère à compresser
** ==============================================================================================================================
**
** (V) Variables Locales
*/
DECLARE	$Version					DECIMAL(4,2)	UNSIGNED	DEFAULT	1.0								;
DECLARE	$ConvertedBit	BIT(1)																			;
DECLARE	$DoubleChar		VARCHAR(2)																		;
															
/*
**	(H) HANDLERs
*/
DECLARE	EXIT	HANDLER	FOR SQLEXCEPTION	
BEGIN
		SET		$StringToShrink	=	NULL																;
END																										;
/*
**	(0)	Set internal Datas
*/
SET		$DoubleChar	=	CONCAT($CharToShrink, $CharToShrink)											;
/*
**	(1)	Shrink target String
*/
WHILE	(LOCATE($DoubleChar, $StringToShrink	)	!= 0) 
	DO	SET	$StringToShrink	=	REPLACE($StringToShrink, $DoubleChar, $CharToShrink)					;
END WHILE																								;
/*
**	(EXIT)
*/
END
$$

