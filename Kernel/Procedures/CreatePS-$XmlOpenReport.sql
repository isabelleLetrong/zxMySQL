DELIMITER $$

DROP									PROCEDURE	IF EXISTS			zxitMySQL.$XmlOpenReport	$$
CREATE DEFINER=`iletrong`@`%`		 	PROCEDURE 						zxitMySQL.$XmlOpenReport	(

OUT	$XmlPrologSize						SMALLINT(5)	UNSIGNED										,
OUT	$XmlProlog							TEXT
)
BEGIN
/* ==========================================================================================================================
**	$XmlOpenReport()		Création d'un message XML - retourne le prologue
**	-------------------------------------------------------------------------------------------------------------------------
**	TRANSACTIONNEL	:		NON
**	CHECK-IN		:		OUI
**	ETAT			:		Testée
**	REMARQUES		:		Utilisation des statics XML
**	-------------------------------------------------------------------------------------------------------------------------
**	Auteur			:		IT-DaaS - Isabelle LE TRONG
**
**	Versions		:		1.0		2017-03-07	Version initiale
** ==========================================================================================================================
**
** (V) Local datas
**
**	No local datas
*/
/*
** (H) HANDLERs
*/
DECLARE	EXIT	HANDLER	FOR SQLEXCEPTION	
BEGIN
		SET	$XmlPrologSize	=	0																		;
END																										;
/*
**	(0)	Set up internal datas
*/
SET		$XmlPrologSize	=	zxitMySQL.$XmlStatics_set()													;

IF		($XmlPrologSize	!= 0)

THEN	SET	$XmlPrologSize	=	0																		;
ELSE	SET	$XmlProlog		=	@zxitMySQL$Static$XmlProlog												;
		SET	$XmlPrologSize	=	@zxitMySQL$Static$XmlPrologSize											;
END IF																									;
/*
**	(EXIT)
*/
END
$$

