--change length of last_name (Ntsane: 07-March-2013)

DROP VIEW administrative.sys_reg_owner_name;

DROP VIEW administrative.sys_reg_state_land;

ALTER TABLE party.party DROP COLUMN last_name;

ALTER TABLE party.party ADD COLUMN last_name character varying(150);


CREATE OR REPLACE VIEW administrative.sys_reg_owner_name AS 
         SELECT (pp.name::text || ' '::text) || COALESCE(pp.last_name, ''::character varying)::text AS value, pp.name::text AS name, COALESCE(pp.last_name, ''::character varying)::text AS last_name, co.id, co.name_firstpart, co.name_lastpart, get_translation(lu.display_value, NULL::character varying) AS land_use_code, su.ba_unit_id, sa.size, 
                CASE
                    WHEN COALESCE(co.land_use_code, 'residential'::character varying)::text = 'residential'::text THEN sa.size
                    ELSE 0::numeric
                END AS residential, 
                CASE
                    WHEN COALESCE(co.land_use_code, 'residential'::character varying)::text = 'agricultural'::text THEN sa.size
                    ELSE 0::numeric
                END AS agricultural, 
                CASE
                    WHEN COALESCE(co.land_use_code, 'residential'::character varying)::text = 'commercial'::text THEN sa.size
                    ELSE 0::numeric
                END AS commercial, 
                CASE
                    WHEN COALESCE(co.land_use_code, 'residential'::character varying)::text = 'industrial'::text THEN sa.size
                    ELSE 0::numeric
                END AS industrial
           FROM cadastre.land_use_type lu, cadastre.cadastre_object co, cadastre.spatial_value_area sa, administrative.ba_unit_contains_spatial_unit su, application.application_property ap, application.application aa, application.service s, party.party pp, administrative.party_for_rrr pr, administrative.rrr rrr, administrative.ba_unit bu
          WHERE sa.spatial_unit_id::text = co.id::text AND sa.type_code::text = 'officialArea'::text AND su.spatial_unit_id::text = sa.spatial_unit_id::text AND (ap.ba_unit_id::text = su.ba_unit_id::text OR ap.name_lastpart::text = bu.name_lastpart::text AND ap.name_firstpart::text = bu.name_firstpart::text) AND aa.id::text = ap.application_id::text AND s.application_id::text = aa.id::text AND s.request_type_code::text = 'systematicRegn'::text AND s.status_code::text = 'completed'::text AND pp.id::text = pr.party_id::text AND pr.rrr_id::text = rrr.id::text AND rrr.ba_unit_id::text = su.ba_unit_id::text AND (rrr.type_code::text = 'ownership'::text OR rrr.type_code::text = 'apartment'::text OR rrr.type_code::text = 'commonOwnership'::text) AND bu.id::text = su.ba_unit_id::text AND COALESCE(co.land_use_code, 'residential'::character varying)::text = lu.code::text
UNION 
         SELECT DISTINCT 'No Claimant '::text AS value, 'No Claimant '::text AS name, 'No Claimant '::text AS last_name, co.id, co.name_firstpart, co.name_lastpart, get_translation(lu.display_value, NULL::character varying) AS land_use_code, su.ba_unit_id, sa.size, 
                CASE
                    WHEN COALESCE(co.land_use_code, 'residential'::character varying)::text = 'residential'::text THEN sa.size
                    ELSE 0::numeric
                END AS residential, 
                CASE
                    WHEN COALESCE(co.land_use_code, 'residential'::character varying)::text = 'agricultural'::text THEN sa.size
                    ELSE 0::numeric
                END AS agricultural, 
                CASE
                    WHEN COALESCE(co.land_use_code, 'residential'::character varying)::text = 'commercial'::text THEN sa.size
                    ELSE 0::numeric
                END AS commercial, 
                CASE
                    WHEN COALESCE(co.land_use_code, 'residential'::character varying)::text = 'industrial'::text THEN sa.size
                    ELSE 0::numeric
                END AS industrial
           FROM cadastre.land_use_type lu, cadastre.cadastre_object co, cadastre.spatial_value_area sa, administrative.ba_unit_contains_spatial_unit su, application.application_property ap, application.application aa, party.party pp, administrative.party_for_rrr pr, administrative.rrr rrr, application.service s, administrative.ba_unit bu
          WHERE sa.spatial_unit_id::text = co.id::text AND COALESCE(co.land_use_code, 'residential'::character varying)::text = lu.code::text AND sa.type_code::text = 'officialArea'::text AND bu.id::text = su.ba_unit_id::text AND su.spatial_unit_id::text = sa.spatial_unit_id::text AND (ap.ba_unit_id::text = su.ba_unit_id::text OR ap.name_lastpart::text = bu.name_lastpart::text AND ap.name_firstpart::text = bu.name_firstpart::text) AND aa.id::text = ap.application_id::text AND NOT (su.ba_unit_id::text IN ( SELECT rrr.ba_unit_id
                   FROM administrative.rrr rrr, party.party pp, administrative.party_for_rrr pr
                  WHERE (rrr.type_code::text = 'ownership'::text OR rrr.type_code::text = 'apartment'::text OR rrr.type_code::text = 'commonOwnership'::text OR rrr.type_code::text = 'stateOwnership'::text) AND pp.id::text = pr.party_id::text AND pr.rrr_id::text = rrr.id::text)) AND s.application_id::text = aa.id::text AND s.request_type_code::text = 'systematicRegn'::text AND s.status_code::text = 'completed'::text
  ORDER BY 3, 2;

