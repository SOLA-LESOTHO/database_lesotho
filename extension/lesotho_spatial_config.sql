﻿--Hold original values for srid 22287 in a new row with srid = 40000
DELETE FROM public.spatial_ref_sys WHERE srid = 40000;
INSERT INTO public.spatial_ref_sys(srid, auth_name, auth_srid, srtext, proj4text)
	SELECT 40000, auth_name, 40000, srtext, proj4text FROM spatial_ref_sys WHERE srid = 22287;

-- Modify srid 22287 for south oriented coordinat systems 
UPDATE public.spatial_ref_sys set srtext = 
	'PROJCS["Cape / Lo27",GEOGCS["Cape",DATUM["Cape",SPHEROID["Clarke 1880 (Arc)",6378249.145,293.4663077,AUTHORITY["EPSG","7013"]],AUTHORITY["EPSG","6222"]],PRIMEM["Greenwich",0,AUTHORITY["EPSG","8901"]],UNIT["degree",0.01745329251994328,AUTHORITY["EPSG","9122"]],AUTHORITY["EPSG","4222"]],UNIT["metre",1,AUTHORITY["EPSG","9001"]],PROJECTION["Transverse Mercator (South Orientated)"],PARAMETER["latitude_of_origin",0],PARAMETER["central_meridian",27],PARAMETER["scale_factor",1],PARAMETER["false_easting",0],PARAMETER["false_northing",0],AUTHORITY["EPSG","22287"],AXIS["Y",WEST],AXIS["X",SOUTH]]'
WHERE srid = 22287;  

----- Existing Layer Updates ----
-- Remove layers from core SOLA that are not used by Lesotho
--DELETE FROM system.config_map_layer WHERE "name" IN ('place-names', 'survey-controls', 'roads'); 

---- Update existing layers to use correct sytles and item_order ----- 

-- Disable this map layer for the time being. LAA have requested 
-- orhtophotos, but this layer needs further configuration before
-- it is made availalbe.  
UPDATE system.config_map_layer
SET item_order = 10, 
    visible_in_start = FALSE,
	active = FALSE
WHERE "name" = 'orthophoto';

UPDATE system.config_map_layer
SET item_order = 10, 
    visible_in_start = FALSE,
	active = FALSE
WHERE "name" = 'place_name';

UPDATE system.config_map_layer
SET item_order = 10, 
    visible_in_start = FALSE,
	active = FALSE
WHERE "name" = 'survey_control';

UPDATE system.config_map_layer
SET style = 'parcel.xml', 
    item_order = 30,
    title = 'Plots'
WHERE "name" = 'parcels'; 

UPDATE system.config_map_layer
SET pojo_structure = 'theGeom:LineString,label:""',

WHERE "name" = 'roads'; 

-- Name Translations
--UPDATE system.config_map_layer SET title = 'Applications::::Talosaga' WHERE "name" = 'applications';
 
-- Function to assist the formatting of the parcel number
--CREATE OR REPLACE FUNCTION cadastre.formatParcelNr(first_part CHARACTER VARYING(20), last_part CHARACTER VARYING(50))
-- RETURNS CHARACTER VARYING(100) AS $BODY$
--  BEGIN
--    RETURN first_part || ' PLAN ' || last_part; 
--  END; $BODY$
--  LANGUAGE plpgsql VOLATILE;
--  COMMENT ON FUNCTION cadastre.formatParcelNr(CHARACTER VARYING(20), CHARACTER VARYING(50)) 
--  IS 'Formats the number/appellation to use for the parcel';
  
--CREATE OR REPLACE FUNCTION cadastre.formatParcelNrLabel(first_part CHARACTER VARYING(20), last_part CHARACTER VARYING(50))
--  RETURNS CHARACTER VARYING(100) AS $BODY$
--  BEGIN
--    RETURN first_part || chr(10) || last_part; 
--  END; $BODY$
--  LANGUAGE plpgsql VOLATILE;
--  COMMENT ON FUNCTION cadastre.formatParcelNrLabel(CHARACTER VARYING(20), CHARACTER VARYING(50)) 
--  IS 'Formats the number/appellation for the parcel over 2 lines';

