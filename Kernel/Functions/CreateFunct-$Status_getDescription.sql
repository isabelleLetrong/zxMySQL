delimiter $$

DROP							FUNCTION		IF	EXISTS	zxitMySQL.$Status_getDescription	$$
CREATE DEFINER=`iletrong`@`%` 	FUNCTION 					zxitMySQL.$Status_getDescription	(

$InStatus						INTEGER(10)		UNSIGNED

) RETURNS varchar(255) CHARSET utf8
    READS SQL DATA
    COMMENT 'Version 3.0 - Retourne le libellé d''un code retour de Procédure Stockée'
BEGIN
/* ===============================================================================================================
**	$Status_getDescription()	Retourne le libellé d'un code retour de Procédure Stockée
**								SPECIAL MySQL 5.5 Usage
***	--------------------------------------------------------------------------------------------------------------
**	Auteur			:			IT-DaaS	-	Isabelle LE TRONG
**
**	Versions 		:			3.0		2017-03-24	Recherche de l'émetteur
**								2.0		2016-03-08	Documente MySQL_ERRNO dans le message
**								1.0		2015-04-22	Version initiale
**	--------------------------------------------------------------------------------------------------------------
**	PARAMETRES
**
**	$InStatus					INTEGER(10) 	UNSIGNED		:	Valeur du CodeRetour
** ===============================================================================================================
**
** (V) Variables Locales
*/
DECLARE	$Version				DECIMAL(4,2)	UNSIGNED	DEFAULT	3.0											;
DECLARE	$ConditionId			INTEGER(10)		UNSIGNED	DEFAULT	NULL										;
DECLARE	$SenderShiftFactor		INTEGER(10)		UNSIGNED	DEFAULT	100000										;
DECLARE	$ProcedureShiftFactor	INTEGER(10)		UNSIGNED	DEFAULT	100											;
DECLARE	$Description			VARCHAR(255)				DEFAULT	NULL										;
DECLARE	$ProcedureName			VARCHAR(128)				DEFAULT	NULL										;
DECLARE	$ProcedureNameDefault	VARCHAR(8)					DEFAULT	'engine'									;
DECLARE	$MySQLReport			VARCHAR(128)				DEFAULT	'No MySQL Diagnostics'						;
DECLARE	$Sender					VARCHAR(32)																		;
DECLARE	$DefaultSender			VARCHAR(32)					DEFAULT	'zxitMySQL(unknown DB)'						;
DECLARE	$DefaultDescription		VARCHAR(32)					DEFAULT	'no additional details avalaible'			; 
DECLARE	$MySQL_ERRNO			VARCHAR(8)																		;
DECLARE	$Signature				INTEGER(10)		UNSIGNED														;
DECLARE	$Status					TINYINT 		UNSIGNED														;
/*
**	(1)	Get $Sender 
*/
SET		$Signature			=	CAST(FLOOR($InStatus/$SenderShiftFactor) AS UNSIGNED)*$SenderShiftFactor		;

SELECT	Name
FROM	zxitMySQL.$Signatures
WHERE	id	=	$Signature
INTO	$Sender																									;

IF		($Sender	IS NULL)
THEN	SET	$Sender	=	$DefaultSender																			;
END IF																											;
/*
**	(2)	Get $ProcedureName 
*/
SET		$Signature			=	CAST(FLOOR($InStatus/$ProcedureShiftFactor) AS UNSIGNED)*$ProcedureShiftFactor	;

SELECT	Name
FROM	zxitMySQL.$Signatures
WHERE	id	=	$Signature
INTO	$ProcedureName																							;

IF		($ProcedureName	IS NULL)
THEN	SET	$ProcedureName	=	$ProcedureNameDefault															;
END IF																											;

SET	$ProcedureName	=	CONCAT($Sender, '.', $ProcedureName)													;
/*
**	(3)	Get $Status Description
*/
SET		$Status			=	$InStatus -	$Signature													;

SELECT	Libelle
FROM	zxitMySQL.$Status
WHERE	Signature	=	$Signature
	AND	Status		=	$Status
INTO	$Description																				;

IF		($Description IS NULL)
THEN	SET	$Description	=	$DefaultDescription													;
END IF																								;
/*
**	(4)	Get possible MySQL Diagnostics	(only for MySQL 5.6.4 or higher releases)
**
*/
/*
GET CURRENT DIAGNOSTICS
	$ConditionId	=	NUMBER																		;

IF	(	$ConditionId	 IS NOT NULL
	AND	$ConditionId	>	0
	)
THEN	GET DIAGNOSTICS	CONDITION	$ConditionId
			$MySQL_ERRNO	=	MYSQL_ERRNO															,
			$MySQLReport	=	MESSAGE_TEXT														;
ELSE	SET	$MySQL_ERRNO	=	'0000'																;
END IF																								;
*/
SET	$MySQL_ERRNO	=	'0000'																		;
/*
**	(EXIT)
*/
RETURN CONCAT(	'Status : '			,	CAST($InStatus AS CHAR)						,
				' émis par '		,	$ProcedureName,' : ', $Description			,
				' - MySQL_ERRNO : '	, 	$MySQL_ERRNO								,
				' : '				,	$MySQLReport								)				;

END
$$

