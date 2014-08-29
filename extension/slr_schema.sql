-- Creates the slr schema in the SOLA database that will be used to
-- migrate the SLR data into SOLA. Also applies a data fix to ensure
-- all cadastre_object records have a matching cadastre.spatial_unit
-- record. It appears the earlier migrations may have failed to 
-- create the correct spatial unit records. 

DROP SCHEMA IF EXISTS slr CASCADE;
CREATE SCHEMA slr; 

INSERT INTO transaction.transaction(id, status_code, approval_datetime, change_user) 
SELECT 'slr-migration', 'approved', now(), 'slr-migration' WHERE NOT EXISTS 
(SELECT id FROM transaction.transaction WHERE id = 'slr-migration');


-- Fix the spatial unit records and cadastre_object records that are unmatched. 
DELETE FROM cadastre.spatial_unit
WHERE level_id = (SELECT id FROM cadastre.level WHERE name = 'Parcels')
AND NOT EXISTS (SELECT c.id from cadastre.cadastre_object c WHERE c.id = spatial_unit.id);

INSERT INTO cadastre.spatial_unit (id, label, level_id, change_user)
SELECT co.id, co.name_firstpart || '-' || co.name_lastpart, l.id, 'slr-migration'
FROM   cadastre.cadastre_object co,
       cadastre.level l
WHERE  l.name = 'Parcels'
AND    NOT EXISTS (SELECT s.id FROM cadastre.spatial_unit s
                   WHERE s.id = co.id);
				   
				   
-- Fix the sequence nr business rule for administrative.notation
DROP SEQUENCE IF EXISTS administrative.notation_reference_nr_seq;
CREATE SEQUENCE  administrative.notation_reference_nr_seq
  INCREMENT 1
  MINVALUE 50000
  MAXVALUE 999999
  START 50000
  CACHE 1;
  
UPDATE system.br_definition 
SET body = 'SELECT trim(to_char(nextval(''administrative.notation_reference_nr_seq''), ''000000'')) AS vl'
WHERE br_id = 'generate-notation-reference-nr'; 

-- Add setting that can be used to enable the SLR Database connection
INSERT INTO system.setting(name, vl, active, description)
SELECT 'slr-db-connection', 'ON', TRUE, 
       'Indicates if SOLA has a valid connection to the SLR Lesotho database. To enable, set to ON'
WHERE NOT EXISTS (SELECT name FROM system.setting WHERE name = 'slr-db-connection'); 

-- Add new Security Role
INSERT INTO system.approle (code, display_value, status, description) 
SELECT 'SlrMigration', 'SLR Migration', 'c', 'Allows the user to perform SLR migration tasks using SOLA Admin.'
WHERE NOT EXISTS (SELECT code FROM system.approle WHERE code = 'SlrMigration');

INSERT INTO system.approle_appgroup (approle_code, appgroup_id) 
SELECT 'SlrMigration', 'administrator-id'
WHERE NOT EXISTS (SELECT approle_code FROM system.approle_appgroup
                  WHERE approle_code = 'SlrMigration'
				  AND   appgroup_id = 'administrator-id'); 

				  
-- Add Service to support registration of pending SLR leases
DELETE FROM application.request_type WHERE code LIKE 'grantSlrLease';
INSERT INTO application.request_type(code, request_category_code, display_value, 
            status, nr_days_to_complete, base_fee, area_base_fee, value_base_fee, 
            nr_properties_required, notation_template, rrr_type_code, type_action_code, 
            description)
    VALUES ('grantSlrLease','registrationServices','Grant SLR Lease','c',5,0,0.00,0.00,0,
	'','lease','vary', 'Allows pending leases migrated from the SLR database to be granted/registered in SOLA');

INSERT INTO system.approle (code, display_value, status, description) 
SELECT 'grantSlrLease', 'Service - Grant SLR Lease', 'c', 'Registration Service - Allows the Grant SLR Lease service to be started.'
WHERE NOT EXISTS (SELECT code FROM system.approle WHERE code = 'grantSlrLease');

INSERT INTO system.approle_appgroup (approle_code, appgroup_id) 
SELECT 'grantSlrLease', 'lease-correct-id'
WHERE NOT EXISTS (SELECT approle_code FROM system.approle_appgroup
                  WHERE approle_code = 'grantSlrLease'
				  AND   appgroup_id = 'lease-correct-id'); 	
			   

