DELIMITER $$

DROP							PROCEDURE	IF	EXISTS	zxitMySQL.get$Version				$$
CREATE DEFINER=`iletrong`@`%` 	PROCEDURE 				zxitMySQL.get$Version				(

OUT	$Status						INTEGER(10)	UNSIGNED									,
OUT	$Release					SMALLINT 	UNSIGNED									,
OUT	$Version					SMALLINT 	UNSIGNED									,
OUT	$Build						SMALLINT 	UNSIGNED									,
OUT	$BuildDate					DATE													,
OUT	$SignatureVersion			VARCHAR(64)												,
OUT	$MySQLVersion				VARCHAR(32)												,
OUT	$DataBaseName				VARCHAR(64)
)
								DETERMINISTIC
								CONTAINS SQL

COMMENT							'Version 4.0.0 - 2017-10-30 Retourne la version de zxitMySQL'
BEGIN
/* ===============================================================================================
**	get$Version()		Retourne la version de zxitMySQL
** ===============================================================================================
**
** (V) Variables Locales
*/
DECLARE	$Signature			INTEGER(10)	UNSIGNED	DEFAULT 900000						;
DECLARE	$CurRelease			SMALLINT 	UNSIGNED	DEFAULT	4							;
DECLARE	$CurVersion			SMALLINT	UNSIGNED	DEFAULT	0							;
DECLARE	$CurBuild			SMALLINT	UNSIGNED	DEFAULT 0							;
DECLARE	$CurBuildDate		DATE					DEFAULT	'2017-10-30'				;
/*
** (H) HANDLERs
*/
DECLARE	EXIT	HANDLER	FOR SQLEXCEPTION	
BEGIN
	SET	$Status	=	$Signature															;
END																						;
/*
**	(1)	Set OutPut Arguments
*/
SET	$Release			=	$CurRelease													;
SET	$Version			=	$CurVersion													;
SET	$Build				=	$CurBuild													;
SET	$BuildDate			=	$CurBuildDate												;

SET	$SignatureVersion	=	CONCAT(
									'zxitMySQL Version '							,
									CAST($Release AS CHAR)						,
									'.'											,
									CAST($Version AS CHAR)						,
									'.'											,
									CAST($Build AS CHAR)						,
									DATE_FORMAT($BuildDate, ' %d-%m-%Y built')	)		;

SET	$MySQLVersion		=	VERSION()													;
SET	$DataBaseName		=	DATABASE()													;

SET	$Status 			=	0															;

END
$$

