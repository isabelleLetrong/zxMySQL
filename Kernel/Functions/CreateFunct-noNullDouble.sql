delimiter $$

DROP 							FUNCTION	IF	EXISTS	zxitMySQL.noNullDouble	$$
CREATE DEFINER=`iletrong`@`%` 	FUNCTION 				zxitMySQL.noNullDouble	(

$InputDouble					DOUBLE

) RETURNS						DOUBLE

								DETERMINISTIC
								CONTAINS SQL

COMMENT							'Version 1.0 - retourne 0 si le double est marqué NULL'
BEGIN
/* ======================================================================================================================
**	noNullDouble()		Retourne :	- 0 si le  double est marqué NULL
**									- le double d'origine dans le cas contraire
**	---------------------------------------------------------------------------------------------------------------------
**	Auteur			:	IT-Daas	-	Isabelle LE TRONG
**
**	Versions 		:	1.0		2017-05-30	Version initiale
**	---------------------------------------------------------------------------------------------------------------------
**	PARAMETRES
**
**	$InputDouble		DOUBLE	:	double à traiter
** ======================================================================================================================
**
**	(V)	Variables locales
*/
DECLARE	$OutputDouble	DOUBLE			DEFAULT	0								;
/*
**	(H) HANDLERs
*/
DECLARE	EXIT	HANDLER	FOR SQLEXCEPTION	
BEGIN
		SET		$OutputDouble	=	NULL										;
		RETURN	$OutputDouble													;
END																				;
/*
**	(1)	Check NULL case
*/
IF		($InputDouble	IS NOT NULL)
THEN	SET		$OutputDouble	=	$InputDouble								;
END IF																			;		
/*
**	(EXIT)
*/
RETURN	$OutputDouble															;

END
$$

