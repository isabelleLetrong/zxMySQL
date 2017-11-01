delimiter $$

DROP									PROCEDURE		IF EXISTS		zxitMySQL.$XmlGetPreviousTag		$$
CREATE DEFINER=`iletrong`@`%`			PROCEDURE 						zxitMySQL.$XmlGetPreviousTag		(

OUT		$Status							INTEGER(10)	UNSIGNED											,
OUT		$Tag							TEXT															,
OUT		$FoundPosition					SMALLINT(5)	UNSIGNED											,
OUT		$TagType						BIT(1)															,

IN		$XmlProlog						TEXT															,
IN		$FromPosition					SMALLINT(5)		UNSIGNED
)
										DETERMINISTIC
										CONTAINS SQL

COMMENT									'Version 2.0 - Recherche du Tag précédent dans un message XML'
BEGIN
/* ==========================================================================================================================
**	$XmlGetPreviousTag()	Recherche du Tag précédent dans un message XML
**	-------------------------------------------------------------------------------------------------------------------------
**	TRANSACTIONNEL	:		NON
**	CHECK-IN		:		OUI
**	ETAT			:		Testée
**	-------------------------------------------------------------------------------------------------------------------------
**	Auteur			:		IT-DaaS - Isabelle LE TRONG
**
**	Versions		:		2.0		2017-09-29	Version zxitMySQL
**							1.0		2017-02-07	Version initiale
**	-------------------------------------------------------------------------------------------------------------------------
**	PARAMETRES
**
**	OUT	$Status				INTEGER(10) 	UNSIGNED		:	Code Retour 0 = OK
**	OUT	$Tag				VARCHAR(252)					:	Tag trouvé
**	OUT	$FoundPosition		SMALLINT(5)		UNSIGNED		:	Position dans le message ('<')
**	IN	$TagType			BIT(1)							:	=0	Tag ouvrant
**																=1	Tag fermant
**
**	IN	$XmlProlog			TEXT							:	Debut du message XML
**	IN	$FromPosition		SMALLINT(5)		UNSIGNED		:	Position dans le message ('<')
** ===============================================================================================================================
**
** (V) Variables Locales
*/
DECLARE	$Signature			INTEGER(10)		DEFAULT		901500																	;
DECLARE	$Version			DECIMAL(4,2)	DEFAULT		2.0																		;
DECLARE	$StartOfTagPos		SMALLINT(5)		UNSIGNED																			;	
DECLARE	$EndOfTagPos		SMALLINT(5)		UNSIGNED																			;								
/*
** (H) HANDLERs
*/
DECLARE	EXIT	HANDLER	FOR SQLEXCEPTION	
BEGIN
SET		$Status	=	$Signature																									;
END																																;
/*
**	(0)	Set up internal datas
*/
SET		$Status		=	0																										;
SET		$Tag		=	NULL																									;
SET		$TagType	=	NULL																									;
/*
**	(1)	Get position
*/
SET		$FoundPosition	=	zxitMySQL.LocateFwd(@zxitMySQL$Static$XmlOpeningTag, $XmlProlog, $FromPosition-1)						;

IF		($FoundPosition	IS NULL)
THEN	SET	$Status	=	$Signature	+	2									/* trouble calling LocateFwd()					*/	;
/*
**	(2)	Get Tag if exists
*/
ELSE	IF		($FoundPosition	!= 0)	
		THEN	IF		(@zxitMySQL$Static$XmlClosingElementTag	=	SUBSTRING(	$XmlProlog										, 
																				$FoundPosition									,
																				@zxitMySQL$Static$XmlClosingElementTagSize	))
				THEN	SET	$TagType		=	1																				;
						SET	$StartOfTagPos	=	$FoundPosition	+	@zxitMySQL$Static$XmlClosingElementTagSize					;
				ELSE	SET	$TagType		=	0																				;
						SET	$StartOfTagPos	=	$FoundPosition	+	@zxitMySQL$Static$XmlOpeningTagSize							;
				END IF																											;
				SET		$EndOfTagPos		=	LOCATE(	@zxitMySQL$Static$XmlClosingTag, $XmlProlog, $StartOfTagPos)			;
				SET		$Tag				=	SUBSTRING($XmlProlog FROM $StartOfTagPos FOR ($EndOfTagPos - $StartOfTagPos))	;

		ELSE	SET		$Status				=	$Signature	+	1							/* Not found					*/	;
		END IF																													;
END IF																															;
/*
**	(EXIT)
*/
END
$$

