-- Drop views if they exist
DROP VIEW IF EXISTS cadastre.plots27;
DROP VIEW IF EXISTS cadastre.plots29;
DROP VIEW IF EXISTS cadastre.all_plots;
DROP VIEW IF EXISTS cadastre.all_plots27;
DROP VIEW IF EXISTS cadastre.all_plots29;

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

SELECT c.id, (c.name_firstpart || '-' || c.name_lastpart) AS parcel_code, c.geom_polygon, get_translation(lu.display_value, null) AS land_use,
lu.code AS land_use_code, c.status_code,
(SELECT size FROM cadastre.spatial_value_area WHERE spatial_unit_id = c.id AND type_code = 'officialArea' LIMIT 1) AS official_area
FROM cadastre.cadastre_object c LEFT JOIN cadastre.land_use_type lu ON c.land_use_code = lu.code 
WHERE c.type_code= 'parcel' AND c.geom_polygon IS NOT NULL AND ST_SRID(c.geom_polygon) = 22287;

-- Create view to expose plots in Lo29 zone
CREATE OR REPLACE VIEW cadastre.plots29
AS

SELECT c.id, (c.name_firstpart || '-' || c.name_lastpart) AS parcel_code, c.geom_polygon, get_translation(lu.display_value, null) AS land_use,
lu.code AS land_use_code, c.status_code,
(SELECT size FROM cadastre.spatial_value_area WHERE spatial_unit_id = c.id AND type_code = 'officialArea' LIMIT 1) AS official_area
FROM cadastre.cadastre_object c LEFT JOIN cadastre.land_use_type lu ON c.land_use_code = lu.code 
WHERE c.type_code= 'parcel' AND c.geom_polygon IS NOT NULL AND ST_SRID(c.geom_polygon) = 22289;

-- Create view to expose all plots
CREATE OR REPLACE VIEW cadastre.all_plots
AS

SELECT c.id, (c.name_firstpart || '-' || c.name_lastpart) AS parcel_code, c.geom_polygon, get_translation(lu.display_value, null) AS land_use,
lu.code AS land_use_code, c.status_code,
(SELECT size FROM cadastre.spatial_value_area WHERE spatial_unit_id = c.id AND type_code = 'officialArea' LIMIT 1) AS official_area
FROM cadastre.cadastre_object c LEFT JOIN cadastre.land_use_type lu ON c.land_use_code = lu.code 
WHERE c.type_code= 'parcel' AND c.geom_polygon IS NOT NULL;

-- Create view to expose all plots transormed into Lo27 zone
CREATE OR REPLACE VIEW cadastre.all_plots27
AS

SELECT c.id, (c.name_firstpart || '-' || c.name_lastpart) AS parcel_code, 
(CASE WHEN ST_SRID(c.geom_polygon) != 22287 THEN ST_TRANSFORM(c.geom_polygon, 22287) ELSE c.geom_polygon END) AS geom_polygon, 
get_translation(lu.display_value, null) AS land_use,
lu.code AS land_use_code, c.status_code,
(SELECT size FROM cadastre.spatial_value_area WHERE spatial_unit_id = c.id AND type_code = 'officialArea' LIMIT 1) AS official_area
FROM cadastre.cadastre_object c LEFT JOIN cadastre.land_use_type lu ON c.land_use_code = lu.code 
WHERE c.type_code= 'parcel' AND c.geom_polygon IS NOT NULL;

-- Create view to expose all plots transormed into Lo29 zone
CREATE OR REPLACE VIEW cadastre.all_plots29
AS

SELECT c.id, (c.name_firstpart || '-' || c.name_lastpart) AS parcel_code, 
(CASE WHEN ST_SRID(c.geom_polygon) != 22289 THEN ST_TRANSFORM(c.geom_polygon, 22289) ELSE c.geom_polygon END) AS geom_polygon, 
get_translation(lu.display_value, null) AS land_use,
lu.code AS land_use_code, c.status_code,
(SELECT size FROM cadastre.spatial_value_area WHERE spatial_unit_id = c.id AND type_code = 'officialArea' LIMIT 1) AS official_area
FROM cadastre.cadastre_object c LEFT JOIN cadastre.land_use_type lu ON c.land_use_code = lu.code 
WHERE c.type_code= 'parcel' AND c.geom_polygon IS NOT NULL;

-- Grant user with minimum required privileges to query the data
GRANT USAGE ON schema cadastre TO sola_reader;
GRANT USAGE ON schema system TO sola_reader;
GRANT USAGE ON schema public TO sola_reader;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO sola_reader;
GRANT SELECT ON system.language TO sola_reader;
GRANT SELECT ON cadastre.plots27, cadastre.plots29, cadastre.all_plots27, cadastre.all_plots29, cadastre.all_plots TO sola_reader;
