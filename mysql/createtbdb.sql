# SQL Manager for MySQL 5.4.3.43929
# ---------------------------------------
# Host     : tbdb.homesmartagent.com
# Port     : 3306
# Database : USE SPECIFIC MLS NAME 
# Change CREATE DATABASE and USE to appropriate MLS

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES latin1 */;

SET FOREIGN_KEY_CHECKS=0;

CREATE DATABASE `mls_tx_txccar-h`
    CHARACTER SET 'latin1'
    COLLATE 'latin1_swedish_ci';

USE `mls_tx_txccar-h`;

#
# Dropping database objects
#

DROP VIEW IF EXISTS `view_homesmart_solr`;
DROP PROCEDURE IF EXISTS `Sync_Properties_Images`;
DROP TABLE IF EXISTS `users_ptnf`;
DROP TABLE IF EXISTS `property_ptnf`;
DROP TABLE IF EXISTS `openhouse_ptnf`;
DROP TABLE IF EXISTS `links_ptnf`;
DROP TABLE IF EXISTS `features_ptnf`;
DROP TABLE IF EXISTS `broker_ptnf`;

#
# Structure for the `broker_ptnf` table :
#

CREATE TABLE `broker_ptnf` (
  `ID` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `TERABITZ_ID` BIGINT(20) UNSIGNED DEFAULT NULL,
  `TYPE` VARCHAR(45) COLLATE latin1_swedish_ci DEFAULT NULL,
  `NAME` VARCHAR(150) COLLATE latin1_swedish_ci DEFAULT NULL,
  `URL` TEXT COLLATE latin1_swedish_ci,
  `LOGO_URL` TEXT COLLATE latin1_swedish_ci,
  `CODE` VARCHAR(45) COLLATE latin1_swedish_ci DEFAULT NULL,
  PRIMARY KEY USING BTREE (`ID`) COMMENT '',
  UNIQUE INDEX `broker_ptnf_idx1` USING BTREE (`TERABITZ_ID`, `TYPE`) COMMENT '',
   INDEX `idx_teraid` USING BTREE (`TERABITZ_ID`) COMMENT '',
   INDEX `idx_bkd` USING BTREE (`CODE`) COMMENT ''
)ENGINE=MyISAM
AUTO_INCREMENT=2405069 AVG_ROW_LENGTH=65 CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci'
COMMENT=''
;

#
# Structure for the `features_ptnf` table :
#

CREATE TABLE `features_ptnf` (
  `ID` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `TERABITZ_ID` BIGINT(20) NOT NULL,
  `APPLIANCE` TEXT COLLATE latin1_swedish_ci,
  `ARCHITECTURESTYLE` TEXT COLLATE latin1_swedish_ci,
  `ATTIC` TEXT COLLATE latin1_swedish_ci,
  `BARBECUEAREA` TEXT COLLATE latin1_swedish_ci,
  `BASEMENT` TEXT COLLATE latin1_swedish_ci,
  `BUILDINGUNITCOUNT` TEXT COLLATE latin1_swedish_ci,
  `CABLEREADY` TEXT COLLATE latin1_swedish_ci,
  `CELLINGFAN` TEXT COLLATE latin1_swedish_ci,
  `CONDOFLOORNUMBER` TEXT COLLATE latin1_swedish_ci,
  `COOLINGSYSTEM` TEXT COLLATE latin1_swedish_ci,
  `DECK` TEXT COLLATE latin1_swedish_ci,
  `DISABLEDACCESS` TEXT COLLATE latin1_swedish_ci,
  `DOCK` TEXT COLLATE latin1_swedish_ci,
  `DOORMAN` TEXT COLLATE latin1_swedish_ci,
  `DOUBLEPANELWINDOWS` TEXT COLLATE latin1_swedish_ci,
  `ELEVATOR` TEXT COLLATE latin1_swedish_ci,
  `EXTERIORTYPE` TEXT COLLATE latin1_swedish_ci,
  `FENCING` TEXT COLLATE latin1_swedish_ci,
  `FIREPLACE` TEXT COLLATE latin1_swedish_ci,
  `FLOORCOVERING` TEXT COLLATE latin1_swedish_ci,
  `GARDEN` TEXT COLLATE latin1_swedish_ci,
  `GATEDENTRY` TEXT COLLATE latin1_swedish_ci,
  `GREENHOUSE` TEXT COLLATE latin1_swedish_ci,
  `HEATINGFUEL` TEXT COLLATE latin1_swedish_ci,
  `HEATINGSYSTEM` TEXT COLLATE latin1_swedish_ci,
  `HORSEPROPERTY` TEXT COLLATE latin1_swedish_ci,
  `HOTTUBSPA` TEXT COLLATE latin1_swedish_ci,
  `INTERCOM` TEXT COLLATE latin1_swedish_ci,
  `INTERIOR` TEXT COLLATE latin1_swedish_ci,
  `JETTEDBATHTUB` TEXT COLLATE latin1_swedish_ci,
  `LAWN` TEXT COLLATE latin1_swedish_ci,
  `LAUNDARY` TEXT COLLATE latin1_swedish_ci,
  `LEGALDESCRIPTION` TEXT COLLATE latin1_swedish_ci,
  `MOTHERINLAW` TEXT COLLATE latin1_swedish_ci,
  `NEWCONTRUCTION` TEXT COLLATE latin1_swedish_ci,
  `NUMFLOORS` TEXT COLLATE latin1_swedish_ci,
  `NUMPARKINGSPACES` TEXT COLLATE latin1_swedish_ci,
  `PARKINGTYPE` TEXT COLLATE latin1_swedish_ci,
  `PATIO` TEXT COLLATE latin1_swedish_ci,
  `POND` TEXT COLLATE latin1_swedish_ci,
  `POOL` TEXT COLLATE latin1_swedish_ci,
  `PORCH` TEXT COLLATE latin1_swedish_ci,
  `ROOFTYPE` TEXT COLLATE latin1_swedish_ci,
  `ROOMCOUNT` TEXT COLLATE latin1_swedish_ci,
  `ROOMS` TEXT COLLATE latin1_swedish_ci,
  `RVPARKING` TEXT COLLATE latin1_swedish_ci,
  `SAUNA` TEXT COLLATE latin1_swedish_ci,
  `SECURITYSYSTEM` TEXT COLLATE latin1_swedish_ci,
  `SKYLIGHT` TEXT COLLATE latin1_swedish_ci,
  `SPORTSCOURT` TEXT COLLATE latin1_swedish_ci,
  `SPRINKLERSYSTEM` TEXT COLLATE latin1_swedish_ci,
  `VAULTEDCELLING` TEXT COLLATE latin1_swedish_ci,
  `VIEWTYPE` TEXT COLLATE latin1_swedish_ci,
  `WATER` TEXT COLLATE latin1_swedish_ci,
  `WATERFRONT` TEXT COLLATE latin1_swedish_ci,
  `WETBAR` TEXT COLLATE latin1_swedish_ci,
  `WIRED` TEXT COLLATE latin1_swedish_ci,
  `YEARREMODELED` TEXT COLLATE latin1_swedish_ci,
  `ZONING` TEXT COLLATE latin1_swedish_ci,
  `TAXYEAR` TEXT COLLATE latin1_swedish_ci,
  `TAXAMOUNT` TEXT COLLATE latin1_swedish_ci,
  `ADDL_FEATURES` TEXT COLLATE latin1_swedish_ci,
  PRIMARY KEY USING BTREE (`ID`) COMMENT '',
   INDEX `idx_teraid` USING BTREE (`TERABITZ_ID`) COMMENT ''
)ENGINE=MyISAM
AUTO_INCREMENT=904000 AVG_ROW_LENGTH=3369 CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci'
COMMENT=''
;