DROP TABLE IF EXISTS slr.slr_source;
CREATE TABLE slr.slr_source
(
  id character varying(40) NOT NULL,
  reference_nr character varying(50),
  recordation date,
  submission date DEFAULT now(),
  ext_archive_id character varying(40),
  document_type integer,
  registered boolean,
  version character varying(10),
  description character varying(255),
  adjudication_parcel_number character varying(40)
);


ALTER TABLE source.source
DROP COLUMN IF EXISTS adjudication_parcel_number;

ALTER TABLE source.source
ADD adjudication_parcel_number character varying(40);

ALTER TABLE source.source_historic
DROP COLUMN IF EXISTS adjudication_parcel_number;

ALTER TABLE source.source_historic
ADD adjudication_parcel_number character varying(40);

-- Create index to improve performance of slr load query
CREATE INDEX source_reference_nr_idx
  ON source.source
  USING btree
  (reference_nr COLLATE pg_catalog."default");

INSERT INTO source.administrative_source_type (code, display_value, status)
SELECT 'sar1', 'SAR1', 'c'
WHERE NOT EXISTS (SELECT code FROM source.administrative_source_type WHERE code = 'sar1');
INSERT INTO source.administrative_source_type (code, display_value, status)
SELECT 'evidence', 'Evidence', 'c'
WHERE NOT EXISTS (SELECT code FROM source.administrative_source_type WHERE code = 'evidence');

DROP TABLE IF EXISTS slr.source_type_map;
CREATE TABLE slr.source_type_map
(
  slr_type int,
  sola_type character varying(20)
);

CREATE INDEX source_type_map_slr_type_idx
  ON slr.source_type_map
  USING btree
  (slr_type);

INSERT INTO slr.source_type_map (slr_type, sola_type)
VALUES(0, 'otherDocument'); 
INSERT INTO slr.source_type_map (slr_type, sola_type)
VALUES(1, 'otherDocument');
INSERT INTO slr.source_type_map (slr_type, sola_type)
VALUES(5, 'sar1'); 
INSERT INTO slr.source_type_map (slr_type, sola_type)
VALUES(6, 'lease');
INSERT INTO slr.source_type_map (slr_type, sola_type)
VALUES(7, 'deed'); 
INSERT INTO slr.source_type_map (slr_type, sola_type)
VALUES(8, 'otherDocument');
INSERT INTO slr.source_type_map (slr_type, sola_type)
VALUES(10, 'evidence'); 
INSERT INTO slr.source_type_map (slr_type, sola_type)
VALUES(11, 'allocationTitle');
INSERT INTO slr.source_type_map (slr_type, sola_type)
VALUES(12, 'evidence'); 
INSERT INTO slr.source_type_map (slr_type, sola_type)
VALUES(13, 'evidence'); 
INSERT INTO slr.source_type_map (slr_type, sola_type)
VALUES(14, 'courtOrder'); 
INSERT INTO slr.source_type_map (slr_type, sola_type)
VALUES(15, 'swornAffdt'); 
INSERT INTO slr.source_type_map (slr_type, sola_type)
VALUES(16, 'idVerification');  
INSERT INTO slr.source_type_map (slr_type, sola_type)
VALUES(17, 'idVerification'); 
INSERT INTO slr.source_type_map (slr_type, sola_type)
VALUES(18, 'idVerification');
INSERT INTO slr.source_type_map (slr_type, sola_type)
VALUES(19, 'evidence'); 
INSERT INTO slr.source_type_map (slr_type, sola_type)
VALUES(20, 'powerOfAttorney'); 
INSERT INTO slr.source_type_map (slr_type, sola_type)
VALUES(21, 'evidence');
INSERT INTO slr.source_type_map (slr_type, sola_type)
VALUES(22, 'evidence'); 
INSERT INTO slr.source_type_map (slr_type, sola_type)
VALUES(23, 'marriageCert'); 
INSERT INTO slr.source_type_map (slr_type, sola_type)
VALUES(24, 'deathCert'); 
INSERT INTO slr.source_type_map (slr_type, sola_type)
VALUES(26, 'trust'); 
INSERT INTO slr.source_type_map (slr_type, sola_type)
VALUES(30, 'disputedoc');  
INSERT INTO slr.source_type_map (slr_type, sola_type)
VALUES(32, 'contractForSale'); 
INSERT INTO slr.source_type_map (slr_type, sola_type)
VALUES(47, 'otherDocument');


