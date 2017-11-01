/*	=====================================================================================================================================================
**	$zxitMySQLBuildKernelTables		Cette procédure crée les tables brutes (sans triggers) de la base zxitMySQL
**	-----------------------------------------------------------------------------------------------------------------------------------------------------							
**	Auteur				:	IT-DaaS - Isabelle LE TRONG
**	-----------------------------------------------------------------------------------------------------------------------------------------------------
**	Versions zxitMySQL	:	4.0.0		2017-10-21	RTM release
**	=====================================================================================================================================================
*/
DELIMITER $$
/*
**	==================================================================================================================
**	(S)	Start Procedure
**	==================================================================================================================
*/
SELECT	'Starting procedure zxitMySQLBuildKernelTables at ', NOW() AS StartingTime					$$
/*
**	(INIT)	Suppression des Tables de zxitMySQLBuildKernel et recréation du schéma
**
*/
DROP 	DATABASE IF EXISTS	`zxitMySQL`																$$
CREATE 	DATABASE 			`zxitMySQL` 
	DEFAULT CHARACTER SET 	utf8																	$$
/*
**	TABLE	1	$Signatures
*/
DROP	TABLE	IF	EXISTS		zxitMySQL.$Signatures												$$
CREATE 	TABLE 					zxitMySQL.$Signatures 												(
	
  `id`		int(10)				unsigned	NOT NULL												,
  `Name`	varchar(128) 					NOT NULL
		COMMENT 'Procedure or Function Name'														,

  PRIMARY KEY (`id`)
  
) ENGINE=InnoDB DEFAULT CHARSET=utf8
		COMMENT='Table de signature des procédures stockées et Fonctions'							$$
/*
**	TABLE	2	$Status
*/
DROP	TABLE	IF	EXISTS		zxitMySQL.$Status													$$
CREATE	TABLE					zxitMySQL.$Status 													(

  `Signature`	int(10) 		unsigned	NOT NULL												,
  `Status` 		tinyint(3) 		unsigned	NOT NULL												,
  `Libelle`		varchar(255) 				NOT NULL												,

  PRIMARY KEY (`Signature`,`Status`)																,
  KEY `$Status_Signature_idx` (`Signature`)															,

  CONSTRAINT `$Status_Signature`
		FOREIGN KEY (`Signature`) REFERENCES zxitMySQL.$Signatures (`id`)
			ON DELETE CASCADE
			ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8
		COMMENT='Table des Code Retour des Procédures Stockées'										$$
/*
**	(LOG)			Création des tables de Log
**
**	(LOG-1)			Table $Log
*/
DROP	TABLE		IF EXISTS	zxitMySQL.$Log								$$
CREATE 	TABLE 					zxitMySQL.$Log	 							(

  `id` 				bigint(20)		unsigned	NOT NULL	AUTO_INCREMENT	,
  `DateTime`		datetime 					NOT NULL					,
  `Signature` 		int(10) 		unsigned 	NOT NULL
		COMMENT 'Signature du composant reportant'							,
  `Version` 		decimal(4,2)	unsigned 	NOT NULL
		COMMENT 'Version du composant reportant'							,
  `Status` 			int(10)			unsigned	NOT NULL
		COMMENT 'Code Statut retourné'										,
  `Step` 			int(10)			unsigned 	NOT NULL
		COMMENT 'Etape retournée'											,

  PRIMARY KEY (`id`)

) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8
		COMMENT='Journal des appels'										$$
/*
**	(LOG-2)			Table $LogArgumentsIN
*/
DROP	TABLE		IF EXISTS	zxitMySQL.$LogArgumentsIN				$$
CREATE 	TABLE 					zxitMySQL.$LogArgumentsIN				(

  `LogID`			bigint(20)	unsigned	NOT NULL					,
  `Arguments` 		text 					NOT NULL					,

  PRIMARY KEY (`LogID`)													,

  CONSTRAINT `$LogArgumentsIN_LogID_FK`
		FOREIGN KEY (`LogID`) REFERENCES zxitMySQL.$Log (`id`)
			ON DELETE CASCADE
			ON UPDATE CASCADE

) ENGINE=InnoDB DEFAULT CHARSET=utf8
		COMMENT='Journal des Paramètres en entrée'						$$
/*
**	(LOG-3)			Table $LogArgumentsINOUT
*/
DROP	TABLE		IF EXISTS	zxitMySQL.$LogArgumentsINOUT				$$
CREATE 	TABLE 					zxitMySQL.$LogArgumentsINOUT				(

  `LogID`			bigint(20)	unsigned	NOT NULL					,
  `Arguments` 		text 					NOT NULL					,

  PRIMARY KEY (`LogID`)													,

  CONSTRAINT `$LogArgumentsINOUT_LogID_FK`
		FOREIGN KEY (`LogID`) REFERENCES zxitMySQL.$Log (`id`)
			ON DELETE CASCADE
			ON UPDATE CASCADE

) ENGINE=InnoDB DEFAULT CHARSET=utf8
		COMMENT='Journal des Paramètres en entrée/sortie'				$$
/*
**	(LOG-4)			Table $LogArgumentsOUT
*/
DROP	TABLE		IF EXISTS	zxitMySQL.$LogArgumentsOUT				$$
CREATE 	TABLE 					zxitMySQL.$LogArgumentsOUT				(

  `LogID`			bigint(20)	unsigned	NOT NULL					,
  `Arguments` 		text 					NOT NULL					,

  PRIMARY KEY (`LogID`)													,

  CONSTRAINT `$LogArgumentsOUT_LogID_FK`
		FOREIGN KEY (`LogID`) REFERENCES zxitMySQL.$Log (`id`)
			ON DELETE CASCADE
			ON UPDATE CASCADE

) ENGINE=InnoDB DEFAULT CHARSET=utf8
		COMMENT='Journal des Paramètres en sortie'						$$
