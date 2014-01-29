-- Drop all view associated with spatial_value_area.size column
DROP VIEW IF EXISTS cadastre.all_plots29;
DROP VIEW IF EXISTS cadastre.all_plots27;
DROP VIEW IF EXISTS cadastre.all_plots;
DROP VIEW IF EXISTS cadastre.plots29;
DROP VIEW IF EXISTS cadastre.plots27;

-- Update the spatial_value_area.size column such it rounds off decimal numbers to integers
UPDATE cadastre.spatial_value_area SET size = ROUND(size,0); 

-- Alter the spatial_value_area.size column to an integer number
ALTER TABLE cadastre.spatial_value_area
   ALTER COLUMN size TYPE numeric(29,0);
ALTER TABLE cadastre.spatial_value_area
  DROP CONSTRAINT IF EXISTS spatial_value_area_spatial_unit_id_fk93;
ALTER TABLE cadastre.spatial_value_area
  DROP CONSTRAINT IF EXISTS spatial_value_area_type_code_fk94;
ALTER TABLE cadastre.spatial_value_area
  ADD CONSTRAINT spatial_value_area_spatial_unit_id_fk93 FOREIGN KEY (spatial_unit_id)
      REFERENCES cadastre.spatial_unit (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE cadastre.spatial_value_area
  ADD CONSTRAINT spatial_value_area_type_code_fk94 FOREIGN KEY (type_code)
      REFERENCES cadastre.area_type (code) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE;


-- Create all view associated with spatial_value_area.size column that were droped earlier
CREATE OR REPLACE VIEW cadastre.all_plots29 AS 
 SELECT c.view_id, c.id, 
    (c.name_firstpart::text || '-'::text) || c.name_lastpart::text AS parcel_code, 
        CASE
            WHEN st_srid(c.geom_polygon) <> 22289 THEN st_transform(c.geom_polygon, 22289)
            ELSE c.geom_polygon
        END AS geom_polygon, 
    c.status_code, 
    ( SELECT spatial_value_area.size
           FROM cadastre.spatial_value_area
          WHERE spatial_value_area.spatial_unit_id::text = c.id::text AND spatial_value_area.type_code::text = 'officialArea'::text
         LIMIT 1) AS official_area
   FROM cadastre.cadastre_object c
  WHERE c.type_code::text = 'parcel'::text AND c.geom_polygon IS NOT NULL;

ALTER TABLE cadastre.all_plots29
  OWNER TO postgres;
GRANT ALL ON TABLE cadastre.all_plots29 TO postgres;
GRANT SELECT ON TABLE cadastre.all_plots29 TO sola_reader;

CREATE OR REPLACE VIEW cadastre.all_plots27 AS 
 SELECT c.view_id, c.id, 
    (c.name_firstpart::text || '-'::text) || c.name_lastpart::text AS parcel_code, 
        CASE
            WHEN st_srid(c.geom_polygon) <> 22287 THEN st_transform(c.geom_polygon, 22287)
            ELSE c.geom_polygon
        END AS geom_polygon, 
    c.status_code, 
    ( SELECT spatial_value_area.size
           FROM cadastre.spatial_value_area
          WHERE spatial_value_area.spatial_unit_id::text = c.id::text AND spatial_value_area.type_code::text = 'officialArea'::text
         LIMIT 1) AS official_area
   FROM cadastre.cadastre_object c
  WHERE c.type_code::text = 'parcel'::text AND c.geom_polygon IS NOT NULL;

ALTER TABLE cadastre.all_plots27
  OWNER TO postgres;
GRANT ALL ON TABLE cadastre.all_plots27 TO postgres;
GRANT SELECT ON TABLE cadastre.all_plots27 TO sola_reader;


CREATE OR REPLACE VIEW cadastre.all_plots AS 
 SELECT c.view_id, c.id, 
    (c.name_firstpart::text || '-'::text) || c.name_lastpart::text AS parcel_code, 
    c.geom_polygon, c.status_code, 
    ( SELECT spatial_value_area.size
           FROM cadastre.spatial_value_area
          WHERE spatial_value_area.spatial_unit_id::text = c.id::text AND spatial_value_area.type_code::text = 'officialArea'::text
         LIMIT 1) AS official_area
   FROM cadastre.cadastre_object c
  WHERE c.type_code::text = 'parcel'::text AND c.geom_polygon IS NOT NULL;

ALTER TABLE cadastre.all_plots
  OWNER TO postgres;
GRANT ALL ON TABLE cadastre.all_plots TO postgres;
GRANT SELECT ON TABLE cadastre.all_plots TO sola_reader;

CREATE OR REPLACE VIEW cadastre.plots29 AS 
 SELECT c.view_id, c.id, 
    (c.name_firstpart::text || '-'::text) || c.name_lastpart::text AS parcel_code, 
    c.geom_polygon, c.status_code, 
    ( SELECT spatial_value_area.size
           FROM cadastre.spatial_value_area
          WHERE spatial_value_area.spatial_unit_id::text = c.id::text AND spatial_value_area.type_code::text = 'officialArea'::text
         LIMIT 1) AS official_area
   FROM cadastre.cadastre_object c
  WHERE c.type_code::text = 'parcel'::text AND c.geom_polygon IS NOT NULL AND st_srid(c.geom_polygon) = 22289;

ALTER TABLE cadastre.plots29
  OWNER TO postgres;
GRANT ALL ON TABLE cadastre.plots29 TO postgres;
GRANT SELECT ON TABLE cadastre.plots29 TO sola_reader;

CREATE OR REPLACE VIEW cadastre.plots27 AS 
 SELECT c.view_id, c.id, 
    (c.name_firstpart::text || '-'::text) || c.name_lastpart::text AS parcel_code, 
    c.geom_polygon, c.status_code, 
    ( SELECT spatial_value_area.size
           FROM cadastre.spatial_value_area
          WHERE spatial_value_area.spatial_unit_id::text = c.id::text AND spatial_value_area.type_code::text = 'officialArea'::text
         LIMIT 1) AS official_area
   FROM cadastre.cadastre_object c
  WHERE c.type_code::text = 'parcel'::text AND c.geom_polygon IS NOT NULL AND st_srid(c.geom_polygon) = 22287;

ALTER TABLE cadastre.plots27
  OWNER TO postgres;
GRANT ALL ON TABLE cadastre.plots27 TO postgres;
GRANT SELECT ON TABLE cadastre.plots27 TO sola_reader;


	
