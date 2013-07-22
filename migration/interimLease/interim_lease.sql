--create a temporary schema for holding data

--assume the following tables has been migrated to postgresql from access:
--lease_transaction
--lease


drop schema if exists lesotho_etl cascade;
create schema lesotho_etl;

--delete from transaction.transaction where id not in ('adm-transaction', 'cadastre-transaction');
--delete from application.service cascade;
--delete from application.application cascade;
--delete from application.application_property cascade; 

--remove administrative schema records
--DELETE FROM administrative.ba_unit_contains_spatial_unit;
--DELETE FROM application.application_property;
--DELETE FROM administrative.rrr;
--DELETE FROM administrative.ba_unit_area;
--DELETE FROM administrative.ba_unit_historic;
--DELETE FROM administrative.required_relationship_baunit;
--DELETE FROM administrative.ba_unit;
--Remove Ownership details for primary rrr
--DELETE FROM party.party cascade;
--DELETE FROM administrative.party_for_rrr;
--DELETE FROM administrative.rrr_share;


--create lease table

CREATE TABLE lesotho_etl.lease
(
  "Plot_Number" character varying(30),
  "OwnerFamilyName" character varying(50),
  "OwnerOtherNames" character varying(100),
  "OwnerIDDocumentationType" character varying(30),
  "Owner2FamilyName" character varying(100),
  "Owner2OtherNames" character varying(100),
  "MaritalStatus" character varying(255),
  "AuthorisedDocsOther" character varying(100),
  "VillageName" character varying(50),
  "StreetName" character varying(100),
  "District" character varying(50),
  "Gender1" character varying(1),
  "OwnerDoB" timestamp with time zone,
  "OwnerVillageName" character varying(50),
  "OwnerStreetName" character varying(100),
  "Gender2" character varying(1),
  "Owner2DoB" timestamp with time zone,
  "Owner2Village" character varying(50),
  "Owner2StreetName" character varying(100),
  "Owner2IDDocumentationType" character varying(30),
  "EntitlementEvidence" character varying(255),
  "Surveyor" character varying(255),
  "SurveyPlanApprovalDate" character varying(255),
  "Area_sqm" integer,
  "AllocTypeCode" character varying(20),
  "PropertyUseType" character varying(10),
  "LandUseType" character varying(20),
  "LandUseDescription" character varying(255),
  "LeasingOfficer" character varying(50),
  "CSR_Officer" character varying(255),
  "DeedsOfficer" character varying(255),
  "AppDateTime" timestamp with time zone,
  "SurveyApprovedDate" timestamp with time zone,
  "SurveyedArea" integer,
  "PropertyEvidence" text,
  "PostalAddress" character varying(255),
  "PlotLocation" character varying(255),
  "ContactNo" character varying(255),
  "CoLApproved" character(1),
  "CoLApprovalDate" timestamp with time zone,
  "Query" character varying(255),
  "QueryDate" timestamp with time zone,
  "DraftPreparation" character(1),
  "DraftDate" timestamp with time zone,
  "RegistrationDate" timestamp with time zone,
  "CollectionDate" timestamp with time zone,
  "CollectedBy" character varying(100),
  "ID_Collector" character varying(20),
  "CurrentStatus" character varying(255),
  "Stage" character varying(255),
  "LeaseDocumentLocation" text
)
WITH (
  OIDS=FALSE
);
ALTER TABLE lesotho_etl.lease
  OWNER TO postgres;


--create lease transaction table

