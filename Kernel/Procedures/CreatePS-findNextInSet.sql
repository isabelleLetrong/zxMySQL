delimiter $$

DROP							PROCEDURE	IF EXISTS	zxitMySQL.findNextInSet	$$
CREATE DEFINER=`iletrong`@`%`	PROCEDURE 				zxitMySQL.findNextInSet	(

OUT	$Next			VARCHAR(255)												,
OUT	$NextPosition	TINYINT(3)		UNSIGNED									,

IN	$Set			VARCHAR(255)												,
IN	$SetSize		TINYINT(3)		UNSIGNED									,
IN	$Position		TINYINT(3)		UNSIGNED
)
					DETERMINISTIC
					CONTAINS SQL

COMMENT				'Version 1.0 - Retourne le string suivant dans un Set'

BEGIN
/* ============================================================================================================
**	findNextInSet		-		Retourne le string suivant dans un Set
**								Le Set est organisé de la manière suivante : 'Mot1,Mot2,Mot3,...'
**	-----------------------------------------------------------------------------------------------------------
**	TRANSACTIONNELLE	:		NON
**	CHECK IN Arguments	:		NON
**	ETAT				:		Testée
**	-----------------------------------------------------------------------------------------------------------							
**	Auteur				:		IT-DaaS - Isabelle LE TRONG
**
**								1.0		2016-01-14	Version initiale
**	-----------------------------------------------------------------------------------------------------------	
**	PARAMETRES
**
**	OUT	$Next			VARCHAR(255)						:	String Suivant	
**	OUT	$NextPosition	TINYINT(3)		UNSIGNED			:	Position immédiate derrière le string
**																(',' ou longueur du set + 1)
**
**	IN	$Set			VARCHAR(255)						:	Set de strings
**	IN	$SetSize		TINYINT(3)		UNSIGNED			:	Taille en charactère du Set (CHAR_LENGTH($Set))				,
**	IN	$Position		TINYINT(3)		UNSIGNED			:	Position de recherche dans le Set
** ============================================================================================================
**
** (V) Variables Locales
*/
DECLARE	$Version	DECIMAL(4,2)	UNSIGNED	DEFAULT	1.0								;
DECLARE	$Tag		VARCHAR(1)					DEFAULT ','								;
/*
** (H) HANDLERs
*/
DECLARE	EXIT		HANDLER	FOR SQLEXCEPTION	
BEGIN
	SET	$Next 			=	NULL														;
	SET	$NextPosition	=	NULL														;
END																						;
/*
**	(0)	Initialise Local variables
*/
SET	$Next			=	''																;
SET	$NextPosition	=	$Position														;

IF	($SetSize	>= $Position)
/*	
**	(1)	Locate Next substring
*/
THEN	WHILE	(	$NextPosition 	<= 	$SetSize
				AND SUBSTRING($Set, $NextPosition , 1) != $Tag
				)

			DO	SET	$Next			=	CONCAT($Next, SUBSTRING($Set, $NextPosition,1))	;
				SET	$NextPosition	=	$NextPosition	+	1							;

			END WHILE																	;

ELSE	SET	$Next			=	NULL													;
END	IF																					;
/*
**	(EXIT)
*/
END
$$

