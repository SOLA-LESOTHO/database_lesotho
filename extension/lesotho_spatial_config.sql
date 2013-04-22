--Hold original values for srid 22287 in a new row with srid = 40000
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
SET pojo_structure = 'theGeom:LineString,label:""'
WHERE "name" = 'roads'; 


-- Setup Spatial Config for Lesotho
-- CLEAR CADASTRE DATABASE TABLES
DELETE FROM cadastre.spatial_value_area;
DELETE FROM cadastre.spatial_unit;
DELETE FROM cadastre.spatial_unit_historic;
--DELETE FROM cadastre.level;
DELETE FROM cadastre.cadastre_object;
DELETE FROM cadastre.cadastre_object_historic;

--SET NEW SRID and OTHER LESOTHO PARAMETERS
UPDATE public.geometry_columns SET srid = 22287; 
UPDATE application.application set location = null;
UPDATE system.setting SET vl = '22287' WHERE "name" = 'map-srid'; 
UPDATE system.setting SET vl = '39120' WHERE "name" = 'map-west'; 
UPDATE system.setting SET vl = '-3240450' WHERE "name" = 'map-south'; 
UPDATE system.setting SET vl = '66855' WHERE "name" = 'map-east'; 
UPDATE system.setting SET vl = '-3254891' WHERE "name" = 'map-north'; 

-- Add the necessary dynamic queries
delete from system.query where name='SpatialResult.getZones';
delete from system.query where name='dynamic.informationtool.get_zones';

INSERT INTO system.query("name", sql)
 VALUES ('SpatialResult.getZones', 
 'select su.id, su.label,  st_asewkb(su.geom) as the_geom from cadastre.spatial_unit su, cadastre.level l where su.level_id = l.id and l."name" = ''Zones'' and ST_Intersects(su.geom, ST_SetSRID(ST_MakeBox3D(ST_Point(#{minx}, #{miny}),ST_Point(#{maxx}, #{maxy})), #{srid}))');

 
INSERT INTO system.query("name", sql)
 VALUES ('dynamic.informationtool.get_zones', 
 'select su.id, su.label, st_asewkb(su.geom) as the_geom from cadastre.spatial_unit su, cadastre.level l where su.level_id = l.id and l."name" = ''Zones''  and ST_Intersects(su.geom, ST_SetSRID(ST_GeomFromWKB(#{wkb_geom}), #{srid}))');

--Insert information tool data for get_zones
delete from system.query_field where query_name='dynamic.informationtool.get_zones';
INSERT INTO system.query_field (query_name, index_in_query, name, display_value) VALUES ('dynamic.informationtool.get_zones', 0, 'id', NULL);
INSERT INTO system.query_field (query_name, index_in_query, name, display_value) VALUES ('dynamic.informationtool.get_zones', 1, 'label', 'Name::::Nome');
INSERT INTO system.query_field (query_name, index_in_query, name, display_value) VALUES ('dynamic.informationtool.get_zones', 2, 'the_geom', NULL); 
 
--Add new static layers called ls_orthophoto and zones

delete from system.config_map_layer where name='ls_orthophoto';

INSERT INTO system.config_map_layer VALUES ('ls_orthophoto', 'LS Orthophoto', 'wms', TRUE, TRUE, 1, NULL, 'http://localhost:14922/geoserver/sola/wms', 'sola:ls_orthophoto', '1.1.1', 'image/tiff', NULL, NULL, NULL, NULL, NULL, NULL, FALSE);

DELETE FROM system.config_map_layer WHERE "name" = 'zones';

INSERT INTO system.config_map_layer ("name", title, type_code, pojo_query_name, pojo_structure, pojo_query_name_for_select, style, active, item_order, visible_in_start)
 VALUES ('zones', 'Zones', 'pojo', 'SpatialResult.getZones', 'theGeom:Polygon,label:""', 
  'dynamic.informationtool.get_zones', 'zone.xml', TRUE, 50, TRUE);

--make all roads visible on the roads layer by removing the second condition [st_area(geom)> power(5 * #{pixel_res}, 2)] from sql

UPDATE system.query
   SET sql='select id, label, st_asewkb(geom) as the_geom from cadastre.road 
   where ST_Intersects(geom, ST_SetSRID(ST_MakeBox3D(ST_Point(#{minx}, #{miny}),ST_Point(#{maxx}, #{maxy})), #{srid}))'
 WHERE name='SpatialResult.getRoads';


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
-- add levels**********************
INSERT INTO cadastre.level (id, name, register_type_code, structure_code, type_code, change_user)
  VALUES (uuid_generate_v1(), 'Zones', 'all', 'polygon', 'mixed', 'test');
INSERT INTO cadastre.level (id, name, register_type_code, structure_code, type_code, change_user)
	VALUES (uuid_generate_v1(), 'Roads', 'all', 'unStructuredLine', 'network', 'test');
--INSERT INTO cadastre.level (id, name, register_type_code, structure_code, type_code, change_user)
--	VALUES (uuid_generate_v1(), 'Parcels', 'all', 'polygon', 'primaryRight', 'test');
--INSERT INTO cadastre.level (id, name, register_type_code, structure_code, type_code, change_user)
--	VALUES ('cadastreObject', 'Cadastre object', 'all', 'polygon', 'primaryRight', 'db:postgres');

---*******************************			
-- Create Views for each layer. Note that these views are not used by the application, but can be used
-- from AtlasStyler to assist with layer styling. 
-- Remove views that are not relevant to Lesotho
--DROP VIEW IF EXISTS cadastre.place_name;

-- Elton: This will change the query that is used to retrieve features for the parcels layer.
-- The change from the original query is that it removes the condition of the area. and st_area(co.geom_polygon)> power(5 * #{pixel_res}, 2)
--UPDATE system.query 
--	SET sql = 'select co.id, co.name_firstpart || ''/'' || co.name_lastpart AS label,  st_asewkb(co.geom_polygon) --AS the_geom FROM cadastre.cadastre_object co WHERE type_code= ''parcel'' and status_code= ''current'' 
--	AND ST_Intersects(co.geom_polygon, ST_SetSRID(ST_MakeBox3D(ST_Point(#{minx}, #{miny}),ST_Point(#{maxx}, --#{maxy})), #{srid}))'
--WHERE name = 'SpatialResult.getParcels';