CREATE TABLE lesotho_etl.lease_transaction
(
  "Plot_Number" character varying(30),
  "DeedNumber" character varying(20),
  "TransactionNumber" integer,
  "TransactionType" character varying(255),
  "AppDate_CS" timestamp with time zone,
  "AppDate_Deeds" timestamp with time zone,
  "OwnerFamilyName" character varying(50),
  "OwnerOtherNames" character varying(100),
  "OwnerIDDocumentationType" character varying(30),
  "Owner2FamilyName" character varying(100),
  "Owner2OtherNames" character varying(100),
  "MaritalStatus" character varying(255),
  "Owner1Gender" character varying(1),
  "Owner2Gender" character varying(1),
  "LeasingOfficer" character varying(50),
  "CSR_Officer" character varying(255),
  "DeedsOfficer" character varying(255),
  "PlotLocation" character varying(255),
  "ContactNo" character varying(255),
  "PostalAddress" character varying(255),
  "ConsentConsiderationAmount" character varying(255),
  "ConsentRecieptNo" character varying(255),
  "ConsentRecieptDate" character varying(255),
  "BenFamilyName" character varying(255),
  "BenOtherName" character varying(255),
  "Ben2FamilyName" character varying(255),
  "Ben2OtherName" character varying(255),
  "MaritalStatusBen" character varying(255),
  "Beneficiary1Gender" character varying(1),
  "Beneficiary2Gender" character varying(1),
  "Ben2Contact" character varying(255),
  "Subleaseperiod" character varying(255),
  "ConsentApprovalDate" timestamp with time zone,
  "Query" character varying(255),
  "QueryDate" timestamp with time zone,
  "RegistrationDate" timestamp with time zone,
  "CollectionDate" timestamp with time zone,
  "CollectedBy" character varying(100),
  "ID_Collector" character varying(20),
  "Stage" character varying(255),
  "StampDuty" double precision,
  "TransferDuty" double precision,
  "LeaseDocumentLocation" text,
  "DeedDocumentLocation" text,
  "LeaseDocumentLocation_tiff" text,
  "DeedDocumentLocation_tiff" text
)
WITH (
  OIDS=FALSE
);
ALTER TABLE lesotho_etl.lease_transaction
  OWNER TO postgres;
  
  
--create a table for holding non natural persons and natural persons

drop table if exists lesotho_etl.party;
create table lesotho_etl.party
(id character varying (150),
ref_id  character varying (150),
name character varying (150),
last_name character varying (150),
type_code character varying(20) NOT NULL,
gender_code character varying(20),
legal_type character varying(20),
rowidentifier character varying(40) NOT NULL DEFAULT uuid_generate_v1(),
rowversion integer NOT NULL DEFAULT 0,
change_action character(1) NOT NULL DEFAULT 'i'::bpchar,
change_user character varying(50),
change_time timestamp without time zone NOT NULL DEFAULT now(),
CONSTRAINT entity_pkey PRIMARY KEY (id ),
CONSTRAINT entity_gender_code_fk13 FOREIGN KEY (gender_code)
	REFERENCES party.gender_type (code) MATCH SIMPLE
	ON UPDATE CASCADE ON DELETE RESTRICT,
CONSTRAINT entity_type_code_fk9 FOREIGN KEY (type_code)
	REFERENCES party.party_type (code) MATCH SIMPLE
	ON UPDATE CASCADE ON DELETE RESTRICT
);


--create a table for holding plots of the parties

drop table if exists lesotho_etl.entity_plots;
create table lesotho_etl.entity_plots
(id character varying (150),
plot_number character varying (12),
registration_date timestamp without time zone,
transaction_type character varying (25),
CONSTRAINT entity_plot_pkey PRIMARY KEY (id, plot_number, registration_date, transaction_type)
);


--property

