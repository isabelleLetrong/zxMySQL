delimiter $$

DROP									FUNCTION	IF EXISTS	zxitMySQL.$Statics_set	$$
CREATE DEFINER=`iletrong`@`%`		 	FUNCTION 				zxitMySQL.$Statics_set	(

) RETURNS 								INTEGER(10) UNSIGNED

										DETERMINISTIC
										CONTAINS SQL

COMMENT									'Version 1.0 - 2017-08-17 - Initialisation des Constantes Générales'
BEGIN
/* ==========================================================================================================================
**	$Statics_set()			Initialisation des Constantes Générales
***  -------------------------------------------------------------------------------------------------------------------------
**	Auteur			:		IT-DaaS - Isabelle LE TRONG
**
**	Versions		:		1.0		2017-08-17	Version initiale
** ==========================================================================================================================
**
** (V) Variables Locales
**
**		No Local datas
*/
/*
** (H) HANDLERs
*/
DECLARE	EXIT	HANDLER	FOR SQLEXCEPTION	
BEGIN
	RETURN	(1)																											;
END																														;
/*	
**	(N)		NULL Static
*/
SET	@zxitMySQL$Statics$NULL								=	NULL														;
/*
**	(S)		String Statics
*/
SET	@zxitMySQL$Statics$EmptyString						=	''															;
SET	@zxitMySQL$Statics$Space								=	' '															;
SET	@zxitMySQL$Statics$Tab								=	'\t'														;
SET	@zxitMySQL$Statics$NewLine							=	'\n'														;
/*
**	(EXIT)
*/
RETURN	(0)																												;

END
$$

