DELIMITER $$

DROP									PROCEDURE		IF EXISTS			zxitMySQL.$Log_insertArgument	$$
CREATE DEFINER=`iletrong`@`%`		 	PROCEDURE 							zxitMySQL.$Log_insertArgument	(

OUT		$Status							INTEGER(10)		UNSIGNED											,
OUT		$ArgumentEndingPosition			SMALLINT(5)		UNSIGNED											,

INOUT	$XmlProlog						TEXT																,

IN		$ArgumentStartingPosition		SMALLINT(5)		UNSIGNED											,
IN		$ArgumentName					VARCHAR(252)														,
IN		$ArgumentType					VARCHAR(16)															,										
IN		$ArgumentValue					VARCHAR(252)
)
										DETERMINISTIC
										CONTAINS SQL

COMMENT									'Version 1.1 - Insertion d\'un paramètre dans un élement XML'
BEGIN
/* ==========================================================================================================================
**	$Log_insertArgument()	Insertion d'un paramètre dans un élement XML
**	-------------------------------------------------------------------------------------------------------------------------
**	TRANSACTIONNEL	:		NON
**	CHECK-IN		:		OUI
**	ETAT			:		Testée
**	-------------------------------------------------------------------------------------------------------------------------
**	Auteur			:		IT-DaaS - Isabelle LE TRONG
**
**	Versions		:		1.1		2017-10-04	Substitution de l'appel de LENGTH()	par CHAR_LENGTH() en (4)
**							1.0		2017-09-29	Version initiale portée sur zxitMySQL
**	-------------------------------------------------------------------------------------------------------------------------
**	PARAMETRES
**
**	OUT		$Status						INTEGER(10) 	UNSIGNED	:	Code Retour 0 = OK
**	OUT		$ArgumentEndingPosition		SMALLINT(5)		UNSIGNED	:	Position finale de fin du paramètre
**
**	INOUT	$XmlProlog					TEXT						:	Début de la séquence XML
**
**	IN		$ArgumentStartingPosition	SMALLINT(5)		UNSIGNED	:	Position initiale de début du paramètre
**	IN		$ArgumentName				VARCHAR(252)				:	Nom du paramètre à insérer
**	IN		$ArgumentType				VARCHAR(16)					;	Type de paramètre ('IN' vs 'OUT')
**	IN		$ArgumentValue				VARCHAR(252)				:	Valeur du paramètre à insérer
** ==========================================================================================================================
**
** (V) Variables Locales
*/
DECLARE	$Signature			INTEGER(10)		UNSIGNED	DEFAULT		901200													;
DECLARE	$Version			DECIMAL(4,2)				DEFAULT		1.1														;
DECLARE	$AttributeType		VARCHAR(4)					DEFAULT		'Type'													;
DECLARE	$ActualValue		VARCHAR(252)																					;
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
SET		$Status				=	0																							;
SET		$ActualValue		=	REPLACE($ArgumentValue, @zxitMySQL$Static$XmlAnd, @zxitMySQL$Static$XmlAndAmpers)				;
SET		$ActualValue		=	REPLACE($ActualValue, @zxitMySQL$Static$XmlOpeningTag, @zxitMySQL$Static$XmlAndLowerThan)		;
SET		$ActualValue		=	REPLACE($ActualValue, @zxitMySQL$Static$XmlClosingTag, @zxitMySQL$Static$XmlAndGreaterThan)	;
SET		$ActualValue		=	REPLACE($ActualValue, @zxitMySQL$Static$XmlQuot, @zxitMySQL$Static$XmlAndQuot)				;
SET		$ActualValue		=	REPLACE($ActualValue, @zxitMySQL$Static$XmlApos, @zxitMySQL$Static$XmlAndApos)				;

IF		($ActualValue IS NULL)
THEN	SET	$ActualValue	=	''																							;
END IF																														;
/*
**	(1)	Insert Argument Element Tag
*/
CALL	zxitMySQL.$XmlOpenElement			(

				$Status						,
				$ArgumentEndingPosition		,
	
				$XmlProlog					,

				$ArgumentName				,
				$ArgumentStartingPosition	)																				;

IF		($Status	!=	0)
THEN	SET	$Status	=	$Signature	+	1										/* unable to insert argument Tag		*/	;
/*
**	(2)	Insert Argument Type
*/
ELSE	CALL	zxitMySQL.$XmlInsertAttributeInCurrentElement	(

									$Status						,
									$ArgumentEndingPosition		,

									$XmlProlog					,

									$ArgumentEndingPosition		,
									$AttributeType				,
									$ArgumentType				)															;

		IF		($Status	!=	0)
		THEN	SET	$Status	=	$Signature	+	2								/* unable to insert argument type		*/	;
/*
**	(3)	Insert Argument Value
*/
		ELSE	SET	$XmlProlog	=	CONCAT($XmlProlog, $ActualValue)														;
/*
**	(4)	Insert Argument Element Closing Tag
*/
				CALL	zxitMySQL.$XmlCloseElement											(

							$Status															,
							$ArgumentEndingPosition											,

							$XmlProlog														,

							$ArgumentName													,
							$ArgumentEndingPosition	+	CHAR_LENGTH($ActualValue)	+	1	)								;

				IF		($Status	!=	0)
				THEN	SET	$Status	=	$Signature	+	3						/* unable to insert Element closing tag	*/	;
				END IF																										;
		END IF																												;
END IF																														;

/*
**	(EXIT)
*/
END
$$