-- Information Tool Queries (existing layers) 
--CREATE OR REPLACE FUNCTION cadastre.formatAreaMetric(area NUMERIC(29,2))
--  RETURNS CHARACTER VARYING(40) AS $BODY$
--  BEGIN
--	CASE WHEN area IS NULL THEN RETURN NULL;
--	WHEN area < 1 THEN RETURN '    < 1 m' || chr(178);
--	WHEN area < 10000 THEN RETURN to_char(area, '999,999 m') || chr(178);
--	ELSE RETURN to_char((area/10000), '999,999.999 ha'); 
--	END CASE; 
--  END; $BODY$
--  LANGUAGE plpgsql VOLATILE;
--  COMMENT ON FUNCTION cadastre.formatAreaMetric(NUMERIC(29,2)) 
--  IS 'Formats a metric area to m2 or hectares if area > 10,000m2';
  
--CREATE OR REPLACE FUNCTION cadastre.formatareaimperial(area numeric)
--  RETURNS character varying AS
--$BODY$
--   DECLARE perches NUMERIC(29,12); 
--   DECLARE roods   NUMERIC(29,12); 
--   DECLARE acres   NUMERIC(29,12);
--   DECLARE remainder NUMERIC(29,12);
--   DECLARE result  CHARACTER VARYING(40) := ''; 
--   BEGIN
--	IF area IS NULL THEN RETURN NULL; END IF; 
--	acres := (area/4046.8564); -- 1a = 4046.8564m2     
--	remainder := acres - trunc(acres,0);  
--	roods := (remainder * 4); -- 4 roods to an acre
--	remainder := roods - trunc(roods,0);
--	perches := (remainder * 40); -- 40 perches to a rood
--	IF acres >= 1 THEN
--	  result := trim(to_char(trunc(acres,0), '9,999,999a')); 
--	END IF; 
	-- Allow for the rounding introduced by to_char by manually incrementing
	-- the roods if perches are >= 39.95
--	IF perches >= 39.95 THEN
--	   roods := roods + 1;
--	   perches = 0; 
--	END IF; 
--	IF acres >= 1 OR roods >= 1 THEN
--	  result := result || ' ' || trim(to_char(trunc(roods,0), '99r'));
--	END IF; 
--	  result := result || ' ' || trim(to_char(perches, '00.0p'));
--	RETURN '('  || trim(result) || ')';  
--  END; 
--    $BODY$
--  LANGUAGE plpgsql VOLATILE
--  COST 100;

--ALTER FUNCTION cadastre.formatareaimperial(numeric)
--  OWNER TO postgres;
--COMMENT ON FUNCTION cadastre.formatareaimperial(numeric) IS 'Formats a metric area to an imperial area measurement consisting of arces, roods and perches';

