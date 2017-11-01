delimiter $$

DROP							FUNCTION	IF EXISTS	zxitMySQL.beginLikeSet	$$	
CREATE 	DEFINER=`iletrong`@`%` 	FUNCTION				zxitMySQL.beginLikeSet	(

$String							VARCHAR(255)									,
$Set							VARCHAR(255)

) RETURNS 						BIT(1)

								DETERMINISTIC
								CONTAINS SQL

COMMENT							'Version 1.0 - Retourne 1 si le String commence par un des mots du Set'

BEGIN
/* ===============================================================================================
**	beginLikeSet	-	Retourne 1 si le String commence par un des mots du Set
**						Le Set est organisé de la manière suivante : 'Mot1,Mot2,Mot3,...'
**	----------------------------------------------------------------------------------------------
**	Auteur			:	IT-DaaS	-	Isabelle LE TRONG
**
**	Versions 		:	1.0		2017-03-24	Version initiale
**	----------------------------------------------------------------------------------------------
**	PARAMETRES
**
**	$String				VARCHAR(255)		:	String dans lequel on recherche un mot clé
**	$Set				VARCHAR(255)		:	Liste des mots clés
** ===============================================================================================
**
** (V) Variables Locales
*/
DECLARE	$Version			DECIMAL(4,2)	UNSIGNED	DEFAULT	1.0								;
DECLARE	$NextPosition		TINYINT(3) 		UNSIGNED											;
DECLARE	$CurPosition		TINYINT(3) 		UNSIGNED											;
DECLARE	$SetSize			TINYINT(3)		UNSIGNED											;
DECLARE	$WordInSet			VARCHAR(255)														;
DECLARE	$In					BIT(1)																;
/*
**	(0)	Initialise Local variables
*/
SET	$SetSize		=	CHAR_LENGTH($Set)														;
SET	$NextPosition	=	0																		;
SET	$In				=	0																		;
/*	
**	(1)	Locate Next Word In Set
*/
WHILE	(	$NextPosition	<= $setSize
		AND	$In				!= 1
		)

	DO	SET	$CurPosition	=	$NextPosition + 1												;
		
		CALL	zxitMySQL.findNextInSet	(

					$WordInSet			,
					$NextPosition		,

					$Set				,
					$SetSize			,
					$CurPosition		)														;

				IF		($WordInSet	IS NOT NULL)
				THEN	IF	(SUBSTRING($String,1,$NextPosition-$CurPosition)	=	$WordInSet)
						THEN	SET	$In = 1														;
						END	IF																	;
				END IF																			;
	END WHILE																					;
/*
**	(EXIT)
*/
RETURN($In)																						;

END
$$