CREATE TABLE lesotho_etl.ba_unit
(
  id character varying(40) NOT NULL,
  type_code character varying(20) NOT NULL DEFAULT 'basicPropertyUnit'::character varying,
  name character varying(255),
  name_firstpart character varying(20) NOT NULL,
  name_lastpart character varying(50) NOT NULL,
  creation_date timestamp without time zone,
  expiration_date timestamp without time zone,
  status_code character varying(20) NOT NULL DEFAULT 'pending'::character varying,
  transaction_id character varying(40),
  rowidentifier character varying(40) NOT NULL DEFAULT uuid_generate_v1(),
  rowversion integer NOT NULL DEFAULT 0,
  change_action character(1) NOT NULL DEFAULT 'i'::bpchar,
  change_user character varying(50),
  change_time timestamp without time zone NOT NULL DEFAULT now(),
  CONSTRAINT lesotho_etl_ba_unit_pkey PRIMARY KEY (id ),
  CONSTRAINT lesotho_etl_ba_unit_status_code_fk76 FOREIGN KEY (status_code)
      REFERENCES transaction.reg_status_type (code) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT lesotho_etl_ba_unit_transaction_id_fk77 FOREIGN KEY (transaction_id)
      REFERENCES transaction.transaction (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT lesotho_etl_ba_unit_type_code_fk75 FOREIGN KEY (type_code)
      REFERENCES administrative.ba_unit_type (code) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT
)
WITH (
  OIDS=FALSE
);
ALTER TABLE lesotho_etl.ba_unit
  OWNER TO postgres;


--rights or restrictions

CREATE TABLE lesotho_etl.rrr
(
  id character varying(40) NOT NULL,
  ba_unit_id character varying(40) NOT NULL,
  nr character varying(20) NOT NULL,
  type_code character varying(20) NOT NULL,
  status_code character varying(20) NOT NULL DEFAULT 'pending'::character varying,
  is_primary boolean NOT NULL DEFAULT false,
  transaction_id character varying(40) NOT NULL,
  registration_date timestamp without time zone,
  expiration_date timestamp without time zone,
  share double precision,
  mortgage_amount numeric(29,2),
  mortgage_interest_rate numeric(5,2),
  mortgage_ranking integer,
  mortgage_type_code character varying(20),
  rowidentifier character varying(40) NOT NULL DEFAULT uuid_generate_v1(),
  rowversion integer NOT NULL DEFAULT 0,
  change_action character(1) NOT NULL DEFAULT 'i'::bpchar,
  change_user character varying(50),
  change_time timestamp without time zone NOT NULL DEFAULT now(),
  CONSTRAINT lesotho_etl_rrr_pkey PRIMARY KEY (id ),
  CONSTRAINT lesotho_etl_rrr_ba_unit_id_fk79 FOREIGN KEY (ba_unit_id)
      REFERENCES lesotho_etl.ba_unit (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT lesotho_etl_rrr_mortgage_type_code_fk82 FOREIGN KEY (mortgage_type_code)
      REFERENCES administrative.mortgage_type (code) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT lesotho_etl_rrr_status_code_fk80 FOREIGN KEY (status_code)
      REFERENCES transaction.reg_status_type (code) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT lesotho_etl_rrr_transaction_id_fk81 FOREIGN KEY (transaction_id)
      REFERENCES transaction.transaction (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT lesotho_etl_rrr_type_code_fk78 FOREIGN KEY (type_code)
      REFERENCES administrative.rrr_type (code) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT
)
WITH (
  OIDS=FALSE
);
ALTER TABLE lesotho_etl.rrr
  OWNER TO postgres;


--rrr share

CREATE TABLE lesotho_etl.rrr_share
(
  rrr_id character varying(40) NOT NULL,
  id character varying(40) NOT NULL,
  nominator smallint NOT NULL,
  denominator smallint NOT NULL,
  rowidentifier character varying(40) NOT NULL DEFAULT uuid_generate_v1(),
  rowversion integer NOT NULL DEFAULT 0,
  change_action character(1) NOT NULL DEFAULT 'i'::bpchar,
  change_user character varying(50),
  change_time timestamp without time zone NOT NULL DEFAULT now(),
  CONSTRAINT lesotho_etl_rrr_share_pkey PRIMARY KEY (rrr_id , id ),
  CONSTRAINT lesotho_etl_rrr_share_rrr_id_fk68 FOREIGN KEY (rrr_id)
      REFERENCES lesotho_etl.rrr (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE
)
WITH (
  OIDS=FALSE
);
ALTER TABLE lesotho_etl.rrr_share
  OWNER TO postgres;

--party for rrr
CREATE TABLE lesotho_etl.party_for_rrr
(
  rrr_id character varying(40) NOT NULL,
  party_id character varying(40) NOT NULL,
  share_id character varying(40),
  rowidentifier character varying(40) NOT NULL DEFAULT uuid_generate_v1(),
  rowversion integer NOT NULL DEFAULT 0,
  change_action character(1) NOT NULL DEFAULT 'i'::bpchar,
  change_user character varying(50),
  change_time timestamp without time zone NOT NULL DEFAULT now(),
  CONSTRAINT lesotho_etl_party_for_rrr_pkey PRIMARY KEY (rrr_id , party_id),
  CONSTRAINT lesotho_etl_party_for_rrr_party_id_fk71 FOREIGN KEY (party_id)
      REFERENCES lesotho_etl.party (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT lesotho_etl_party_for_rrr_rrr_id_fk69 FOREIGN KEY (rrr_id, share_id)
      REFERENCES lesotho_etl.rrr_share (rrr_id, id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT lesotho_etl_party_for_rrr_rrr_id_fk70 FOREIGN KEY (rrr_id)
      REFERENCES lesotho_etl.rrr (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE
)
WITH (
  OIDS=FALSE
);

ALTER TABLE lesotho_etl.party_for_rrr
  OWNER TO postgres;
  
create table lesotho_etl.myshare
(m_rrr_id character varying(40),
denominator smallint NOT NULL
);

create table lesotho_etl.title
(
ba_unit_id character varying(40),
ba_unit_count smallint
);

create table lesotho_etl.title_rrr
(
ba_unit_id character varying(40),
rrr_id character varying(40),
registration_date timestamp without time zone,
notation_text  character varying(40)
);

create table lesotho_etl.cancelled_title
(
plot_number character varying(20),
ba_unit_id character varying(40)
);
 
CREATE OR REPLACE FUNCTION lesotho_etl.update_shares() RETURNS VARCHAR
AS
$BODY$
DECLARE 
	rec RECORD;
	curr_rrr_id VARCHAR(40);
	curr_denominator smallint;
BEGIN
	-- Process each share. 
	FOR rec IN EXECUTE 'SELECT m_rrr_id, denominator
                FROM lesotho_etl.myshare
                ORDER BY m_rrr_id'
	LOOP
		curr_rrr_id := rec.m_rrr_id;
		curr_denominator := rec.denominator;

		UPDATE administrative.rrr_share
		SET denominator = curr_denominator
		WHERE rrr_id = curr_rrr_id;
	END LOOP;
	RETURN 'ok';
END;
$BODY$
  LANGUAGE plpgsql;
  
  
  
CREATE OR REPLACE FUNCTION lesotho_etl.process_title() RETURNS VARCHAR
AS
$BODY$
DECLARE 
	rec RECORD;
	curr_rrr_id VARCHAR(40);
	ba_unit_id VARCHAR(40);
	curr_ba_unit_id VARCHAR(40)  := '';
	curr_status VARCHAR(20) := '';
	notation_text VARCHAR(20) := '';
	hist_count INT := 0;
	
BEGIN
	-- Process each title. 
	FOR rec IN EXECUTE 'select ba_unit_id, rrr_id, registration_date, notation_text FROM lesotho_etl.title_rrr
						order by ba_unit_id, registration_date desc'
						
	LOOP
		curr_rrr_id := rec.rrr_id;
		ba_unit_id := rec.ba_unit_id;
		notation_text :=rec.notation_text;

		IF ba_unit_id != curr_ba_unit_id THEN
		   curr_ba_unit_id := ba_unit_id;
		   curr_status := 'current';
		   hist_count := 0;
		ELSE
			 hist_count := hist_count + 1;
			 curr_status := 'previous';
		END IF;
		
		IF notation_text = 'ownership' THEN
		   -- set the rrr to historic 
		   curr_status := 'previous';
		   hist_count = hist_count + 1;	
		END IF;
		
		IF hist_count > 1 THEN
		      curr_status := 'previous'; 
		   END IF;
		
		UPDATE administrative.rrr
		SET status_code = curr_status
		WHERE id = curr_rrr_id;
		
	END LOOP;
	RETURN 'ok';
END;
$BODY$
  LANGUAGE plpgsql;
  
  
  
CREATE OR REPLACE FUNCTION lesotho_etl.process_surrendered_titles() RETURNS VARCHAR
AS
$BODY$
DECLARE 
	rec RECORD;
	curr_ba_unit_id VARCHAR(40);
	curr_plot_number VARCHAR(40)  := '';
	
BEGIN
	-- Process each title. 
	FOR rec IN EXECUTE 'select ba_unit_id, plot_number 
						FROM lesotho_etl.cancelled_title'
						
	LOOP
		curr_plot_number := rec.plot_number;
		curr_ba_unit_id := rec.ba_unit_id;
		
		
		update administrative.ba_unit 
		set status_code = 'historic'
		where name = curr_plot_number;
  
  
		update administrative.rrr 
		set status_code = 'historic'
		where ba_unit_id = curr_ba_unit_id;
		
		insert into administrative.rrr
		(id, ba_unit_id, nr, type_code, status_code, is_primary, transaction_id, 
		registration_date, expiration_date, share, mortgage_amount, mortgage_interest_rate, 
		mortgage_ranking, mortgage_type_code, rowversion, change_action, change_user, change_time)
		SELECT uuid_generate_v1(), ba_unit_id, nr, type_code, 'previous', is_primary, transaction_id, 
		registration_date, expiration_date, share, mortgage_amount, mortgage_interest_rate, 
		mortgage_ranking, mortgage_type_code, 3, change_action, change_user, change_time
		FROM administrative.rrr
		where ba_unit_id = curr_ba_unit_id and status_code = 'historic';
		
	END LOOP;
	RETURN 'ok';
END;
$BODY$
  LANGUAGE plpgsql;
  
  
  
CREATE OR REPLACE FUNCTION lesotho_etl.update_land_use_type() RETURNS VARCHAR
AS
$BODY$
DECLARE 
	rec RECORD;
	plot_land_use_code VARCHAR(20);
	curr_land_use_code VARCHAR(20);
	curr_plot_number VARCHAR(20);
	
	
BEGIN
	-- Process each title. 
	FOR rec IN EXECUTE 'select 
						distinct
						"Plot_Number" as plot_number,
						"LandUseDescription" as land_use_description
						From lesotho_etl.lease'
						
	LOOP
	
		curr_plot_number := rec.plot_number;
		curr_land_use_code := rec.land_use_description;
		--
	
		IF curr_land_use_code = 'AGRICULTURAL' THEN
		   -- set
			plot_land_use_code = 'agricultural';
					   
		END IF;
		
		IF curr_land_use_code = 'COMMERCIAL' THEN
		   -- set
			plot_land_use_code = 'commercial';
					   
		END IF;
		
		IF curr_land_use_code = 'CHARITABLE' THEN
		   -- set
			plot_land_use_code = 'charitable';
					   
		END IF;
		
		IF curr_land_use_code = 'EDUCATIONAL' THEN
		   -- set
			plot_land_use_code = 'educational';
					   
		END IF;
		
		IF curr_land_use_code = 'HOTEL' THEN
		   -- set
			plot_land_use_code = 'hotel';
					   
		END IF;
		
		IF curr_land_use_code = 'HOSPITAL' THEN
		   -- set
			plot_land_use_code = 'hospital';
					   
		END IF;
		
		IF curr_land_use_code = 'INDUSTRIAL' THEN
		   -- set
			plot_land_use_code = 'industrial';
					   
		END IF;
		
		IF curr_land_use_code = 'PETROLEUM' THEN
		   -- set
			plot_land_use_code = 'petroleum';
					   
		END IF;
		
		IF curr_land_use_code = 'RESIDENTIAL' THEN
		   -- set
			plot_land_use_code = 'residential';
					   
		END IF;
		
		IF curr_land_use_code = 'RECREATIONAL' THEN
		   -- set
			plot_land_use_code = 'recreational';
					   
		END IF;
		
		IF curr_land_use_code = 'RELIGIOUS' THEN
		   -- set
			plot_land_use_code = 'religious';
					   
		END IF;
		
		
		
		update cadastre.spatial_unit
		set land_use_code = plot_land_use_code
		where label = curr_plot_number;
		
	END LOOP;
	
		
	RETURN 'ok';
END;
$BODY$
  LANGUAGE plpgsql;
 