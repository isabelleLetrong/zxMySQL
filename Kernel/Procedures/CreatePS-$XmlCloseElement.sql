delimiter $$

DROP									PROCEDURE		IF EXISTS		zxitMySQL.$XmlCloseElement	$$
CREATE DEFINER=`iletrong`@`%`			PROCEDURE 						zxitMySQL.$XmlCloseElement	(

OUT		$Status							INTEGER(10)		UNSIGNED									,
OUT		$EndingPosition					SMALLINT(5)		UNSIGNED									,

INOUT	$XmlProlog						TEXT														,

IN		$Tag							VARCHAR(252)												,
IN		$StartingPosition				SMALLINT(5)		UNSIGNED	
)
										DETERMINISTIC
										CONTAINS SQL

COMMENT									'Version 2.0 - Fermeture d\'un élement XML - L\'élement a du etre ouvert'
BEGIN
/* ==========================================================================================================================
**	$XmlCloseElement()			Fermeture d'un élement XML - L'élement a du etre ouvert
***  -------------------------------------------------------------------------------------------------------------------------
**	Auteur			:			IT-DaaS - Isabelle LE TRONG
**
**	Versions		:			2.0		2017-09-29	Version zxitMySQL
**								1.1		2017-02-23	Utilisation des statics globales
**								1.0		2017-02-01	Version initiale
** ==========================================================================================================================
**
** (V) Variables Locales
*/
DECLARE	$Signature		INTEGER(10)		DEFAULT		901400																	;
DECLARE	$Version		DECIMAL(4,2)	DEFAULT		2.0																		;
DECLARE	$TargetTag		VARCHAR(253)																						;
DECLARE	$OTag			VARCHAR(256)																						;
DECLARE	$CTag			VARCHAR(256)																						;
DECLARE	$CTagLength		SMALLINT(5)		UNSIGNED																			;												
/*
** (H) HANDLERs
*/
DECLARE	EXIT	HANDLER	FOR SQLEXCEPTION	
BEGIN
SET		$Status	=	$Signature																								;
END																															;
/*
**	(0)	Set up internal datas
*/
SET		$Status			=	$Signature +	1													/* Opening Tag Missing	*/	;
SET		$TargetTag		=	REPLACE($Tag, ' ','')																			;
SET		$OTag			=	CONCAT(@zxitMySQL$Static$XmlOpeningTag, $TargetTag)												;
SET		$CTag			=	CONCAT(@zxitMySQL$Static$XmlClosingElementTag,$TargetTag,@zxitMySQL$Static$XmlClosingTag)			;
SET		$CTagLength		=	CHAR_LENGTH($CTag)																				;

IF		(	$StartingPosition	IS NOT NULL
		AND	$StartingPosition	!=	0
		)
/*
**	(1)	Locate	previous tag
*/	
THEN	SET	$EndingPosition	=	zxitMySQL.LocateFwd			(

										$OTag				,
										$XmlProlog			,
										$StartingPosition	)																;
/*
**	(2)	Build XML
*/
		IF	(	$EndingPosition	IS NOT NULL
			AND	$EndingPosition	!=	0
			)
		THEN	SET	$XmlProlog		=	INSERT(CONCAT($XmlProlog,' '), $StartingPosition,$CTagLength,$CTag)					;
				SET	$EndingPosition	=	$StartingPosition	+	$CTagLength	-	1											;
				SET	$Status			=	0																					;
		END IF																												;
END IF																														;
/*
**	(EXIT)
*/
END
$$