DROP TABLE IF EXISTS slr.slr_parcel;
CREATE TABLE slr.slr_parcel
(
  id character varying(40) NOT NULL,
  geom geometry,
  ground_rent_zone int,
  lease_number character varying (50),
  village character varying(100),
  area_desc character varying (100),
  adjudication_parcel_number character varying(40),
  area int, 
  address_id character varying(40), 
  matched boolean DEFAULT false,
  update_geom boolean DEFAULT false,
  update_address boolean DEFAULT false,
  update_area boolean DEFAULT false,
  update_zone boolean DEFAULT false
);

ALTER TABLE cadastre.cadastre_object
DROP COLUMN IF EXISTS adjudication_parcel_number;

ALTER TABLE cadastre.cadastre_object
ADD adjudication_parcel_number character varying(40);

ALTER TABLE cadastre.cadastre_object_historic
DROP COLUMN IF EXISTS adjudication_parcel_number;

ALTER TABLE cadastre.cadastre_object_historic
ADD adjudication_parcel_number character varying(40);


DROP TABLE IF EXISTS slr.slr_party;
CREATE TABLE slr.slr_party
(
  id character varying(40),
  name character varying(255),
  last_name character varying(255),
  party_role character varying(50),
  lease_number character varying (50),
  alias character varying(50),
  gender character varying (50),
  dob date,
  email character varying (50),
  mobile character varying(15), 
  home_phone character varying(15),
  work_phone character varying(15),
  marital_status character varying(50),
  marriage_type character varying(50),
  addr character varying(255),
  addr_id character varying(40),
  account_holder int DEFAULT 0,
  slr_reference character varying(255),
  matched boolean DEFAULT false
);

-- Add party role types for slr-migration
INSERT INTO party.party_role_type (code, display_value, status)
SELECT 'landlord', 'Landlord', 'c'
WHERE NOT EXISTS (SELECT code FROM party.party_role_type WHERE code = 'landlord'); 

INSERT INTO party.party_role_type (code, display_value, status)
SELECT 'occupant', 'Occupant', 'c'
WHERE NOT EXISTS (SELECT code FROM party.party_role_type WHERE code = 'occupant'); 

INSERT INTO party.party_role_type (code, display_value, status)
SELECT 'trustee', 'Authorised Trustee', 'c'
WHERE NOT EXISTS (SELECT code FROM party.party_role_type WHERE code = 'trustee'); 

INSERT INTO party.party_role_type (code, display_value, status)
SELECT 'representative', 'Authorised Representative', 'c'
WHERE NOT EXISTS (SELECT code FROM party.party_role_type WHERE code = 'representative'); 

INSERT INTO party.party_role_type (code, display_value, status)
SELECT 'trustor', 'Trustor', 'c'
WHERE NOT EXISTS (SELECT code FROM party.party_role_type WHERE code = 'trustor'); 


DROP TABLE IF EXISTS slr.slr_lease;
CREATE TABLE slr.slr_lease
(
  id character varying(40),
  rrr_id character varying(40),
  notation_id character varying(40), 
  lease_number character varying (50),
  land_use character varying(50),
  stamp_duty character varying (50),
  ground_rent character varying (50),
  reg_fee character varying (50),
  term character varying(50), 
  status character varying(20),
  area int, 
  reg_date DATE,
  cadastre_object_id character varying(40),
  adjudication_parcel_number character varying(40),
  matched boolean DEFAULT false
);

ALTER TABLE administrative.ba_unit
DROP COLUMN IF EXISTS adjudication_parcel_number;

ALTER TABLE  administrative.ba_unit
ADD adjudication_parcel_number character varying(40);

ALTER TABLE  administrative.ba_unit_historic
DROP COLUMN IF EXISTS adjudication_parcel_number;

ALTER TABLE  administrative.ba_unit_historic
ADD adjudication_parcel_number character varying(40);
