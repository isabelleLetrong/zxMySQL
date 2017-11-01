delimiter $$

DROP							FUNCTION		IF EXISTS	zxitMySQL.LocateFwd	$$
CREATE DEFINER=`iletrong`@`%`	FUNCTION 					zxitMySQL.LocateFwd	(

$KeyWord						VARCHAR(128)									,
$String							TEXT											,
$Pos							SMALLINT(5)		UNSIGNED
	
) RETURNS 						SMALLINT(5)		UNSIGNED

								DETERMINISTIC
								CONTAINS SQL

COMMENT							'Version 2.0 - Recherche de mots clés précédents dans une chaine de caractères'

BEGIN
/* ==========================================================================================================================
**	LocateFwd()					Recherche de mots clés précédents dans une chaine de caractères
***  -------------------------------------------------------------------------------------------------------------------------
**	Auteur			:			IT-DaaS - Isabelle LE TRONG
**
**	Versions		:			2.0		2017-09-29	Version zxitMySQL
**								1.0		2017-02-03	Version initiale
** ==========================================================================================================================
**
** (V) Variables Locales
*/
DECLARE	$Version						DECIMAL(4,2)				DEFAULT	2.0						;
DECLARE	$Location						SMALLINT(5)		UNSIGNED									;
DECLARE	$KeyWordSize					SMALLINT(5)		UNSIGNED									;
DECLARE	$StringSize						SMALLINT(5)		UNSIGNED									;
DECLARE	$Idx							SMALLINT(5)													;
DECLARE	$MinIdx							SMALLINT(5)													;
DECLARE	$ToDo							BIT(1)														;
DECLARE	$ON								BIT(1)						DEFAULT	1						;
/*
** (H) HANDLERs
*/
DECLARE	EXIT	HANDLER	FOR SQLEXCEPTION	
BEGIN
SET		$Location			=	NULL																;
		RETURN($Location)																			;
END																									;
/*
**	(0)	Set up internal datas
*/
SET		$Location			=	0																	;
SET		$KeyWordSize		=	CHAR_LENGTH($KeyWord)												;
SET		$StringSize			=	CHAR_LENGTH($String)												;

IF		(	$KeyWordSize	IS	NULL
		OR	$StringSize		IS	NULL
		OR	$Pos			IS	NULL
		)
THEN	SET	$Location		=	NULL																;
ELSE	SET	$ToDo			=	$ON																	;
		SET	$Idx			=	$Pos	-	($KeyWordSize	- 1)									;

		WHILE	(	$Idx	>	0
				AND	$ToDo	=	$ON
				)
			DO	IF		($KeyWord		=	SUBSTRING($String	FROM	$Idx	FOR	$KeyWordSize))
				THEN	SET	$ToDo		=	NOT($ON)												;
						SET	$Location	=	$Idx													;
				ELSE	SET	$Idx		=	$Idx	-	1											;
				END IF																				;
			END WHILE																				;
END IF																								;
/*
**	(EXIT)
*/
RETURN	$Location																					;

END
$$

