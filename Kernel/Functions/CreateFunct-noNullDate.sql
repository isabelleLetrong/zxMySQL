delimiter $$

DROP 							FUNCTION	IF	EXISTS	zxitMySQL.noNullDate	$$
CREATE DEFINER=`iletrong`@`%` 	FUNCTION 				zxitMySQL.noNullDate	(

$InputDate						DATE

) RETURNS 						DATE

								DETERMINISTIC
								CONTAINS SQL

COMMENT							'Version 1.0 - Retourne \'1000-01-01\' si la  date est marquée NULL ou invalide'
BEGIN
/* ======================================================================================================================
**	noNullDouble()		Retourne :	- '1000-01-01' si la  date est marquée NULL ou invalide
**									- la date d'origine dans le cas contraire
**	---------------------------------------------------------------------------------------------------------------------
**	Auteur			:	IT-Daas	-	Isabelle LE TRONG
**
**	Versions 		:	1.0		2017-06-01	Version initiale
**	---------------------------------------------------------------------------------------------------------------------
**	PARAMETRES
**
**	$InputDate			DATE	date à traiter
** ======================================================================================================================
**
**	(V)	Variables locales
*/
DECLARE	$OutputDate		DATE		DEFAULT	NULL																		;
DECLARE	$DawnOfHumanity	DATE		DEFAULT	'1000-01-01'																;
/*
**	(H) HANDLERs
*/
DECLARE	EXIT	HANDLER	FOR SQLEXCEPTION	
BEGIN
		SET		$OutputDate		=	NULL																				;
		RETURN	$OutputDate																								;
END																														;
/*
**	(1)	Check NULL case
*/
IF		($InputDate	IS  NULL)
THEN	SET		$OutputDate		=	$DawnOfHumanity																		;
ELSE	SET		$OutputDate		=	$InputDate																			;
END IF																													;		
/*
**	(EXIT)
*/
RETURN	$OutputDate																										;

END
$$