-- Add official area and calculated area to the parcel information
--UPDATE system.query SET sql = 
--	'SELECT co.id, 
--			cadastre.formatParcelNr(co.name_firstpart, co.name_lastpart) as parcel_nr,
--		   (SELECT string_agg(ba.name_firstpart || ''/'' || ba.name_lastpart, '','') 
--			FROM 	administrative.ba_unit_contains_spatial_unit bas, 
--					administrative.ba_unit ba
--			WHERE	spatial_unit_id = co.id and bas.ba_unit_id = ba.id) AS ba_units,
--			cadastre.formatAreaMetric(sva.size) || '' '' || cadastre.formatAreaImperial(sva.size) AS official_area,
--			CASE WHEN sva.size IS NOT NULL THEN NULL
--			     ELSE cadastre.formatAreaMetric(CAST(st_area(co.geom_polygon) AS NUMERIC(29,2))) || '' '' ||
--			cadastre.formatAreaImperial(CAST(st_area(co.geom_polygon) AS NUMERIC(29,2))) END AS calculated_area,
--			st_asewkb(co.geom_polygon) as the_geom
--	FROM 	cadastre.cadastre_object co LEFT OUTER JOIN cadastre.spatial_value_area sva 
--			ON sva.spatial_unit_id = co.id AND sva.type_code = ''officialArea''
--	WHERE 	co.type_code= ''parcel'' 
--	AND 	co.status_code= ''current''      
--	AND 	ST_Intersects(co.geom_polygon, ST_SetSRID(ST_GeomFromWKB(#{wkb_geom}), #{srid}))'
--WHERE "name" = 'dynamic.informationtool.get_parcel';

-- Update the query fields for the get_parcel information tool
--DELETE FROM system.query_field WHERE query_name = 'dynamic.informationtool.get_parcel'; 
--INSERT INTO system.query_field(query_name, index_in_query, "name", display_value) 
-- VALUES ('dynamic.informationtool.get_parcel', 0, 'id', null); 

--INSERT INTO system.query_field(query_name, index_in_query, "name", display_value) 
-- VALUES ('dynamic.informationtool.get_parcel', 1, 'parcel_nr', 'Parcel number::::Poloka numera'); 

-- INSERT INTO system.query_field(query_name, index_in_query, "name", display_value) 
-- VALUES ('dynamic.informationtool.get_parcel', 2, 'ba_units', 'Properties::::Meatotino'); 
 
--  INSERT INTO system.query_field(query_name, index_in_query, "name", display_value) 
-- VALUES ('dynamic.informationtool.get_parcel', 3, 'official_area', 'Official area::::SAMOAN'); 
 
--  INSERT INTO system.query_field(query_name, index_in_query, "name", display_value) 
-- VALUES ('dynamic.informationtool.get_parcel', 4, 'calculated_area', 'Calculated area::::SAMOAN'); 
 
--INSERT INTO system.query_field(query_name, index_in_query, "name", display_value) 
-- VALUES ('dynamic.informationtool.get_parcel', 5, 'the_geom', null); 

 
-- Add official area and calculated area to the pending parcel information
--UPDATE system.query SET sql = 
--	'SELECT co.id, 
--			cadastre.formatParcelNr(co.name_firstpart, co.name_lastpart) as parcel_nr,
--			cadastre.formatAreaMetric(sva.size) || '' '' || cadastre.formatAreaImperial(sva.size) AS official_area,
--			CASE WHEN sva.size IS NOT NULL THEN NULL
--			     ELSE cadastre.formatAreaMetric(CAST(st_area(co.geom_polygon) AS NUMERIC(29,2))) || '' '' ||
--			cadastre.formatAreaImperial(CAST(st_area(co.geom_polygon) AS NUMERIC(29,2))) END AS calculated_area,
--			st_asewkb(co.geom_polygon) as the_geom
--	FROM 	cadastre.cadastre_object co LEFT OUTER JOIN cadastre.spatial_value_area sva 
--			ON sva.spatial_unit_id = co.id AND sva.type_code = ''officialArea''
--	WHERE   co.type_code= ''parcel'' 
--	AND   ((co.status_code = ''pending''    
--	AND 	ST_Intersects(co.geom_polygon, ST_SetSRID(ST_GeomFromWKB(#{wkb_geom}), #{srid})))   
--	   OR  (co.id in (SELECT 	cadastre_object_id           
--					  FROM 		cadastre.cadastre_object_target co_t,
--								transaction.transaction t
--					  WHERE 	ST_Intersects(co_t.geom_polygon, ST_SetSRID(ST_GeomFromWKB(#{wkb_geom}), #{srid})) 
--					  AND 		co_t.transaction_id = t.id
--					  AND		t.status_code not in (''approved''))))'
--WHERE "name" = 'dynamic.informationtool.get_parcel_pending';

-- Update the query fields for the get_parcel_pending information tool
--DELETE FROM system.query_field WHERE query_name = 'dynamic.informationtool.get_parcel_pending'; 
--INSERT INTO system.query_field(query_name, index_in_query, "name", display_value) 
-- VALUES ('dynamic.informationtool.get_parcel_pending', 0, 'id', null); 

--INSERT INTO system.query_field(query_name, index_in_query, "name", display_value) 
-- VALUES ('dynamic.informationtool.get_parcel_pending', 1, 'parcel_nr', 'Parcel number::::Poloka numera'); 
 
--  INSERT INTO system.query_field(query_name, index_in_query, "name", display_value) 
-- VALUES ('dynamic.informationtool.get_parcel_pending', 2, 'official_area', 'Official area::::SAMOAN'); 
 
--  INSERT INTO system.query_field(query_name, index_in_query, "name", display_value) 
-- VALUES ('dynamic.informationtool.get_parcel_pending', 3, 'calculated_area', 'Calculated area::::SAMOAN'); 
 
--INSERT INTO system.query_field(query_name, index_in_query, "name", display_value) 
-- VALUES ('dynamic.informationtool.get_parcel_pending', 4, 'the_geom', null); 
 
-- Add official area and calculated area to the historic parcel, current title information
--UPDATE system.query SET sql = 
--	'SELECT co.id, 
--			cadastre.formatParcelNr(co.name_firstpart, co.name_lastpart) as parcel_nr,
--		   (SELECT string_agg(ba.name_firstpart || ''/'' || ba.name_lastpart, '','') 
--			FROM 	administrative.ba_unit_contains_spatial_unit bas, 
--					administrative.ba_unit ba
--			WHERE	spatial_unit_id = co.id and bas.ba_unit_id = ba.id) AS ba_units,
--			cadastre.formatAreaMetric(sva.size) || '' '' || cadastre.formatAreaImperial(sva.size) AS official_area,
--			CASE WHEN sva.size IS NOT NULL THEN NULL
--			     ELSE cadastre.formatAreaMetric(CAST(st_area(co.geom_polygon) AS NUMERIC(29,2))) || '' '' ||
--			cadastre.formatAreaImperial(CAST(st_area(co.geom_polygon) AS NUMERIC(29,2))) END AS calculated_area,
--			st_asewkb(co.geom_polygon) as the_geom
--	FROM 	cadastre.cadastre_object co LEFT OUTER JOIN cadastre.spatial_value_area sva 
--			ON sva.spatial_unit_id = co.id AND sva.type_code = ''officialArea'', 
--			administrative.ba_unit_contains_spatial_unit ba_co, 
--			administrative.ba_unit ba
--	WHERE 	co.type_code= ''parcel'' 
--	AND 	co.status_code= ''historic''      
--	AND 	ST_Intersects(co.geom_polygon, ST_SetSRID(ST_GeomFromWKB(#{wkb_geom}), #{srid}))
--	AND     ba_co.spatial_unit_id = co.id
--	AND		ba.id = ba_co.ba_unit_id
--	AND		ba.status_code = ''current'''
--WHERE "name" = 'dynamic.informationtool.get_parcel_historic_current_ba';

-- Update the query fields for the get_parcel_pending information tool
--DELETE FROM system.query_field WHERE query_name = 'dynamic.informationtool.get_parcel_historic_current_ba'; 
--INSERT INTO system.query_field(query_name, index_in_query, "name", display_value) 
-- VALUES ('dynamic.informationtool.get_parcel_historic_current_ba', 0, 'id', null); 

--INSERT INTO system.query_field(query_name, index_in_query, "name", display_value) 
-- VALUES ('dynamic.informationtool.get_parcel_historic_current_ba', 1, 'parcel_nr', 'Parcel number::::Poloka numera'); 

-- INSERT INTO system.query_field(query_name, index_in_query, "name", display_value) 
-- VALUES ('dynamic.informationtool.get_parcel_historic_current_ba', 2, 'ba_units', 'Properties::::Meatotino'); 
 
--  INSERT INTO system.query_field(query_name, index_in_query, "name", display_value) 
-- VALUES ('dynamic.informationtool.get_parcel_historic_current_ba', 3, 'official_area', 'Official area::::SAMOAN'); 
 
--  INSERT INTO system.query_field(query_name, index_in_query, "name", display_value) 
-- VALUES ('dynamic.informationtool.get_parcel_historic_current_ba', 4, 'calculated_area', 'Calculated area::::SAMOAN'); 
 
--INSERT INTO system.query_field(query_name, index_in_query, "name", display_value) 
-- VALUES ('dynamic.informationtool.get_parcel_historic_current_ba', 5, 'the_geom', null); 
-- Create Layers to be used by the SOLA for display
	
-- Zones Layer --		
-- Remove any pre-existing data for the new navigation layer
DELETE FROM system.query_field
 WHERE query_name = 'dynamic.informationtool.get_zones';

DELETE FROM system.config_map_layer
 WHERE "name" = 'zones';

DELETE FROM system.query
 WHERE "name" IN ('dynamic.informationtool.get_zones', 
 'SpatialResult.getZones');

 -- Add the necessary dynamic queries
INSERT INTO system.query("name", sql)
 VALUES ('SpatialResult.getZones', 
 'select su.id, su.label,  st_asewkb(su.reference_point) as the_geom from cadastre.spatial_unit su, cadastre.level l where su.level_id = l.id and l."name" = ''Zones'' and ST_Intersects(su.reference_point, ST_SetSRID(ST_MakeBox3D(ST_Point(#{minx}, #{miny}),ST_Point(#{maxx}, #{maxy})), #{srid}))');

 
INSERT INTO system.query("name", sql)
 VALUES ('dynamic.informationtool.get_zones', 
 'select su.id, su.label, st_asewkb(su.reference_point) as the_geom from cadastre.spatial_unit su, cadastre.level l where su.level_id = l.id and l."name" = ''Zones''  and ST_Intersects(su.reference_point, ST_SetSRID(ST_GeomFromWKB(#{wkb_geom}), #{srid}))');

--

DELETE FROM system.config_map_layer WHERE "name" = 'zones';
INSERT INTO system.config_map_layer(name, title, type_code, active, visible_in_start, item_order, style, pojo_structure, pojo_query_name, added_from_bulk_operation)
    VALUES ('zones', 'Zones', 'pojo', TRUE, TRUE, 40, 'zone.xml', 'theGeom:Polygon,label:""', 'SpatialResult.getZones', FALSE);

-- Configure the query fields for the Object Information Tool
INSERT INTO system.query_field(query_name, index_in_query, "name", display_value) 
 VALUES ('dynamic.informationtool.get_zones', 0, 'id', null); 

INSERT INTO system.query_field(query_name, index_in_query, "name", display_value) 
 VALUES ('dynamic.informationtool.get_zones', 1, 'label', 'Zone'); 

INSERT INTO system.query_field(query_name, index_in_query, "name", display_value) 
 VALUES ('dynamic.informationtool.get_zones', 2, 'the_geom', null); 

 
 -- Configure the new Navigation Layer
DELETE FROM system.config_map_layer WHERE "name" = 'zones';

INSERT INTO system.config_map_layer ("name", title, type_code, pojo_query_name, pojo_structure, pojo_query_name_for_select, style, active, item_order, visible_in_start)
 VALUES ('zones', 'Zones', 'pojo', 'SpatialResult.getZones', 'theGeom:Polygon,label:""', 
  'dynamic.informationtool.get_zones', 'zone.xml', TRUE, 50, TRUE);
 

-- Setup Spatial Config for Lesotho
-- CLEAR CADASTRE DATABASE TABLES
DELETE FROM cadastre.spatial_value_area;
DELETE FROM cadastre.spatial_unit;
DELETE FROM cadastre.spatial_unit_historic;
DELETE FROM cadastre.level;
DELETE FROM cadastre.cadastre_object;
DELETE FROM cadastre.cadastre_object_historic;

--SET NEW SRID and OTHER LESOTHO PARAMETERS
UPDATE public.geometry_columns SET srid = 22287; 
UPDATE application.application set location = null;
UPDATE system.setting SET vl = '22287' WHERE "name" = 'map-srid'; 
UPDATE system.setting SET vl = '10000' WHERE "name" = 'map-west'; 
UPDATE system.setting SET vl = '-3400000' WHERE "name" = 'map-south'; 
UPDATE system.setting SET vl = '210000' WHERE "name" = 'map-east'; 
UPDATE system.setting SET vl = '-3150000' WHERE "name" = 'map-north'; 

-- Reset the SRID check constraints
ALTER TABLE cadastre.spatial_unit DROP CONSTRAINT IF EXISTS enforce_srid_geom;
ALTER TABLE cadastre.spatial_unit ADD CONSTRAINT enforce_srid_geom CHECK (st_srid(geom) = 22287);
ALTER TABLE cadastre.spatial_unit_historic DROP CONSTRAINT IF EXISTS enforce_srid_geom;
ALTER TABLE cadastre.spatial_unit_historic ADD CONSTRAINT enforce_srid_geom CHECK (st_srid(geom) = 22287);

ALTER TABLE cadastre.spatial_unit DROP CONSTRAINT IF EXISTS enforce_srid_reference_point;
ALTER TABLE cadastre.spatial_unit ADD CONSTRAINT enforce_srid_reference_point CHECK (st_srid(reference_point) = 22287);
ALTER TABLE cadastre.spatial_unit_historic DROP CONSTRAINT IF EXISTS enforce_srid_reference_point;
ALTER TABLE cadastre.spatial_unit_historic ADD CONSTRAINT enforce_srid_reference_point CHECK (st_srid(reference_point) = 22287);

ALTER TABLE cadastre.cadastre_object DROP CONSTRAINT IF EXISTS enforce_srid_geom_polygon;
ALTER TABLE cadastre.cadastre_object ADD CONSTRAINT enforce_srid_geom_polygon CHECK (st_srid(geom_polygon) = 22287);
ALTER TABLE cadastre.cadastre_object_historic DROP CONSTRAINT IF EXISTS enforce_srid_geom_polygon;
ALTER TABLE cadastre.cadastre_object_historic ADD CONSTRAINT enforce_srid_geom_polygon CHECK (st_srid(geom_polygon) = 22287);

ALTER TABLE cadastre.cadastre_object_target DROP CONSTRAINT IF EXISTS enforce_srid_geom_polygon;
ALTER TABLE cadastre.cadastre_object_target ADD CONSTRAINT enforce_srid_geom_polygon CHECK (st_srid(geom_polygon) = 22287);
ALTER TABLE cadastre.cadastre_object_target_historic DROP CONSTRAINT IF EXISTS enforce_srid_geom_polygon;
ALTER TABLE cadastre.cadastre_object_target_historic ADD CONSTRAINT enforce_srid_geom_polygon CHECK (st_srid(geom_polygon) = 22287);

ALTER TABLE cadastre.cadastre_object_node_target DROP CONSTRAINT IF EXISTS enforce_srid_geom;
ALTER TABLE cadastre.cadastre_object_node_target ADD CONSTRAINT enforce_srid_geom CHECK (st_srid(geom) = 22287);
ALTER TABLE cadastre.cadastre_object_node_target_historic DROP CONSTRAINT IF EXISTS enforce_srid_geom;
ALTER TABLE cadastre.cadastre_object_node_target_historic ADD CONSTRAINT enforce_srid_geom CHECK (st_srid(geom) = 22287);

ALTER TABLE application.application DROP CONSTRAINT IF EXISTS enforce_srid_location;
ALTER TABLE application.application ADD CONSTRAINT enforce_srid_location CHECK (st_srid(location) = 22287);
ALTER TABLE application.application_historic DROP CONSTRAINT IF EXISTS enforce_srid_location;
ALTER TABLE application.application_historic ADD CONSTRAINT enforce_srid_location CHECK (st_srid(location) = 22287);

ALTER TABLE cadastre.survey_point DROP CONSTRAINT IF EXISTS enforce_srid_geom;
ALTER TABLE cadastre.survey_point ADD CONSTRAINT enforce_srid_geom CHECK (st_srid(geom) = 22287);
ALTER TABLE cadastre.survey_point_historic DROP CONSTRAINT IF EXISTS enforce_srid_geom;
ALTER TABLE cadastre.survey_point_historic ADD CONSTRAINT enforce_srid_geom CHECK (st_srid(geom) = 22287);

ALTER TABLE cadastre.survey_point DROP CONSTRAINT IF EXISTS enforce_srid_original_geom;
ALTER TABLE cadastre.survey_point ADD CONSTRAINT enforce_srid_original_geom CHECK (st_srid(original_geom) = 22287);
ALTER TABLE cadastre.survey_point_historic DROP CONSTRAINT IF EXISTS enforce_srid_original_geom;
ALTER TABLE cadastre.survey_point_historic ADD CONSTRAINT enforce_srid_original_geom CHECK (st_srid(original_geom) = 22287);

ALTER TABLE bulk_operation.spatial_unit_temporary DROP CONSTRAINT IF EXISTS enforce_srid_geom;
ALTER TABLE bulk_operation.spatial_unit_temporary ADD CONSTRAINT enforce_srid_geom CHECK (st_srid(geom) = 22287);

-- Configure the Level data for Lesotho
-- add levels
INSERT INTO cadastre.level (id, name, register_type_code, structure_code, type_code, change_user)
	VALUES (uuid_generate_v1(), 'Zones', 'all', 'polygon', 'mixed', 'test');
INSERT INTO cadastre.level (id, name, register_type_code, structure_code, type_code, change_user)
	VALUES (uuid_generate_v1(), 'Roads', 'all', 'unStructuredLine', 'network', 'test');
INSERT INTO cadastre.level (id, name, register_type_code, structure_code, type_code, change_user)
	VALUES (uuid_generate_v1(), 'Parcels', 'all', 'polygon', 'primaryRight', 'test');
			
-- Create Views for each layer. Note that these views are not used by the application, but can be used
-- from AtlasStyler to assist with layer styling. 
-- Remove views that are not relevant to Lesotho
--DROP VIEW IF EXISTS cadastre.place_name;