ALTER TABLE administrative.sys_reg_owner_name
  OWNER TO postgres;


CREATE OR REPLACE VIEW administrative.sys_reg_state_land AS 
 SELECT (pp.name::text || ' '::text) || COALESCE(pp.last_name, ' '::character varying)::text AS value, co.id, co.name_firstpart, co.name_lastpart, get_translation(lu.display_value, NULL::character varying) AS land_use_code, su.ba_unit_id, sa.size, 
        CASE
            WHEN COALESCE(co.land_use_code, 'residential'::character varying)::text = 'residential'::text THEN sa.size
            ELSE 0::numeric
        END AS residential, 
        CASE
            WHEN COALESCE(co.land_use_code, 'residential'::character varying)::text = 'agricultural'::text THEN sa.size
            ELSE 0::numeric
        END AS agricultural, 
        CASE
            WHEN COALESCE(co.land_use_code, 'residential'::character varying)::text = 'commercial'::text THEN sa.size
            ELSE 0::numeric
        END AS commercial, 
        CASE
            WHEN COALESCE(co.land_use_code, 'residential'::character varying)::text = 'industrial'::text THEN sa.size
            ELSE 0::numeric
        END AS industrial
   FROM cadastre.land_use_type lu, cadastre.cadastre_object co, cadastre.spatial_value_area sa, administrative.ba_unit_contains_spatial_unit su, application.application_property ap, application.application aa, application.service s, party.party pp, administrative.party_for_rrr pr, administrative.rrr rrr, administrative.ba_unit bu
  WHERE sa.spatial_unit_id::text = co.id::text AND COALESCE(co.land_use_code, 'residential'::character varying)::text = lu.code::text AND sa.type_code::text = 'officialArea'::text AND su.spatial_unit_id::text = sa.spatial_unit_id::text AND (ap.ba_unit_id::text = su.ba_unit_id::text OR ap.name_lastpart::text = bu.name_lastpart::text AND ap.name_firstpart::text = bu.name_firstpart::text) AND aa.id::text = ap.application_id::text AND s.application_id::text = aa.id::text AND s.request_type_code::text = 'systematicRegn'::text AND s.status_code::text = 'completed'::text AND pp.id::text = pr.party_id::text AND pr.rrr_id::text = rrr.id::text AND rrr.ba_unit_id::text = su.ba_unit_id::text AND rrr.type_code::text = 'stateOwnership'::text AND bu.id::text = su.ba_unit_id::text
  ORDER BY (pp.name::text || ' '::text) || COALESCE(pp.last_name, ' '::character varying)::text;

ALTER TABLE administrative.sys_reg_state_land
  OWNER TO postgres;

ALTER TABLE system.config_map_layer DROP COLUMN IF EXISTS use_in_public_display;
ALTER TABLE system.config_map_layer ADD COLUMN use_in_public_display BOOLEAN NOT NULL DEFAULT FALSE;

DROP TABLE IF EXISTS administrative.lease_condition_for_rrr;
DROP TABLE IF EXISTS administrative.lease_condition;
 
CREATE TABLE administrative.lease_condition
(
  code character varying(20) NOT NULL,
  display_value character varying(250) NOT NULL,
  description character varying(5000) NOT NULL,
  status character(1) NOT NULL,
  CONSTRAINT lease_condition_pkey PRIMARY KEY (code ),
  CONSTRAINT lease_condition_display_value_unique UNIQUE (display_value )
)
WITH (
  OIDS=FALSE
);
ALTER TABLE administrative.lease_condition
  OWNER TO postgres;
COMMENT ON TABLE administrative.lease_condition
  IS 'Reference Table / Code list for standard lease conditions
LADM Definition
Not Defined';
-- Table: administrative.lease_condition_for_rrr



