-- Creates the slr schema in the SOLA database that will be used to
-- migrate the SLR data into SOLA. Also applies a data fix to ensure
-- all cadastre_object records have a matching cadastre.spatial_unit
-- record. It appears the earlier migrations may have failed to 
-- create the correct spatial unit records. 

DROP SCHEMA IF EXISTS slr CASCADE;
CREATE SCHEMA slr; 

INSERT INTO transaction.transaction(id, status_code, approval_datetime, change_user) 
SELECT 'slr-migration', 'approved', now(), 'slr-migration' WHERE NOT EXISTS 
(SELECT id FROM transaction.transaction WHERE id = 'adm-migration');


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
  area NUMERIC (29,2),
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