DELIMITER $$

DROP									PROCEDURE	IF EXISTS			zxitMySQL.$XmlOpenElement	$$
CREATE DEFINER=`iletrong`@`%`		 	PROCEDURE 						zxitMySQL.$XmlOpenElement	(

OUT		$Status							INTEGER(10)		UNSIGNED									,
OUT		$EndingPosition					SMALLINT(5)		UNSIGNED									,

INOUT	$XmlProlog						TEXT														,

IN		$Tag							VARCHAR(252)												,
IN		$StartingPosition				SMALLINT(5)		UNSIGNED	
)
										DETERMINISTIC
										CONTAINS SQL

COMMENT									'Version 1.0 - 2017-09-29 - Version initiale'
BEGIN
/* ==========================================================================================================================
**	$XmlOpenElement()			Ouverture d'un élement XML
**  -------------------------------------------------------------------------------------------------------------------------
**	TRANSACTIONNEL	:			NON
**	CHECK-IN		:			OUI
**	ETAT			:			Testée
**	REMARQUES		:			Utilisation des statics XML
**  -------------------------------------------------------------------------------------------------------------------------
**	Auteur			:			IT-DaaS - Isabelle LE TRONG
**
**	Versions		:			1.0		2017-09-29	Version initiale
** ==========================================================================================================================
**
** (V) Variables Locales
*/
DECLARE	$Signature	INTEGER(10)					DEFAULT		901100															;
DECLARE	$Version	DECIMAL(4,2)				DEFAULT		1.0																;	
DECLARE	$TagLength	SMALLINT(5)		UNSIGNED																				;
DECLARE	$ActualTag	VARCHAR(252)																							;
/*
** (H) HANDLERs
*/
DECLARE	EXIT	HANDLER	FOR SQLEXCEPTION	
BEGIN
SET		$Status	=	$Signature																								;
END																															;
/*
**	(0)	Set up internal datas, cleanup $Tag (spaces, comments)
*/
SET		$Status		=	0																									;
SET		$ActualTag	=	REPLACE($Tag, ' ','')																				;
SET		$ActualTag	=	zxitMySQL.rlstringFromText($ActualTag, @zxitMySQL$Static$XmlOpenComment)								;
SET		$ActualTag	=	zxitMySQL.rtstringFromText($ActualTag, @zxitMySQL$Static$XmlCloseComment)								;
SET		$TagLength	=	CHAR_LENGTH($ActualTag) + @zxitMySQL$Static$XmlOpeningTagSize + @zxitMySQL$Static$XmlClosingTagSize	;

IF		(	$TagLength	IS	NULL
		OR	$TagLength	=	0
		)
THEN	SET	$Status	=	$Signature	+	1														/* Illegal Tag			*/	;									
/*
**	(1)	Build XML
*/
ELSE	SET	$XmlProlog	=	INSERT	(	
									CONCAT($XmlProlog,' ')						,
									$StartingPosition							,
									$TagLength									,
									CONCAT(	@zxitMySQL$Static$XmlOpeningTag		,
											$ActualTag							,
											@zxitMySQL$Static$XmlClosingTag		)
									)																						;
		SET	$EndingPosition	=	$StartingPosition	+	$TagLength	- 1														;
END IF																														;
/*
**	(EXIT)
*/
END
$$