#
# Structure for the `links_ptnf` table :
#

CREATE TABLE `links_ptnf` (
  `ID` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `TERABITZ_ID` BIGINT(20) UNSIGNED NOT NULL,
  `TYPE` VARCHAR(30) COLLATE latin1_swedish_ci DEFAULT NULL,
  `CAPTION` VARCHAR(150) COLLATE latin1_swedish_ci DEFAULT NULL,
  `URL` TEXT COLLATE latin1_swedish_ci,
  `PHOTOORDER` INTEGER(4) DEFAULT NULL,
  PRIMARY KEY USING BTREE (`ID`) COMMENT '',
   INDEX `idx_teraid` USING BTREE (`TERABITZ_ID`) COMMENT ''
)ENGINE=MyISAM
AUTO_INCREMENT=16827243 AVG_ROW_LENGTH=100 CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci'
COMMENT=''
;

#
# Structure for the `openhouse_ptnf` table :
#

CREATE TABLE `openhouse_ptnf` (
  `ID` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `TERABITZ_ID` BIGINT(20) UNSIGNED NOT NULL,
  `OPEN_DATE` DATE DEFAULT NULL,
  `OPEN_ST_TIME` TIME DEFAULT NULL,
  `OPEN_END_TIME` TIME DEFAULT NULL,
  `COMMENTS` TEXT COLLATE latin1_swedish_ci,
  PRIMARY KEY USING BTREE (`ID`) COMMENT '',
   INDEX `idx_teraid` USING BTREE (`TERABITZ_ID`) COMMENT '',
   INDEX `idx_opendate` USING BTREE (`OPEN_DATE`) COMMENT ''
)ENGINE=MyISAM
AUTO_INCREMENT=1 CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci'
COMMENT=''
;

#
# Structure for the `property_ptnf` table :
#

CREATE TABLE `property_ptnf` (
  `TERABITZ_ID` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `ID` VARCHAR(30) COLLATE latin1_swedish_ci DEFAULT NULL,
  `DATASOURCE` VARCHAR(50) COLLATE latin1_swedish_ci NOT NULL,
  `UNIT_NUMBER` VARCHAR(10) COLLATE latin1_swedish_ci DEFAULT NULL,
  `ADDRESS` VARCHAR(60) COLLATE latin1_swedish_ci DEFAULT NULL,
  `CITY` VARCHAR(40) COLLATE latin1_swedish_ci DEFAULT NULL,
  `STATE` VARCHAR(2) COLLATE latin1_swedish_ci DEFAULT NULL,
  `ZIP` VARCHAR(10) COLLATE latin1_swedish_ci DEFAULT NULL,
  `COUNTY` VARCHAR(30) COLLATE latin1_swedish_ci DEFAULT NULL,
  `latitude` DOUBLE NOT NULL DEFAULT 0,
  `longitude` DOUBLE NOT NULL DEFAULT 0,
  `TYPE` VARCHAR(100) COLLATE latin1_swedish_ci DEFAULT NULL,
  `SUBTYPE` VARCHAR(150) COLLATE latin1_swedish_ci DEFAULT NULL,
  `TITLE` VARCHAR(100) COLLATE latin1_swedish_ci DEFAULT NULL,
  `DESCRIPTION` TEXT COLLATE latin1_swedish_ci,
  `PARCEL_NUMBER` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `BEDS` FLOAT DEFAULT NULL,
  `BATHS` FLOAT DEFAULT NULL,
  `FULLBATHS` FLOAT DEFAULT NULL,
  `HALFBATHS` FLOAT DEFAULT NULL,
  `AREASQFT` VARCHAR(45) COLLATE latin1_swedish_ci DEFAULT NULL,
  `LOTSQFT` VARCHAR(45) COLLATE latin1_swedish_ci DEFAULT NULL,
  `YEAR_BUILT` VARCHAR(4) COLLATE latin1_swedish_ci DEFAULT NULL,
  `DISPLAY_ADDRESS` TINYINT(4) DEFAULT NULL,
  `DISPLAY_LISTING` TINYINT(4) DEFAULT NULL,
  `MLS_NUMBER` VARCHAR(45) COLLATE latin1_swedish_ci DEFAULT NULL,
  `STATUS` VARCHAR(30) COLLATE latin1_swedish_ci DEFAULT NULL,
  `SALEDATE` DATE DEFAULT NULL,
  `SALEPRICE` DOUBLE DEFAULT NULL,
  `LISTDATE` DATE DEFAULT NULL,
  `ORIG_LISTPRICE` DOUBLE DEFAULT NULL,
  `CURR_LISTPRICE` DOUBLE DEFAULT NULL,
  `DAYS_ON_MARKET` INTEGER(10) UNSIGNED DEFAULT NULL,
  `DATE_PRICE_ADJUST` DATE DEFAULT NULL,
  `LISTING_URL` TEXT COLLATE latin1_swedish_ci,
  `VTOUR_URL` TEXT COLLATE latin1_swedish_ci,
  `MODIF_TIMESTAMP` DATETIME DEFAULT NULL,
  `EXPIRY_DATE` DATE DEFAULT NULL,
  `MISC` TEXT COLLATE latin1_swedish_ci,
  `PHOTO_COUNT` INTEGER(10) UNSIGNED DEFAULT NULL,
  `VIDEO_COUNT` INTEGER(10) UNSIGNED DEFAULT NULL,
  `PHOTO_MODIF_DATE` DATETIME DEFAULT NULL,
  `VIDEO_MODIF_DATE` DATETIME DEFAULT NULL,
  `DIST_SCHOOL` VARCHAR(60) COLLATE latin1_swedish_ci DEFAULT NULL,
  `ELEM_SCHOOL` VARCHAR(60) COLLATE latin1_swedish_ci DEFAULT NULL,
  `MIDL_SCHOOL` VARCHAR(60) COLLATE latin1_swedish_ci DEFAULT NULL,
  `HIGH_SCHOOL` VARCHAR(60) COLLATE latin1_swedish_ci DEFAULT NULL,
  `NABRHD_NAME` VARCHAR(150) COLLATE latin1_swedish_ci DEFAULT NULL,
  `NABRHD_DESC` TEXT COLLATE latin1_swedish_ci,
  `NEARBY_URL` TEXT COLLATE latin1_swedish_ci,
  `IDENTIFIER` VARCHAR(255) COLLATE latin1_swedish_ci DEFAULT NULL,
  `GEOLEVEL` INTEGER(4) DEFAULT NULL,
  `MAIN_PHOTO` TEXT COLLATE latin1_swedish_ci,
  `PRICE_CHANGE` DOUBLE DEFAULT NULL,
  `STATUS_CHANGE` VARCHAR(30) COLLATE latin1_swedish_ci DEFAULT NULL,
  `BROKER_CODE` VARCHAR(45) COLLATE latin1_swedish_ci DEFAULT NULL,
  `BROKER_NAME` VARCHAR(150) COLLATE latin1_swedish_ci DEFAULT NULL,
  `OFFICE_LISTING_YN` TINYINT(4) DEFAULT NULL,
  `EXTRA1` VARCHAR(2) COLLATE latin1_swedish_ci DEFAULT NULL,
  `EXTRA2` VARCHAR(2) COLLATE latin1_swedish_ci DEFAULT NULL,
  `EXTRA3` VARCHAR(2) COLLATE latin1_swedish_ci DEFAULT NULL,
  `EXTRA4` VARCHAR(2) COLLATE latin1_swedish_ci DEFAULT NULL,
  `EXTRA5` VARCHAR(2) COLLATE latin1_swedish_ci DEFAULT NULL,
  `POSTINGUSER_ID` BIGINT(20) UNSIGNED DEFAULT NULL,
  PRIMARY KEY USING BTREE (`TERABITZ_ID`) COMMENT '',
  UNIQUE INDEX `property_ptnf_idx2` USING BTREE (`STATUS`, `DATASOURCE`, `TERABITZ_ID`, `DISPLAY_LISTING`) COMMENT '',
   INDEX `idx_zip` USING BTREE (`ZIP`(5)) COMMENT '',
   INDEX `idx_city` USING BTREE (`CITY`(10)) COMMENT '',
   INDEX `idx_propertyid` USING BTREE (`ID`) COMMENT '',
   INDEX `idx_mls` USING BTREE (`MLS_NUMBER`) COMMENT '',
   INDEX `idx_lat` USING BTREE (`latitude`) COMMENT '',
   INDEX `idx_long` USING BTREE (`longitude`) COMMENT '',
   INDEX `idx_curr_listprice` USING BTREE (`CURR_LISTPRICE`) COMMENT '',
   INDEX `idx_listdate` USING BTREE (`LISTDATE`) COMMENT '',
   INDEX `idx_NABRHD_NAME` USING BTREE (`NABRHD_NAME`) COMMENT '',
   INDEX `property_ptnf_idx1` USING BTREE (`STATUS`, `SALEDATE`) COMMENT '',
   INDEX `property_ptnf_idx3` USING BTREE (`DATASOURCE`) COMMENT ''
)ENGINE=MyISAM
AUTO_INCREMENT=1035124602 AVG_ROW_LENGTH=1167 CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci'
COMMENT=''
;

