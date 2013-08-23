-- DROP GEMERTY columns registration from geometry_columns table
DELETE FROM geometry_columns WHERE f_table_schema = 'cadastre' AND f_table_name='plots27' AND f_geometry_column = 'geom_polygon';
DELETE FROM geometry_columns WHERE f_table_schema = 'cadastre' AND f_table_name='plots29' AND f_geometry_column = 'geom_polygon';
DELETE FROM geometry_columns WHERE f_table_schema = 'cadastre' AND f_table_name='all_plots27' AND f_geometry_column = 'geom_polygon';
DELETE FROM geometry_columns WHERE f_table_schema = 'cadastre' AND f_table_name='all_plots29' AND f_geometry_column = 'geom_polygon';
DELETE FROM geometry_columns WHERE f_table_schema = 'cadastre' AND f_table_name='all_plots' AND f_geometry_column = 'geom_polygon';

-- Drop views if they exist
DROP VIEW IF EXISTS cadastre.plots27;
DROP VIEW IF EXISTS cadastre.plots29;
DROP VIEW IF EXISTS cadastre.all_plots;
DROP VIEW IF EXISTS cadastre.all_plots27;
DROP VIEW IF EXISTS cadastre.all_plots29;

DROP SEQUENCE IF EXISTS cadastre.view_id_seq;
CREATE SEQUENCE cadastre.view_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 99999999
  START 1
  CACHE 1;
ALTER TABLE cadastre.view_id_seq
  OWNER TO postgres;
COMMENT ON SEQUENCE cadastre.view_id_seq
  IS 'Used to generate a unique integer number for the cadastre_object table. This id is used as a key by the cadastre views as QGIS requires a unique integer and cannot handle a guid.';

  
ALTER TABLE cadastre.cadastre_object
ADD view_id integer NOT NULL DEFAULT nextval('cadastre.view_id_seq'::regclass);

ALTER TABLE cadastre.cadastre_object_historic
ADD view_id integer;

-- Create user with read-only access rights
do 
$body$
declare 
  num_users integer;
begin
   SELECT count(*) 
     into num_users
   FROM pg_user
   WHERE usename = 'sola_reader';

   IF num_users = 0 THEN
      CREATE ROLE sola_reader LOGIN PASSWORD 'SolaReader';
   ELSE
      ALTER USER sola_reader WITH PASSWORD 'SolaReader';
   END IF;
end
$body$
;

-- Drop all privileges from user 
DROP OWNED BY sola_reader CASCADE;
REVOKE ALL PRIVILEGES ON DATABASE sola FROM sola_reader;

-- Create view to expose plots in Lo27 zone
CREATE OR REPLACE VIEW cadastre.plots27
AS

SELECT c.view_id, c.id, (c.name_firstpart || '-' || c.name_lastpart) AS parcel_code, c.geom_polygon, c.status_code,
(SELECT size FROM cadastre.spatial_value_area WHERE spatial_unit_id = c.id AND type_code = 'officialArea' LIMIT 1) AS official_area
FROM cadastre.cadastre_object c 
WHERE c.type_code= 'parcel' AND c.geom_polygon IS NOT NULL AND ST_SRID(c.geom_polygon) = 22287;

-- Create view to expose plots in Lo29 zone
CREATE OR REPLACE VIEW cadastre.plots29
AS

SELECT c.view_id, c.id, (c.name_firstpart || '-' || c.name_lastpart) AS parcel_code, c.geom_polygon, c.status_code,
(SELECT size FROM cadastre.spatial_value_area WHERE spatial_unit_id = c.id AND type_code = 'officialArea' LIMIT 1) AS official_area
FROM cadastre.cadastre_object c 
WHERE c.type_code= 'parcel' AND c.geom_polygon IS NOT NULL AND ST_SRID(c.geom_polygon) = 22289;

-- Create view to expose all plots
CREATE OR REPLACE VIEW cadastre.all_plots
AS

SELECT c.view_id, c.id, (c.name_firstpart || '-' || c.name_lastpart) AS parcel_code, c.geom_polygon, c.status_code,
(SELECT size FROM cadastre.spatial_value_area WHERE spatial_unit_id = c.id AND type_code = 'officialArea' LIMIT 1) AS official_area
FROM cadastre.cadastre_object c 
WHERE c.type_code= 'parcel' AND c.geom_polygon IS NOT NULL;

