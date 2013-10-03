DROP SCHEMA IF EXISTS slr CASCADE;
CREATE SCHEMA slr; 

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
  adjudication_parcel_number character varying(40)
);