CREATE TABLE administrative.lease_condition_for_rrr
(
  id character varying(40) NOT NULL,
  rrr_id character varying(40) NOT NULL,
  lease_condition_code character varying(20),
  custom_condition_text character varying(500),
  rowidentifier character varying(40) NOT NULL DEFAULT uuid_generate_v1(),
  rowversion integer NOT NULL DEFAULT 0,
  change_action character(1) NOT NULL DEFAULT 'i'::bpchar,
  change_user character varying(50),
  change_time timestamp without time zone NOT NULL DEFAULT now(),
  CONSTRAINT lease_condition_for_rrr_pkey PRIMARY KEY (id ),
  CONSTRAINT lease_condition_for_rrr_lease_condition_code_fk85 FOREIGN KEY (lease_condition_code)
      REFERENCES administrative.lease_condition (code) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT lease_condition_for_rrr_rrr_id_fk86 FOREIGN KEY (rrr_id)
      REFERENCES administrative.rrr (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE
)
WITH (
  OIDS=FALSE
);
ALTER TABLE administrative.lease_condition_for_rrr
  OWNER TO postgres;
COMMENT ON TABLE administrative.lease_condition_for_rrr
  IS 'Lease conditions, related to RRR of lease type';

-- Index: administrative.lease_condition_for_rrr_index_on_rowidentifier

-- DROP INDEX administrative.lease_condition_for_rrr_index_on_rowidentifier;

CREATE INDEX lease_condition_for_rrr_index_on_rowidentifier
  ON administrative.lease_condition_for_rrr
  USING btree
  (rowidentifier COLLATE pg_catalog."default" );

-- Index: administrative.lease_condition_for_rrr_lease_condition_code_fk85_ind

-- DROP INDEX administrative.lease_condition_for_rrr_lease_condition_code_fk85_ind;

CREATE INDEX lease_condition_for_rrr_lease_condition_code_fk85_ind
  ON administrative.lease_condition_for_rrr
  USING btree
  (lease_condition_code COLLATE pg_catalog."default" );

-- Index: administrative.lease_condition_for_rrr_rrr_id_fk86_ind

-- DROP INDEX administrative.lease_condition_for_rrr_rrr_id_fk86_ind;

CREATE INDEX lease_condition_for_rrr_rrr_id_fk86_ind
  ON administrative.lease_condition_for_rrr
  USING btree
  (rrr_id COLLATE pg_catalog."default" );

ALTER TABLE source.source DROP COLUMN IF EXISTS signing_date;
ALTER TABLE source.source ADD COLUMN signing_date date;

--Table application.application_spatial_unit ----
DROP TABLE IF EXISTS application.application_spatial_unit CASCADE;
CREATE TABLE application.application_spatial_unit(
    application_id varchar(40) NOT NULL,
    spatial_unit_id varchar(40) NOT NULL,
    rowidentifier varchar(40) NOT NULL DEFAULT (uuid_generate_v1()),
    rowversion integer NOT NULL DEFAULT (0),
    change_action char(1) NOT NULL DEFAULT ('i'),
    change_user varchar(50),
    change_time timestamp NOT NULL DEFAULT (now()),

    -- Internal constraints
    
    CONSTRAINT application_spatial_unit_pkey PRIMARY KEY (application_id,spatial_unit_id)
);



-- Index application_spatial_unit_index_on_rowidentifier  --
CREATE INDEX application_spatial_unit_index_on_rowidentifier ON application.application_spatial_unit (rowidentifier);
    

comment on table application.application_spatial_unit is '';
    
DROP TRIGGER IF EXISTS __track_changes ON application.application_spatial_unit CASCADE;
CREATE TRIGGER __track_changes BEFORE UPDATE OR INSERT
   ON application.application_spatial_unit FOR EACH ROW
   EXECUTE PROCEDURE f_for_trg_track_changes();
    

----Table application.application_spatial_unit_historic used for the history of data of table application.application_spatial_unit ---
DROP TABLE IF EXISTS application.application_spatial_unit_historic CASCADE;
CREATE TABLE application.application_spatial_unit_historic
(
    application_id varchar(40),
    spatial_unit_id varchar(40),
    rowidentifier varchar(40),
    rowversion integer,
    change_action char(1),
    change_user varchar(50),
    change_time timestamp,
    change_time_valid_until TIMESTAMP NOT NULL default NOW()
);


-- Index application_spatial_unit_historic_index_on_rowidentifier  --
CREATE INDEX application_spatial_unit_historic_index_on_rowidentifier ON application.application_spatial_unit_historic (rowidentifier);
    

DROP TRIGGER IF EXISTS __track_history ON application.application_spatial_unit CASCADE;
CREATE TRIGGER __track_history AFTER UPDATE OR DELETE
   ON application.application_spatial_unit FOR EACH ROW
   EXECUTE PROCEDURE f_for_trg_track_history();