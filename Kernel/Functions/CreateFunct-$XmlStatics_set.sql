delimiter $$

DROP									FUNCTION	IF EXISTS	zxitMySQL.$XmlStatics_set	$$
CREATE DEFINER=`iletrong`@`%`		 	FUNCTION 				zxitMySQL.$XmlStatics_set	(

) RETURNS 								INTEGER(10)	UNSIGNED

										DETERMINISTIC
										CONTAINS SQL

COMMENT									'Version 1.0 - 2017-09-28 - Initialisation des Constantes routines XML'
BEGIN
/* ==========================================================================================================================
**	$Statics_set()			Initialisation des Constantes routines XML
***  -------------------------------------------------------------------------------------------------------------------------
**	Auteur			:		IT-DaaS - Isabelle LE TRONG
**
**	Versions		:		1.0		2017-09-28	Version initiale
** ==========================================================================================================================
**
** (V) Variables Locales
**
**		No Local variable
*/
/*
** (H) HANDLERs
*/
DECLARE	EXIT	HANDLER	FOR SQLEXCEPTION	
BEGIN
	RETURN	(1)																								;
END																											;
/*
**	(1)	Set XML Statics
*/
SET	@zxitMySQL$Static$XmlProlog						=	'<?xml version="1.0" encoding="utf-8"?>'			;
SET	@zxitMySQL$Static$XmlPrologSize					=	LENGTH(@zxitMySQL$Static$XmlProlog)					;
SET	@zxitMySQL$Static$XmlOpenComment					=	'<!--'												;
SET	@zxitMySQL$Static$XmlOpenCommentSize				=	LENGTH(@zxitMySQL$Static$XmlOpenComment)				;
SET	@zxitMySQL$Static$XmlCloseComment				=	'-->'												;
SET	@zxitMySQL$Static$XmlCloseCommentSize			=	LENGTH(@zxitMySQL$Static$XmlCloseComment)			;
SET	@zxitMySQL$Static$XmlSingleTag					=	'/'													;
SET	@zxitMySQL$Static$XmlSingleTagSize				=	LENGTH(@zxitMySQL$Static$XmlSingleTag)				;
SET	@zxitMySQL$Static$XmlSpace						=	' '													;
SET	@zxitMySQL$Static$XmlAnd							=	'&'													;
SET	@zxitMySQL$Static$XmlQuot						=	'"'													;
SET	@zxitMySQL$Static$XmlApos						=	'\''												;
SET	@zxitMySQL$Static$XmlOpeningTag					=	'<'													;
SET	@zxitMySQL$Static$XmlOpeningTagSize				=	LENGTH(@zxitMySQL$Static$XmlOpeningTag	)			;	
SET	@zxitMySQL$Static$XmlClosingTag					=	'>'													;
SET	@zxitMySQL$Static$XmlClosingTagSize				=	LENGTH(@zxitMySQL$Static$XmlClosingTag	)			;
SET	@zxitMySQL$Static$XmlClosingElementTag			=	'</'												;
SET	@zxitMySQL$Static$XmlClosingElementTagSize		=	LENGTH(@zxitMySQL$Static$XmlClosingElementTag)		;
SET	@zxitMySQL$Static$XmlSpecialStarts				=	'/,!--'												;
/*
**	(2)	Escape sequence
*/
SET	@zxitMySQL$Static$XmlAndAmpers					=	'&amp'												;
SET	@zxitMySQL$Static$XmlAndLowerThan				=	'&lt'												;
SET	@zxitMySQL$Static$XmlAndGreaterThan				=	'&gt'												;
SET	@zxitMySQL$Static$XmlAndQuot						=	'&quot'												;
SET	@zxitMySQL$Static$XmlAndApos						=	'&apos'												;
/*
**	(M)	Miscellaneous statics for Log usage
*/
SET	@zxitMySQL$Statics$ArgumentIN					=	'IN'												;
SET	@zxitMySQL$Statics$ArgumentINOUT					=	'INOUT'												;
SET	@zxitMySQL$Statics$ArgumentOUT					=	'OUT'												;
/*
**	(EXIT)
*/
RETURN	(0)																									;

END
$$