#
# Structure for the `users_ptnf` table :
#

CREATE TABLE `users_ptnf` (
  `ID` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `TERABITZ_ID` BIGINT(20) UNSIGNED NOT NULL,
  `USER_SOURCEID` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `TYPE` VARCHAR(50) COLLATE latin1_swedish_ci NOT NULL,
  `FNAME` VARCHAR(25) COLLATE latin1_swedish_ci DEFAULT NULL,
  `LNAME` VARCHAR(25) COLLATE latin1_swedish_ci DEFAULT NULL,
  `EMAIL` VARCHAR(90) COLLATE latin1_swedish_ci DEFAULT NULL,
  `WEBSITE_URL` TEXT COLLATE latin1_swedish_ci,
  `IMAGE_URL` TEXT COLLATE latin1_swedish_ci,
  `LICENCE_NO` VARCHAR(45) COLLATE latin1_swedish_ci DEFAULT NULL,
  `OFFICE_NAME` VARCHAR(150) COLLATE latin1_swedish_ci DEFAULT NULL,
  `PHONE` VARCHAR(45) COLLATE latin1_swedish_ci DEFAULT NULL,
  `MOBILE` VARCHAR(45) COLLATE latin1_swedish_ci DEFAULT NULL,
  `FAX` VARCHAR(45) COLLATE latin1_swedish_ci DEFAULT NULL,
  `UNIT_NO` VARCHAR(45) COLLATE latin1_swedish_ci DEFAULT NULL,
  `ADDRESS` VARCHAR(60) COLLATE latin1_swedish_ci DEFAULT NULL,
  `CITY` VARCHAR(40) COLLATE latin1_swedish_ci DEFAULT NULL,
  `STATE` VARCHAR(2) COLLATE latin1_swedish_ci DEFAULT NULL,
  `ZIP` VARCHAR(10) COLLATE latin1_swedish_ci DEFAULT NULL,
  `COUNTY` VARCHAR(30) COLLATE latin1_swedish_ci DEFAULT NULL,
  `LATITUDE` DOUBLE DEFAULT NULL,
  `LONGITUDE` DOUBLE DEFAULT NULL,
  `MISC` TEXT COLLATE latin1_swedish_ci,
  PRIMARY KEY USING BTREE (`ID`) COMMENT '',
  UNIQUE INDEX `users_ptnf_idx1` USING BTREE (`TERABITZ_ID`, `TYPE`) COMMENT '',
   INDEX `idx_teraid` USING BTREE (`TERABITZ_ID`) COMMENT '',
   INDEX `user_sourceid` USING BTREE (`USER_SOURCEID`) COMMENT ''
)ENGINE=MyISAM
AUTO_INCREMENT=2405069 AVG_ROW_LENGTH=408 CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci'
COMMENT=''
;

#
# Definition for the `Sync_Properties_Images` procedure :
#

DELIMITER $$

CREATE DEFINER = 'mls_admin'@'%' PROCEDURE `Sync_Properties_Images`()
    DETERMINISTIC
    MODIFIES SQL DATA
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
UPDATE
  `property_ptnf`
SET
  `MAIN_PHOTO` = (SELECT `links_ptnf`.`URL` FROM `links_ptnf`
    WHERE
      `links_ptnf`.`PHOTOORDER` = 1 AND
      `links_ptnf`.`TYPE` = 'Photo' AND
      `links_ptnf`.`TERABITZ_ID` = `property_ptnf`.`TERABITZ_ID`),
  `PHOTO_MODIF_DATE` = NOW(),
  `PHOTO_COUNT` = (SELECT COUNT(`links`.`ID`) AS `FIELD_1` FROM `links_ptnf` `links` WHERE `links`.`TERABITZ_ID` = `property_ptnf`.`TERABITZ_ID` AND `links`.`TYPE` = 'Photo');
  select 1 as done;
END$$

DELIMITER ;

#
# Definition for the `view_homesmart_solr` view :
#