-- Create view to expose all plots transormed into Lo27 zone
CREATE OR REPLACE VIEW cadastre.all_plots27
AS

SELECT c.view_id, c.id, (c.name_firstpart || '-' || c.name_lastpart) AS parcel_code, 
(CASE WHEN ST_SRID(c.geom_polygon) != 22287 THEN ST_TRANSFORM(c.geom_polygon, 22287) ELSE c.geom_polygon END) AS geom_polygon, c.status_code,
(SELECT size FROM cadastre.spatial_value_area WHERE spatial_unit_id = c.id AND type_code = 'officialArea' LIMIT 1) AS official_area
FROM cadastre.cadastre_object c
WHERE c.type_code= 'parcel' AND c.geom_polygon IS NOT NULL;

-- Create view to expose all plots transormed into Lo29 zone
CREATE OR REPLACE VIEW cadastre.all_plots29
AS

SELECT c.view_id, c.id, (c.name_firstpart || '-' || c.name_lastpart) AS parcel_code, 
(CASE WHEN ST_SRID(c.geom_polygon) != 22289 THEN ST_TRANSFORM(c.geom_polygon, 22289) ELSE c.geom_polygon END) AS geom_polygon, c.status_code,
(SELECT size FROM cadastre.spatial_value_area WHERE spatial_unit_id = c.id AND type_code = 'officialArea' LIMIT 1) AS official_area
FROM cadastre.cadastre_object c 
WHERE c.type_code= 'parcel' AND c.geom_polygon IS NOT NULL;

-- Register GEOMETRY columns from the views
INSERT INTO geometry_columns(f_table_catalog, f_table_schema, f_table_name, f_geometry_column, coord_dimension, srid, "type")
SELECT '', 'cadastre', 'plots27', 'geom_polygon', ST_CoordDim(geom_polygon), ST_SRID(geom_polygon), GeometryType(geom_polygon)
FROM cadastre.plots27 LIMIT 1;

INSERT INTO geometry_columns(f_table_catalog, f_table_schema, f_table_name, f_geometry_column, coord_dimension, srid, "type")
SELECT '', 'cadastre', 'plots29', 'geom_polygon', ST_CoordDim(geom_polygon), ST_SRID(geom_polygon), GeometryType(geom_polygon)
FROM cadastre.plots29 LIMIT 1;

INSERT INTO geometry_columns(f_table_catalog, f_table_schema, f_table_name, f_geometry_column, coord_dimension, srid, "type")
SELECT '', 'cadastre', 'all_plots27', 'geom_polygon', ST_CoordDim(geom_polygon), ST_SRID(geom_polygon), GeometryType(geom_polygon)
FROM cadastre.all_plots27 LIMIT 1;

INSERT INTO geometry_columns(f_table_catalog, f_table_schema, f_table_name, f_geometry_column, coord_dimension, srid, "type")
SELECT '', 'cadastre', 'all_plots29', 'geom_polygon', ST_CoordDim(geom_polygon), ST_SRID(geom_polygon), GeometryType(geom_polygon)
FROM cadastre.all_plots29 LIMIT 1;

INSERT INTO geometry_columns(f_table_catalog, f_table_schema, f_table_name, f_geometry_column, coord_dimension, srid, "type")
SELECT '', 'cadastre', 'all_plots', 'geom_polygon', ST_CoordDim(geom_polygon), ST_SRID(geom_polygon), GeometryType(geom_polygon)
FROM cadastre.all_plots LIMIT 1;

-- Grant user with minimum required privileges to query the data
GRANT USAGE ON schema cadastre TO sola_reader;
GRANT USAGE ON schema system TO sola_reader;
GRANT USAGE ON schema public TO sola_reader;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO sola_reader;
GRANT SELECT ON system.language TO sola_reader;
GRANT SELECT ON cadastre.plots27, cadastre.plots29, cadastre.all_plots27, cadastre.all_plots29, cadastre.all_plots TO sola_reader;
