delimiter $$

DROP									PROCEDURE		IF EXISTS		zxitMySQL.$XmlInsertAttributeInCurrentElement	$$
CREATE DEFINER=`iletrong`@`%`		 	PROCEDURE 						zxitMySQL.$XmlInsertAttributeInCurrentElement	(

OUT		$Status							INTEGER(10)		UNSIGNED														,
OUT		$ClosingTagEndingPosition		SMALLINT(5)		UNSIGNED														,

INOUT	$XmlProlog						TEXT																			,

IN		$ClosingTagStartingPosition		SMALLINT(5)		UNSIGNED														,
IN		$AttributeName					VARCHAR(252)																	,
IN		$AttributeValue					VARCHAR(252)
)
										DETERMINISTIC
										CONTAINS SQL

COMMENT									'Version 1.0 - Version initiale zxitMySQL'
BEGIN

/* ==========================================================================================================================
**	$XmlInsertAttributeInCurrentElement()	Insertion d'un attribut dans un élement XML
**	-------------------------------------------------------------------------------------------------------------------------
**	TRANSACTIONNEL	:		NON
**	CHECK-IN		:		OUI
**	ETAT			:		Testée
**	REMARQUES		:		Utilisation des statics XML
**	-------------------------------------------------------------------------------------------------------------------------
**	Auteur			:		IT-DaaS - Isabelle LE TRONG
**
**	Versions		:		1.0		2017-10-02	Version initiale zxitMySQL
**	-------------------------------------------------------------------------------------------------------------------------
**	PARAMETRES
**
**	OUT		$Status						INTEGER(10) 	UNSIGNED	:	Code Retour 0 = OK
**	OUT		$ClosingTagEndingPosition	SMALLINT(5)		UNSIGNED	:	Position finale du tag de fermeture ('>)'
**
**	INOUT	$XmlProlog					TEXT						:	Début de la séquence XML
**
**	IN		$ClosingTagStartingPosition	SMALLINT(5)		UNSIGNED	:	Position initiale du tag de fermeture ('>)'
**	IN		$AttributeName				VARCHAR(252)				:	Nom de l'attribut à insérer
**	IN		$AttributeValue				VARCHAR(252)				:	Valeur de l'attribut à insérer
** ==========================================================================================================================
**
** (V) Variables Locales
*/
DECLARE	$Signature			INTEGER(10)		UNSIGNED	DEFAULT		901300													;
DECLARE	$Version			DECIMAL(4,2)				DEFAULT		1.0														;
DECLARE	$AttributeNameSize	INTEGER(10)		UNSIGNED																		;
DECLARE	$AttributeValueSize	INTEGER(10)		UNSIGNED																		;
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
SET		$Status						=	0																					;
SET		$AttributeNameSize			=	CHAR_LENGTH($AttributeName)															;
SET		$AttributeValueSize			=	CHAR_LENGTH($AttributeValue)														;
SET		$ClosingTagEndingPosition	=	5+$AttributeNameSize+$AttributeValueSize											;
/*
**	(1)	Check $ClosingTag
*/
IF	(	SUBSTRING(	$XmlProlog	FROM	(1+	$ClosingTagStartingPosition	-	@zxitMySQL$Static$XmlClosingTagSize)
								FOR		@zxitMySQL$Static$XmlClosingTagSize)
	!=	@zxitMySQL$Static$XmlClosingTag	
	)
THEN	SET	$Status	=	$Signature +	1														/* invalid Closing Tag	*/	;
/*
**	(2)	Insert resquested Attribute
*/
ELSE	SET	$XmlProlog	=	INSERT	(
									$XmlProlog								,
									$ClosingTagStartingPosition				,
									$ClosingTagEndingPosition				,
									CONCAT(	' '								,
											$AttributeName,
											'='								,
											@zxitMySQL$Static$XmlQuot		,
											$AttributeValue					,
											@zxitMySQL$Static$XmlQuot		,
											@zxitMySQL$Static$XmlClosingTag	)
									)																						;

		SET	$ClosingTagEndingPosition	=	$ClosingTagEndingPosition	+	$ClosingTagStartingPosition	-	1				;
END IF																														;
/*
**	(EXIT)
*/
END
$$