CREATE ALGORITHM=UNDEFINED DEFINER=`mls_admin`@`%` SQL SECURITY DEFINER VIEW `view_homesmart_solr` AS (select `pp`.`TERABITZ_ID` AS `TERABITZ_ID`,`pp`.`ID` AS `ID`,database() AS `Database`,0 AS `MLS_TERABITZID`,`pp`.`DISPLAY_LISTING` AS `DISPLAY_LISTING`,`pp`.`DISPLAY_ADDRESS` AS `DISPLAY_ADDRESS`,`pp`.`STATUS` AS `STATUS`,`pp`.`DESCRIPTION` AS `DESCRIPTION`,`pp`.`DATASOURCE` AS `DATASOURCE`,`pp`.`ADDRESS` AS `ADDRESS`,`pp`.`CITY` AS `CITY`,`pp`.`STATE` AS `STATE`,`pp`.`ZIP` AS `ZIP`,`pp`.`COUNTY` AS `COUNTY`,`pp`.`CURR_LISTPRICE` AS `CURR_LISTPRICE`,`pp`.`LISTDATE` AS `LISTDATE`,(case when ((`pp`.`YEAR_BUILT` in ('','0')) or isnull(`pp`.`YEAR_BUILT`)) then 0 else cast(`pp`.`YEAR_BUILT` as signed) end) AS `YEAR_BUILT`,`pp`.`BEDS` AS `BEDS`,`pp`.`BATHS` AS `BATHS`,`pp`.`latitude` AS `LATITUDE`,`pp`.`longitude` AS `LONGITUDE`,date_format(`pp`.`MODIF_TIMESTAMP`,'%Y-%m-%dT%TZ') AS `MODIF_TIMESTAMP`,`pp`.`DAYS_ON_MARKET` AS `DAYS_ON_MARKET`,concat_ws(',',cast(`pp`.`latitude` as char charset latin1),cast(`pp`.`longitude` as char charset latin1)) AS `LATLNG`,`pp`.`MLS_NUMBER` AS `MLS_NUMBER`,cast(`pp`.`AREASQFT` as signed) AS `AREASQFT`,`pp`.`TYPE` AS `TYPE`,`pp`.`PHOTO_COUNT` AS `PHOTO_COUNT`,(case when (isnull(`fp`.`POOL`) or (`fp`.`POOL` in ('No','','No Pool','None','0'))) then 'no' else 'yes' end) AS `POOL`,(case when (isnull(`fp`.`FIREPLACE`) or (`fp`.`FIREPLACE` in ('No','','No','None','0'))) then 'no' else 'yes' end) AS `FIREPLACE`,`fp`.`ARCHITECTURESTYLE` AS `ARCHITECTURESTYLE`,round(substr(substr(`fp`.`ADDL_FEATURES`,locate('FINISHED SQFT:',`fp`.`ADDL_FEATURES`),(locate('|',`fp`.`ADDL_FEATURES`,locate('FINISHED SQFT:',`fp`.`ADDL_FEATURES`)) - locate('FINISHED SQFT:',`fp`.`ADDL_FEATURES`))),(locate(':',substr(`fp`.`ADDL_FEATURES`,locate('FINISHED SQFT:',`fp`.`ADDL_FEATURES`),(locate('|',`fp`.`ADDL_FEATURES`,locate('FINISHED SQFT:',`fp`.`ADDL_FEATURES`)) - locate('FINISHED SQFT:',`fp`.`ADDL_FEATURES`)))) + 1)),0) AS `FINISHEDSQFT`,`fp`.`PARKINGTYPE` AS `PARKINGTYPE`,substr(substr(`fp`.`ADDL_FEATURES`,locate('PARKING TYPE:',`fp`.`ADDL_FEATURES`),(locate('|',`fp`.`ADDL_FEATURES`,locate('PARKING TYPE:',`fp`.`ADDL_FEATURES`)) - locate('PARKING TYPE:',`fp`.`ADDL_FEATURES`))),(locate(':',substr(`fp`.`ADDL_FEATURES`,locate('PARKING TYPE:',`fp`.`ADDL_FEATURES`),(locate('|',`fp`.`ADDL_FEATURES`,locate('PARKING TYPE:',`fp`.`ADDL_FEATURES`)) - locate('PARKING TYPE:',`fp`.`ADDL_FEATURES`)))) + 1)) AS `ADDL_PARKING`,`fp`.`SPORTSCOURT` AS `SPORTSCOURT`,cast((case when (isnull(`fp`.`SPORTSCOURT`) or (`fp`.`SPORTSCOURT` = '') or (`fp`.`SPORTSCOURT` = '0')) then 'No' else 'Yes' end) as char(3) charset latin1) AS `SPORTSCOURTFLAG`,`pp`.`VTOUR_URL` AS `VTOUR_URL`,'' AS `PKTLIST`,0 AS `POSTINGUSER_ID`,(select group_concat(`l`.`URL` order by `l`.`PHOTOORDER` ASC,`l`.`CAPTION` DESC,length(`l`.`URL`) ASC,`l`.`URL` ASC separator ',') from `links_ptnf` `l` where ((`l`.`TYPE` = 'photo') and (`l`.`TERABITZ_ID` = `pp`.`TERABITZ_ID`))) AS `PHOTOS`,(select `l`.`URL` from `links_ptnf` `l` where ((`l`.`TYPE` = 'photo') and (`l`.`TERABITZ_ID` = `pp`.`TERABITZ_ID`)) order by `l`.`PHOTOORDER`,`l`.`CAPTION` desc,length(`l`.`URL`),`l`.`URL` limit 1) AS `MAINPHOTO`,(select `b`.`CODE` from `broker_ptnf` `b` where ((`b`.`TERABITZ_ID` = `pp`.`TERABITZ_ID`) and (`b`.`TYPE` = 'Listing Broker'))) AS `LBid`,(select `b`.`NAME` from `broker_ptnf` `b` where ((`b`.`TERABITZ_ID` = `pp`.`TERABITZ_ID`) and (`b`.`TYPE` = 'Listing Broker'))) AS `LBname`,(select `b`.`CODE` from `broker_ptnf` `b` where ((`b`.`TERABITZ_ID` = `pp`.`TERABITZ_ID`) and (`b`.`TYPE` = 'CoListing Broker'))) AS `CoLBid`,(select `b`.`NAME` from `broker_ptnf` `b` where ((`b`.`TERABITZ_ID` = `pp`.`TERABITZ_ID`) and (`b`.`TYPE` = 'CoListing Broker'))) AS `CoLBname`,(select `u`.`USER_SOURCEID` from `users_ptnf` `u` where ((`u`.`TERABITZ_ID` = `pp`.`TERABITZ_ID`) and (`u`.`TYPE` = 'Listing Agent'))) AS `LAid`,(select concat(`u`.`FNAME`,' ',`u`.`LNAME`) from `users_ptnf` `u` where ((`u`.`TERABITZ_ID` = `pp`.`TERABITZ_ID`) and (`u`.`TYPE` = 'Listing Agent'))) AS `LAname`,(select `u`.`USER_SOURCEID` from `users_ptnf` `u` where ((`u`.`TERABITZ_ID` = `pp`.`TERABITZ_ID`) and (`u`.`TYPE` = 'CoListing Agent'))) AS `CoLAid`,(select concat(`u`.`FNAME`,' ',`u`.`LNAME`) from `users_ptnf` `u` where ((`u`.`TERABITZ_ID` = `pp`.`TERABITZ_ID`) and (`u`.`TYPE` = 'CoListing Agent'))) AS `CoLAname`,(select `op`.`OPEN_DATE` from `openhouse_ptnf` `op` where ((`op`.`TERABITZ_ID` = `pp`.`TERABITZ_ID`) and (`op`.`OPEN_DATE` >= curdate())) order by `op`.`OPEN_DATE` limit 1) AS `OPENDATE`,(select `op`.`OPEN_DATE` from `tb_pocket_listing`.`openhouse_ptnf` `op` where ((`op`.`TERABITZ_ID` = `pp`.`TERABITZ_ID`) and (`op`.`OPEN_DATE` >= curdate()) and (`op`.`SOURCE` = 'HOMESMART')) order by `op`.`OPEN_DATE` limit 1) AS `PKTOPENDATE`,cast((select concat(`op`.`OPEN_DATE`,',',`op`.`OPEN_ST_TIME`,',',`op`.`OPEN_END_TIME`) from `openhouse_ptnf` `op` where ((`op`.`TERABITZ_ID` = `pp`.`TERABITZ_ID`) and (`op`.`OPEN_DATE` >= curdate())) order by `op`.`OPEN_DATE` limit 1) as char(32) charset latin1) AS `MLSOPENHOMES`,cast((select concat(`op`.`OPEN_DATE`,',',`op`.`OPEN_ST_TIME`,',',`op`.`OPEN_END_TIME`) from `tb_pocket_listing`.`openhouse_ptnf` `op` where ((`op`.`TERABITZ_ID` = `pp`.`TERABITZ_ID`) and (`op`.`SOURCE` = 'HOMESMART') and (`op`.`OPEN_DATE` >= curdate())) order by `op`.`OPEN_DATE` limit 1) as char(32) charset latin1) AS `PKTOPENHOMES`,(select `tb_pocket_listing`.`openhouse_directions`.`DIRECTIONS` from `tb_pocket_listing`.`openhouse_directions` where ((`tb_pocket_listing`.`openhouse_directions`.`TERABITZ_ID` = `pp`.`TERABITZ_ID`) and (`tb_pocket_listing`.`openhouse_directions`.`SOURCE` = 'HOMESMART')) limit 1) AS `OPENDIR`,cast(`fp`.`NUMFLOORS` as signed) AS `NUMFLOORS`,cast(`fp`.`NUMPARKINGSPACES` as signed) AS `NUMPARKINGSPACES`,'' AS `SOURCE`,(case when (isnull(`pp`.`YEAR_BUILT`) or (`pp`.`YEAR_BUILT` = '') or (`pp`.`YEAR_BUILT` = '0')) then 0 else (year(now()) - cast(`pp`.`YEAR_BUILT` as signed)) end) AS `PROPERTYAGE`,(case when ((`pp`.`LOTSQFT` = '') or isnull(`pp`.`LOTSQFT`)) then 0 else cast(`pp`.`LOTSQFT` as signed) end) AS `LOTSQFT`,substr(substr(`fp`.`ADDL_FEATURES`,locate('PROPERTY SUBTYPE:',`fp`.`ADDL_FEATURES`),(locate('|',`fp`.`ADDL_FEATURES`,locate('PROPERTY SUBTYPE:',`fp`.`ADDL_FEATURES`)) - locate('PROPERTY SUBTYPE:',`fp`.`ADDL_FEATURES`))),(locate(':',substr(`fp`.`ADDL_FEATURES`,locate('PROPERTY SUBTYPE:',`fp`.`ADDL_FEATURES`),(locate('|',`fp`.`ADDL_FEATURES`,locate('PROPERTY SUBTYPE:',`fp`.`ADDL_FEATURES`)) - locate('PROPERTY SUBTYPE:',`fp`.`ADDL_FEATURES`)))) + 1)) AS `PROPERTYSUBTYPE`,`pp`.`NABRHD_NAME` AS `NABRHD_NAME`,`pp`.`NABRHD_DESC` AS `NABRHD_DESC`,(case when (isnull(`pp`.`EXTRA1`) or (`pp`.`EXTRA1` in ('No','','No','None','0'))) then 'no' else 'yes' end) AS `PETSALLOWED` from ((`property_ptnf` `pp` join `broker_ptnf` `bk` on((`pp`.`TERABITZ_ID` = `bk`.`TERABITZ_ID`))) join `features_ptnf` `fp` on((`bk`.`TERABITZ_ID` = `fp`.`TERABITZ_ID`))) where ((`pp`.`TERABITZ_ID` = `fp`.`TERABITZ_ID`) and (`pp`.`TERABITZ_ID` = `bk`.`TERABITZ_ID`) and (`bk`.`TYPE` = 'Listing Broker') and (`pp`.`DISPLAY_LISTING` > 0) and (`pp`.`STATUS` in ('Active','Backup','Active Contingent','Pending','New Home')) and (not((`pp`.`TERABITZ_ID`,`pp`.`DATASOURCE`) in (select `enhp`.`MLS_TERABITZID`,`enhp`.`DATASOURCE` from `tb_enhanced_listing`.`property_ptnf` `enhp` where (`enhp`.`SOURCE` = 'HOMESMART')))))) union (select `pp`.`TERABITZ_ID` AS `TERABITZ_ID`,0 AS `ID`,database() AS `Database`,0 AS `MLS_TERABITZID`,`pp`.`DISPLAY_LISTING` AS `DISPLAY_LISTING`,`pp`.`DISPLAY_ADDRESS` AS `DISPLAY_ADDRESS`,`pp`.`STATUS` AS `STATUS`,`pp`.`DESCRIPTION` AS `DESCRIPTION`,`pp`.`DATASOURCE` AS `DATASOURCE`,`pp`.`ADDRESS` AS `ADDRESS`,`pp`.`CITY` AS `CITY`,`pp`.`STATE` AS `STATE`,`pp`.`ZIP` AS `ZIP`,`pp`.`COUNTY` AS `COUNTY`,`pp`.`CURR_LISTPRICE` AS `CURR_LISTPRICE`,`pp`.`LISTDATE` AS `LISTDATE`,(case when ((`pp`.`YEAR_BUILT` in ('','0')) or isnull(`pp`.`YEAR_BUILT`)) then 0 else cast(`pp`.`YEAR_BUILT` as signed) end) AS `YEAR_BUILT`,`pp`.`BEDS` AS `BEDS`,`pp`.`BATHS` AS `BATHS`,`pp`.`LATITUDE` AS `LATITUDE`,`pp`.`LONGITUDE` AS `LONGITUDE`,date_format(`pp`.`MODIF_TIMESTAMP`,'%Y-%m-%dT%TZ') AS `MODIF_TIMESTAMP`,`pp`.`DAYS_ON_MARKET` AS `DAYS_ON_MARKET`,concat_ws(',',cast(`pp`.`LATITUDE` as char charset latin1),cast(`pp`.`LONGITUDE` as char charset latin1)) AS `LATLNG`,`pp`.`MLS_NUMBER` AS `MLS_NUMBER`,cast(`pp`.`AREASQFT` as signed) AS `AREASQFT`,`pp`.`TYPE` AS `TYPE`,`pp`.`PHOTO_COUNT` AS `PHOTO_COUNT`,(case when (isnull(`fp`.`POOL`) or (`fp`.`POOL` in ('No','','No Pool','None','0'))) then 'no' else 'yes' end) AS `POOL`,(case when (isnull(`fp`.`FIREPLACE`) or (`fp`.`FIREPLACE` in ('No','','No','None','0'))) then 'no' else 'yes' end) AS `FIREPLACE`,`fp`.`ARCHITECTURESTYLE` AS `ARCHITECTURESTYLE`,round(substr(substr(`fp`.`ADDL_FEATURES`,locate('FINISHED SQFT:',`fp`.`ADDL_FEATURES`),(locate('|',`fp`.`ADDL_FEATURES`,locate('FINISHED SQFT:',`fp`.`ADDL_FEATURES`)) - locate('FINISHED SQFT:',`fp`.`ADDL_FEATURES`))),(locate(':',substr(`fp`.`ADDL_FEATURES`,locate('FINISHED SQFT:',`fp`.`ADDL_FEATURES`),(locate('|',`fp`.`ADDL_FEATURES`,locate('FINISHED SQFT:',`fp`.`ADDL_FEATURES`)) - locate('FINISHED SQFT:',`fp`.`ADDL_FEATURES`)))) + 1)),0) AS `FINISHEDSQFT`,`fp`.`PARKINGTYPE` AS `PARKINGTYPE`,substr(substr(`fp`.`ADDL_FEATURES`,locate('PARKING TYPE:',`fp`.`ADDL_FEATURES`),(locate('|',`fp`.`ADDL_FEATURES`,locate('PARKING TYPE:',`fp`.`ADDL_FEATURES`)) - locate('PARKING TYPE:',`fp`.`ADDL_FEATURES`))),(locate(':',substr(`fp`.`ADDL_FEATURES`,locate('PARKING TYPE:',`fp`.`ADDL_FEATURES`),(locate('|',`fp`.`ADDL_FEATURES`,locate('PARKING TYPE:',`fp`.`ADDL_FEATURES`)) - locate('PARKING TYPE:',`fp`.`ADDL_FEATURES`)))) + 1)) AS `ADDL_PARKING`,`fp`.`SPORTSCOURT` AS `SPORTSCOURT`,cast((case when (isnull(`fp`.`SPORTSCOURT`) or (`fp`.`SPORTSCOURT` = '') or (`fp`.`SPORTSCOURT` = '0')) then 'No' else 'Yes' end) as char(3) charset latin1) AS `SPORTSCOURTFLAG`,`pp`.`VTOUR_URL` AS `VTOUR_URL`,'PKT' AS `PKTLIST`,`pp`.`POSTINGUSER_ID` AS `POSTINGUSER_ID`,(select group_concat(`l`.`URL` order by `l`.`PHOTOORDER` ASC,`l`.`CAPTION` DESC,length(`l`.`URL`) ASC,`l`.`URL` ASC separator ',') from `tb_pocket_listing`.`links_ptnf` `l` where ((`l`.`TYPE` = 'photo') and (`l`.`TERABITZ_ID` = `pp`.`TERABITZ_ID`))) AS `PHOTOS`,(select `l`.`URL` from `tb_pocket_listing`.`links_ptnf` `l` where ((`l`.`TYPE` = 'photo') and (`l`.`TERABITZ_ID` = `pp`.`TERABITZ_ID`)) order by `l`.`PHOTOORDER`,`l`.`CAPTION` desc,length(`l`.`URL`),`l`.`URL` limit 1) AS `MAINPHOTO`,(select `b`.`CODE` from `tb_pocket_listing`.`broker_ptnf` `b` where ((`b`.`TERABITZ_ID` = `pp`.`TERABITZ_ID`) and (`b`.`TYPE` = 'Listing Broker'))) AS `LBid`,(select `b`.`NAME` from `tb_pocket_listing`.`broker_ptnf` `b` where ((`b`.`TERABITZ_ID` = `pp`.`TERABITZ_ID`) and (`b`.`TYPE` = 'Listing Broker'))) AS `LBname`,(select `b`.`CODE` from `tb_pocket_listing`.`broker_ptnf` `b` where ((`b`.`TERABITZ_ID` = `pp`.`TERABITZ_ID`) and (`b`.`TYPE` = 'CoListing Broker'))) AS `CoLBid`,(select `b`.`NAME` from `tb_pocket_listing`.`broker_ptnf` `b` where ((`b`.`TERABITZ_ID` = `pp`.`TERABITZ_ID`) and (`b`.`TYPE` = 'CoListing Broker'))) AS `CoLBname`,(select `u`.`USER_SOURCEID` from `tb_pocket_listing`.`users_ptnf` `u` where ((`u`.`TERABITZ_ID` = `pp`.`TERABITZ_ID`) and (`u`.`TYPE` = 'Listing Agent'))) AS `LAid`,(select concat(`u`.`FNAME`,' ',`u`.`LNAME`) from `tb_pocket_listing`.`users_ptnf` `u` where ((`u`.`TERABITZ_ID` = `pp`.`TERABITZ_ID`) and (`u`.`TYPE` = 'Listing Agent'))) AS `LAname`,(select `u`.`USER_SOURCEID` from `tb_pocket_listing`.`users_ptnf` `u` where ((`u`.`TERABITZ_ID` = `pp`.`TERABITZ_ID`) and (`u`.`TYPE` = 'CoListing Agent'))) AS `CoLAid`,(select concat(`u`.`FNAME`,' ',`u`.`LNAME`) from `tb_pocket_listing`.`users_ptnf` `u` where ((`u`.`TERABITZ_ID` = `pp`.`TERABITZ_ID`) and (`u`.`TYPE` = 'CoListing Agent'))) AS `CoLAname`,(select `op`.`OPEN_DATE` from `tb_pocket_listing`.`openhouse_ptnf` `op` where ((`op`.`TERABITZ_ID` = `pp`.`TERABITZ_ID`) and (`op`.`OPEN_DATE` >= curdate())) order by `op`.`OPEN_DATE` limit 1) AS `OPENDATE`,(select `op`.`OPEN_DATE` from `tb_pocket_listing`.`openhouse_ptnf` `op` where ((`op`.`TERABITZ_ID` = `pp`.`TERABITZ_ID`) and (`op`.`OPEN_DATE` >= curdate()) and (`op`.`SOURCE` = 'HOMESMART')) order by `op`.`OPEN_DATE` limit 1) AS `PKTOPENDATE`,cast('' as char(32) charset latin1) AS `MLSOPENHOMES`,cast((select concat(`op`.`OPEN_DATE`,',',`op`.`OPEN_ST_TIME`,',',`op`.`OPEN_END_TIME`) from `tb_pocket_listing`.`openhouse_ptnf` `op` where ((`op`.`TERABITZ_ID` = `pp`.`TERABITZ_ID`) and (`op`.`SOURCE` = 'POCKETLISTING') and (`op`.`OPEN_DATE` >= curdate())) order by `op`.`OPEN_DATE` limit 1) as char(32) charset latin1) AS `PKTOPENHOMES`,(select `tb_pocket_listing`.`openhouse_directions`.`DIRECTIONS` from `tb_pocket_listing`.`openhouse_directions` where ((`tb_pocket_listing`.`openhouse_directions`.`TERABITZ_ID` = `pp`.`TERABITZ_ID`) and (`tb_pocket_listing`.`openhouse_directions`.`SOURCE` = 'POCKETLISTING')) limit 1) AS `OPENDIR`,cast(`fp`.`NUMFLOORS` as signed) AS `NUMFLOORS`,cast(`fp`.`NUMPARKINGSPACES` as signed) AS `NUMPARKINGSPACES`,'' AS `SOURCE`,(case when (isnull(`pp`.`YEAR_BUILT`) or (`pp`.`YEAR_BUILT` = '') or (`pp`.`YEAR_BUILT` = '0')) then 0 else (year(now()) - cast(`pp`.`YEAR_BUILT` as signed)) end) AS `PROPERTYAGE`,(case when ((`pp`.`LOTSQFT` = '') or isnull(`pp`.`LOTSQFT`)) then 0 else cast(`pp`.`LOTSQFT` as signed) end) AS `LOTSQFT`,substr(substr(`fp`.`ADDL_FEATURES`,locate('PROPERTY SUBTYPE:',`fp`.`ADDL_FEATURES`),(locate('|',`fp`.`ADDL_FEATURES`,locate('PROPERTY SUBTYPE:',`fp`.`ADDL_FEATURES`)) - locate('PROPERTY SUBTYPE:',`fp`.`ADDL_FEATURES`))),(locate(':',substr(`fp`.`ADDL_FEATURES`,locate('PROPERTY SUBTYPE:',`fp`.`ADDL_FEATURES`),(locate('|',`fp`.`ADDL_FEATURES`,locate('PROPERTY SUBTYPE:',`fp`.`ADDL_FEATURES`)) - locate('PROPERTY SUBTYPE:',`fp`.`ADDL_FEATURES`)))) + 1)) AS `PROPERTYSUBTYPE`,`pp`.`NABRHD_NAME` AS `NABRHD_NAME`,`pp`.`NABRHD_DESC` AS `NABRHD_DESC`,(case when (isnull(`pp`.`EXTRA1`) or (`pp`.`EXTRA1` in ('No','','No','None','0'))) then 'no' else 'yes' end) AS `PETSALLOWED` from ((`tb_pocket_listing`.`property_ptnf` `pp` join `tb_pocket_listing`.`broker_ptnf` `bk` on((`pp`.`TERABITZ_ID` = `bk`.`TERABITZ_ID`))) join `tb_pocket_listing`.`features_ptnf` `fp` on((`bk`.`TERABITZ_ID` = `fp`.`TERABITZ_ID`))) where ((`pp`.`TERABITZ_ID` = `fp`.`TERABITZ_ID`) and (`pp`.`TERABITZ_ID` = `bk`.`TERABITZ_ID`) and (`bk`.`TYPE` = 'Listing Broker') and (`pp`.`DATASOURCE` = 'HOMESMART') and (`pp`.`DISPLAY_LISTING` > 0) and (`pp`.`STATUS` in ('Active','Backup','Active Contingent','Pending','New Home')) and (not((`pp`.`TERABITZ_ID`,`pp`.`DATASOURCE`) in (select `enhp`.`MLS_TERABITZID`,`enhp`.`DATASOURCE` from `tb_enhanced_listing`.`property_ptnf` `enhp` where ((`enhp`.`SOURCE` = 'POCKETLISTING') and (`enhp`.`DATASOURCE` = 'HOMESMART'))))))) union (select `pp`.`TERABITZ_ID` AS `TERABITZ_ID`,`pp`.`ID` AS `ID`,database() AS `Database`,`pp`.`MLS_TERABITZID` AS `MLS_TERABITZID`,`pp`.`DISPLAY_LISTING` AS `DISPLAY_LISTING`,`pp`.`DISPLAY_ADDRESS` AS `DISPLAY_ADDRESS`,`pp`.`STATUS` AS `STATUS`,`pp`.`DESCRIPTION` AS `DESCRIPTION`,`pp`.`DATASOURCE` AS `DATASOURCE`,`pp`.`ADDRESS` AS `ADDRESS`,`pp`.`CITY` AS `CITY`,`pp`.`STATE` AS `STATE`,`pp`.`ZIP` AS `ZIP`,`pp`.`COUNTY` AS `COUNTY`,`pp`.`CURR_LISTPRICE` AS `CURR_LISTPRICE`,`pp`.`LISTDATE` AS `LISTDATE`,(case when ((`pp`.`YEAR_BUILT` in ('','0')) or isnull(`pp`.`YEAR_BUILT`)) then 0 else cast(`pp`.`YEAR_BUILT` as signed) end) AS `YEAR_BUILT`,`pp`.`BEDS` AS `BEDS`,`pp`.`BATHS` AS `BATHS`,`pp`.`latitude` AS `latitude`,`pp`.`longitude` AS `longitude`,date_format(`pp`.`MODIF_TIMESTAMP`,'%Y-%m-%dT%TZ') AS `MODIF_TIMESTAMP`,`pp`.`DAYS_ON_MARKET` AS `DAYS_ON_MARKET`,concat_ws(',',cast(`pp`.`latitude` as char charset latin1),cast(`pp`.`longitude` as char charset latin1)) AS `LATLNG`,`pp`.`MLS_NUMBER` AS `MLS_NUMBER`,cast(`pp`.`AREASQFT` as signed) AS `AREASQFT`,`pp`.`TYPE` AS `TYPE`,`pp`.`PHOTO_COUNT` AS `PHOTO_COUNT`,(case when (isnull(`fp`.`POOL`) or (`fp`.`POOL` in ('No','','No Pool','None','0'))) then 'no' else 'yes' end) AS `POOL`,(case when (isnull(`fp`.`FIREPLACE`) or (`fp`.`FIREPLACE` in ('No','','No','None','0'))) then 'no' else 'yes' end) AS `FIREPLACE`,`fp`.`ARCHITECTURESTYLE` AS `ARCHITECTURESTYLE`,round(substr(substr(`fp`.`ADDL_FEATURES`,locate('FINISHED SQFT:',`fp`.`ADDL_FEATURES`),(locate('|',`fp`.`ADDL_FEATURES`,locate('FINISHED SQFT:',`fp`.`ADDL_FEATURES`)) - locate('FINISHED SQFT:',`fp`.`ADDL_FEATURES`))),(locate(':',substr(`fp`.`ADDL_FEATURES`,locate('FINISHED SQFT:',`fp`.`ADDL_FEATURES`),(locate('|',`fp`.`ADDL_FEATURES`,locate('FINISHED SQFT:',`fp`.`ADDL_FEATURES`)) - locate('FINISHED SQFT:',`fp`.`ADDL_FEATURES`)))) + 1)),0) AS `FINISHEDSQFT`,`fp`.`PARKINGTYPE` AS `PARKINGTYPE`,substr(substr(`fp`.`ADDL_FEATURES`,locate('PARKING TYPE:',`fp`.`ADDL_FEATURES`),(locate('|',`fp`.`ADDL_FEATURES`,locate('PARKING TYPE:',`fp`.`ADDL_FEATURES`)) - locate('PARKING TYPE:',`fp`.`ADDL_FEATURES`))),(locate(':',substr(`fp`.`ADDL_FEATURES`,locate('PARKING TYPE:',`fp`.`ADDL_FEATURES`),(locate('|',`fp`.`ADDL_FEATURES`,locate('PARKING TYPE:',`fp`.`ADDL_FEATURES`)) - locate('PARKING TYPE:',`fp`.`ADDL_FEATURES`)))) + 1)) AS `ADDL_PARKING`,`fp`.`SPORTSCOURT` AS `SPORTSCOURT`,cast((case when (isnull(`fp`.`SPORTSCOURT`) or (`fp`.`SPORTSCOURT` = '') or (`fp`.`SPORTSCOURT` = '0')) then 'No' else 'Yes' end) as char(3) charset latin1) AS `SPORTSCOURTFLAG`,`pp`.`VTOUR_URL` AS `VTOUR_URL`,'ENH' AS `PKTLIST`,0 AS `POSTINGUSER_ID`,(select group_concat(`l`.`URL` order by `l`.`PHOTOORDER` ASC,`l`.`CAPTION` DESC,length(`l`.`URL`) ASC,`l`.`URL` ASC separator ',') from `tb_enhanced_listing`.`links_ptnf` `l` where ((`l`.`TYPE` = 'photo') and (`l`.`TERABITZ_ID` = `pp`.`TERABITZ_ID`))) AS `PHOTOS`,(select `l`.`URL` from `tb_enhanced_listing`.`links_ptnf` `l` where ((`l`.`TYPE` = 'photo') and (`l`.`TERABITZ_ID` = `pp`.`TERABITZ_ID`)) order by `l`.`PHOTOORDER`,`l`.`CAPTION` desc,length(`l`.`URL`),`l`.`URL` limit 1) AS `MAINPHOTO`,(select `b`.`CODE` from `tb_enhanced_listing`.`broker_ptnf` `b` where ((`b`.`TERABITZ_ID` = `pp`.`TERABITZ_ID`) and (`b`.`TYPE` = 'Listing Broker'))) AS `LBid`,(select `b`.`NAME` from `tb_enhanced_listing`.`broker_ptnf` `b` where ((`b`.`TERABITZ_ID` = `pp`.`TERABITZ_ID`) and (`b`.`TYPE` = 'Listing Broker'))) AS `LBname`,(select `b`.`CODE` from `tb_enhanced_listing`.`broker_ptnf` `b` where ((`b`.`TERABITZ_ID` = `pp`.`TERABITZ_ID`) and (`b`.`TYPE` = 'CoListing Broker'))) AS `CoLBid`,(select `b`.`NAME` from `tb_enhanced_listing`.`broker_ptnf` `b` where ((`b`.`TERABITZ_ID` = `pp`.`TERABITZ_ID`) and (`b`.`TYPE` = 'CoListing Broker'))) AS `CoLBname`,(select `u`.`USER_SOURCEID` from `tb_enhanced_listing`.`users_ptnf` `u` where ((`u`.`TERABITZ_ID` = `pp`.`TERABITZ_ID`) and (`u`.`TYPE` = 'Listing Agent'))) AS `LAid`,(select concat(`u`.`FNAME`,' ',`u`.`LNAME`) from `tb_enhanced_listing`.`users_ptnf` `u` where ((`u`.`TERABITZ_ID` = `pp`.`TERABITZ_ID`) and (`u`.`TYPE` = 'Listing Agent'))) AS `LAname`,(select `u`.`USER_SOURCEID` from `tb_enhanced_listing`.`users_ptnf` `u` where ((`u`.`TERABITZ_ID` = `pp`.`TERABITZ_ID`) and (`u`.`TYPE` = 'CoListing Agent'))) AS `CoLAid`,(select concat(`u`.`FNAME`,' ',`u`.`LNAME`) from `tb_enhanced_listing`.`users_ptnf` `u` where ((`u`.`TERABITZ_ID` = `pp`.`TERABITZ_ID`) and (`u`.`TYPE` = 'CoListing Agent'))) AS `CoLAname`,(select `op`.`OPEN_DATE` from `tb_enhanced_listing`.`openhouse_ptnf` `op` where ((`op`.`TERABITZ_ID` = `pp`.`TERABITZ_ID`) and (`op`.`OPEN_DATE` >= curdate())) order by `op`.`OPEN_DATE` limit 1) AS `OPENDATE`,(select `op`.`OPEN_DATE` from `tb_pocket_listing`.`openhouse_ptnf` `op` where ((`op`.`TERABITZ_ID` = `pp`.`MLS_TERABITZID`) and (`op`.`OPEN_DATE` >= curdate()) and (`op`.`SOURCE` = 'HOMESMART')) order by `op`.`OPEN_DATE` limit 1) AS `PKTOPENDATE`,cast((select concat(`op`.`OPEN_DATE`,',',`op`.`OPEN_ST_TIME`,',',`op`.`OPEN_END_TIME`) from `tb_enhanced_listing`.`openhouse_ptnf` `op` where ((`op`.`TERABITZ_ID` = `pp`.`TERABITZ_ID`) and (`op`.`OPEN_DATE` >= curdate())) order by `op`.`OPEN_DATE` limit 1) as char(32) charset latin1) AS `MLSOPENHOMES`,cast((select concat(`op`.`OPEN_DATE`,',',`op`.`OPEN_ST_TIME`,',',`op`.`OPEN_END_TIME`) from `tb_pocket_listing`.`openhouse_ptnf` `op` where ((`op`.`TERABITZ_ID` = `pp`.`MLS_TERABITZID`) and (`op`.`SOURCE` = 'HOMESMART') and (`op`.`OPEN_DATE` >= curdate())) order by `op`.`OPEN_DATE` limit 1) as char(32) charset latin1) AS `PKTOPENHOMES`,(select `tb_pocket_listing`.`openhouse_directions`.`DIRECTIONS` from `tb_pocket_listing`.`openhouse_directions` where ((`tb_pocket_listing`.`openhouse_directions`.`TERABITZ_ID` = `pp`.`MLS_TERABITZID`) and (`tb_pocket_listing`.`openhouse_directions`.`SOURCE` = 'HOMESMART')) limit 1) AS `OPENDIR`,cast(`fp`.`NUMFLOORS` as signed) AS `NUMFLOORS`,cast(`fp`.`NUMPARKINGSPACES` as signed) AS `NUMPARKINGSPACES`,`pp`.`SOURCE` AS `SOURCE`,(case when (isnull(`pp`.`YEAR_BUILT`) or (`pp`.`YEAR_BUILT` = '') or (`pp`.`YEAR_BUILT` = '0')) then 0 else (year(now()) - cast(`pp`.`YEAR_BUILT` as signed)) end) AS `PROPERTYAGE`,(case when ((`pp`.`LOTSQFT` = '') or isnull(`pp`.`LOTSQFT`)) then 0 else cast(`pp`.`LOTSQFT` as signed) end) AS `LOTSQFT`,substr(substr(`fp`.`ADDL_FEATURES`,locate('PROPERTY SUBTYPE:',`fp`.`ADDL_FEATURES`),(locate('|',`fp`.`ADDL_FEATURES`,locate('PROPERTY SUBTYPE:',`fp`.`ADDL_FEATURES`)) - locate('PROPERTY SUBTYPE:',`fp`.`ADDL_FEATURES`))),(locate(':',substr(`fp`.`ADDL_FEATURES`,locate('PROPERTY SUBTYPE:',`fp`.`ADDL_FEATURES`),(locate('|',`fp`.`ADDL_FEATURES`,locate('PROPERTY SUBTYPE:',`fp`.`ADDL_FEATURES`)) - locate('PROPERTY SUBTYPE:',`fp`.`ADDL_FEATURES`)))) + 1)) AS `PROPERTYSUBTYPE`,`pp`.`NABRHD_NAME` AS `NABRHD_NAME`,`pp`.`NABRHD_DESC` AS `NABRHD_DESC`,(case when (isnull(`pp`.`EXTRA1`) or (`pp`.`EXTRA1` in ('No','','No','None','0'))) then 'no' else 'yes' end) AS `PETSALLOWED` from ((`tb_enhanced_listing`.`property_ptnf` `pp` join `tb_enhanced_listing`.`broker_ptnf` `bk` on((`pp`.`TERABITZ_ID` = `bk`.`TERABITZ_ID`))) join `tb_enhanced_listing`.`features_ptnf` `fp` on((`bk`.`TERABITZ_ID` = `fp`.`TERABITZ_ID`))) where ((`pp`.`TERABITZ_ID` = `fp`.`TERABITZ_ID`) and (`pp`.`TERABITZ_ID` = `bk`.`TERABITZ_ID`) and (`bk`.`TYPE` = 'Listing Broker') and (`pp`.`DISPLAY_LISTING` > 0) and (`pp`.`STATUS` in ('Active','Backup','Active Contingent','Pending','New Home')) and (`pp`.`SOURCE` = 'HOMESMART')));



/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;