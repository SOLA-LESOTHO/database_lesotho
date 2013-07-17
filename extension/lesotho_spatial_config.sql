--Hold original values for srid 22287 in a new row with srid = 40000
INSERT INTO public.spatial_ref_sys(srid, auth_name, auth_srid, srtext, proj4text)
	SELECT 40000, auth_name, 40000, srtext, proj4text FROM spatial_ref_sys WHERE srid = 22287
	AND NOT EXISTS (SELECT srid FROM public.spatial_ref_sys WHERE srid = 40000); 

--Hold original values for srid 22289 in a new row with srid = 40001	
INSERT INTO public.spatial_ref_sys(srid, auth_name, auth_srid, srtext, proj4text)
	SELECT 40001, auth_name, 40001, srtext, proj4text FROM spatial_ref_sys WHERE srid = 22289
	AND NOT EXISTS (SELECT srid FROM public.spatial_ref_sys WHERE srid = 40001); 

-- Change the projection name for Lo27 from Transverse_Mercator_South_Orientated to Transverse Mercator (South Orientated).
-- This change is required for GeoTools 
UPDATE public.spatial_ref_sys set srtext = 
	'PROJCS["Cape / Lo27",GEOGCS["Cape",DATUM["Cape",SPHEROID["Clarke 1880 (Arc)",6378249.145,293.4663077,AUTHORITY["EPSG","7013"]],TOWGS84[-136,-108,-292,0,0,0,0],AUTHORITY["EPSG","6222"]],PRIMEM["Greenwich",0,AUTHORITY["EPSG","8901"]],UNIT["degree",0.0174532925199433,AUTHORITY["EPSG","9122"]],AUTHORITY["EPSG","4222"]],UNIT["metre",1,AUTHORITY["EPSG","9001"]],PROJECTION["Transverse Mercator (South Orientated)"],PARAMETER["latitude_of_origin",0],PARAMETER["central_meridian",27],PARAMETER["scale_factor",1],PARAMETER["false_easting",0],PARAMETER["false_northing",0],AUTHORITY["EPSG","22287"],AXIS["Y",WEST],AXIS["X",SOUTH]]'
 WHERE srid = 22287;  
UPDATE public.spatial_ref_sys set proj4text = 
	'+proj=tmerc +lat_0=0 +lon_0=27 +k=1 +x_0=0 +y_0=0 +axis=wsu +a=6378249.145 +b=6356514.966398753 +towgs84=-136,-108,-292,0,0,0,0 +units=m +no_defs'
 WHERE srid = 22287;
	
	
-- Change the projection name for Lo29 from Transverse_Mercator_South_Orientated to Transverse Mercator (South Orientated).
-- This change is required for GeoTools  
UPDATE public.spatial_ref_sys set srtext = 
	'PROJCS["Cape / Lo29",GEOGCS["Cape",DATUM["Cape",SPHEROID["Clarke 1880 (Arc)",6378249.145,293.4663077,AUTHORITY["EPSG","7013"]],TOWGS84[-136,-108,-292,0,0,0,0],AUTHORITY["EPSG","6222"]],PRIMEM["Greenwich",0,AUTHORITY["EPSG","8901"]],UNIT["degree",0.0174532925199433,AUTHORITY["EPSG","9122"]],AUTHORITY["EPSG","4222"]],UNIT["metre",1,AUTHORITY["EPSG","9001"]],PROJECTION["Transverse Mercator (South Orientated)"],PARAMETER["latitude_of_origin",0],PARAMETER["central_meridian",29],PARAMETER["scale_factor",1],PARAMETER["false_easting",0],PARAMETER["false_northing",0],AUTHORITY["EPSG","22289"],AXIS["Y",WEST],AXIS["X",SOUTH]]'
WHERE srid = 22289; 

UPDATE public.spatial_ref_sys set proj4text = 
	'+proj=tmerc +lat_0=0 +lon_0=29 +k=1 +x_0=0 +y_0=0 +axis=wsu +a=6378249.145 +b=6356514.966398753 +towgs84=-136,-108,-292,0,0,0,0 +units=m +no_defs'
WHERE srid = 22289;
----- Existing Layer Updates ----

-- Disable / hide Generic SOLA layers that are not used by LAA
UPDATE system.config_map_layer
SET visible_in_start = FALSE,
	active = FALSE
WHERE "name" IN ('orthophoto', 'applications', 'place-names', 'survey-controls', 'public-display-parcels', 'public-display-parcels-next');

-- Update Generic SOLA layers so they are not visible by default
UPDATE system.config_map_layer
SET visible_in_start = FALSE
WHERE "name" IN ('parcel-nodes', 'parcels-historic-current-ba', 'pending-parcels', 'roads');

UPDATE system.config_map_layer
SET style = 'parcel.xml', 
    item_order = 25,
    title = 'Plots'
WHERE "name" = 'parcels';

UPDATE system.config_map_layer
SET item_order = 35,
    title = 'Historic plots with registered leases'
WHERE "name" = 'parcels-historic-current-ba';

UPDATE system.config_map_layer
SET item_order = 40,
    title = 'Pending plots'
WHERE "name" = 'pending-parcels';

UPDATE system.config_map_layer
SET pojo_structure = 'theGeom:LineString,label:""',
    item_order = 45
WHERE "name" = 'roads'; 

UPDATE system.config_map_layer
SET item_order = 50,
    title = 'Plot nodes'
WHERE "name" = 'parcel-nodes';


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
--UPDATE system.setting SET vl = '22287' WHERE "name" = 'map-srid'; 
DELETE FROM system.setting WHERE "name" = 'map-srid'; -- Not used by SOLA any more due to multi-srid change
UPDATE system.setting SET vl = '39120' WHERE "name" = 'map-west'; 
UPDATE system.setting SET vl = '-3240450' WHERE "name" = 'map-south'; 
UPDATE system.setting SET vl = '66855' WHERE "name" = 'map-east'; 
UPDATE system.setting SET vl = '-3254891' WHERE "name" = 'map-north'; 

-- Add the necessary dynamic queries
DELETE FROM system.config_map_layer WHERE "name" = 'zones';
delete from system.query where name='SpatialResult.getZones';
delete from system.query where name='dynamic.informationtool.get_zones';
DELETE FROM system.config_map_layer WHERE "name" = 'grids';
delete from system.query where name='SpatialResult.getGrids';
delete from system.query where name='dynamic.informationtool.get_grids';
DELETE FROM system.config_map_layer WHERE "name" = 'srids';
delete from system.query where name='SpatialResult.getSridZones';

INSERT INTO system.query("name", sql)
 VALUES ('SpatialResult.getZones', 
 'select su.id, su.label,  st_asewkb(st_transform(su.geom, #{srid})) as the_geom from cadastre.spatial_unit su, cadastre.level l where su.level_id = l.id and l."name" = ''Zones'' and ST_Intersects(st_transform(su.geom, #{srid}), ST_SetSRID(ST_MakeBox3D(ST_Point(#{minx}, #{miny}),ST_Point(#{maxx}, #{maxy})), #{srid}))');

 INSERT INTO system.query("name", sql)
 VALUES ('SpatialResult.getGrids', 
 'select su.id, su.label,  st_asewkb(st_transform(su.geom, #{srid})) as the_geom from cadastre.spatial_unit su, cadastre.level l where su.level_id = l.id and l."name" = ''Grids'' ');
 
 -- Creates the two SRID zones for Lesotho using Long/Lat coordinates
INSERT INTO system.query("name", sql)
 VALUES ('SpatialResult.getSridZones',
'SELECT ''1'' as id, ''Cape / Lo27'' AS label, st_asewkb(st_transform(st_PolyFromText(''POLYGON((26.0 28.0, 26.0 31.0, 28.0 31.0, 28.0 28.0, 26.0 28.0))'', 4326), #{srid})) AS the_geom
UNION
SELECT ''2'' as id, ''Cape / Lo29'' AS label, st_asewkb(st_transform(st_PolyFromText(''POLYGON((26.0 28.0, 26.0 31.0, 24.0 31.0, 24.0 28.0, 26.0 28.0))'', 4326), #{srid})) AS the_geom');  
 
INSERT INTO system.query("name", sql)
 VALUES ('dynamic.informationtool.get_zones', 
 'select su.id, su.label, st_asewkb(st_transform(su.geom, #{srid})) as the_geom from cadastre.spatial_unit su, cadastre.level l where su.level_id = l.id and l."name" = ''Zones''  and ST_Intersects(st_transform(su.geom, #{srid}), ST_SetSRID(ST_GeomFromWKB(#{wkb_geom}), #{srid}))');

 INSERT INTO system.query("name", sql)
 VALUES ('dynamic.informationtool.get_grids', 
 'select su.id, su.label, st_asewkb(st_transform(su.geom, #{srid})) as the_geom from cadastre.spatial_unit su, cadastre.level l where su.level_id = l.id and l."name" = ''Grids''  and ST_Intersects(st_transform(su.geom, #{srid}), ST_SetSRID(ST_GeomFromWKB(#{wkb_geom}), #{srid}))');

 
--Insert information tool data for get_zones
delete from system.query_field where query_name='dynamic.informationtool.get_zones';
INSERT INTO system.query_field (query_name, index_in_query, name, display_value) VALUES ('dynamic.informationtool.get_zones', 0, 'id', NULL);
INSERT INTO system.query_field (query_name, index_in_query, name, display_value) VALUES ('dynamic.informationtool.get_zones', 1, 'label', 'Name::::Nome');
INSERT INTO system.query_field (query_name, index_in_query, name, display_value) VALUES ('dynamic.informationtool.get_zones', 2, 'the_geom', NULL); 
 
delete from system.query_field where query_name='dynamic.informationtool.get_grids';
INSERT INTO system.query_field (query_name, index_in_query, name, display_value) VALUES ('dynamic.informationtool.get_grids', 0, 'id', NULL);
INSERT INTO system.query_field (query_name, index_in_query, name, display_value) VALUES ('dynamic.informationtool.get_grids', 1, 'label', 'Name::::Nome');
INSERT INTO system.query_field (query_name, index_in_query, name, display_value) VALUES ('dynamic.informationtool.get_grids', 2, 'the_geom', NULL); 
--Add new static layers called ls_orthophoto and zones

delete from system.config_map_layer where name='ls_orthophoto';

INSERT INTO system.config_map_layer ("name", title, type_code, active, visible_in_start, item_order, url, wms_layers, wms_version, wms_format) 
VALUES ('ls_orthophoto', 'LS Orthophoto', 'wms', TRUE, FALSE, 5, 'http://localhost:8085/geoserver/sola/wms', 'sola:ls_orthophoto', '1.1.1', 'image/tiff');

INSERT INTO system.config_map_layer ("name", title, type_code, pojo_query_name, pojo_structure, pojo_query_name_for_select, style, active, item_order, visible_in_start)
 VALUES ('zones', 'Zones', 'pojo', 'SpatialResult.getZones', 'theGeom:Polygon,label:""', 
  'dynamic.informationtool.get_zones', 'zone.xml', TRUE, 10, FALSE);

INSERT INTO system.config_map_layer ("name", title, type_code, pojo_query_name, pojo_structure, pojo_query_name_for_select, style, active, item_order, visible_in_start)
 VALUES ('grid', 'Grids::::Particelle', 'pojo', 'SpatialResult.getGrids', 'theGeom:Polygon,label:""','dynamic.informationtool.get_grids', 'grid.xml', TRUE, 20, TRUE);

INSERT INTO system.config_map_layer ("name", title, type_code, pojo_query_name, pojo_structure, pojo_query_name_for_select, style, active, item_order, visible_in_start)
 VALUES ('srids', 'Coordinate systems', 'pojo', 'SpatialResult.getSridZones', 'theGeom:Polygon,label:""', 
  NULL, 'srid_zone.xml', TRUE, 15, TRUE);


-- Reset the SRID check constraints
ALTER TABLE cadastre.spatial_unit DROP CONSTRAINT IF EXISTS enforce_srid_geom;
ALTER TABLE cadastre.spatial_unit ADD CONSTRAINT enforce_srid_geom CHECK (st_srid(geom) IN (22287, 22289));
ALTER TABLE cadastre.spatial_unit_historic DROP CONSTRAINT IF EXISTS enforce_srid_geom;
ALTER TABLE cadastre.spatial_unit_historic ADD CONSTRAINT enforce_srid_geom CHECK (st_srid(geom) IN (22287, 22289));

ALTER TABLE cadastre.spatial_unit DROP CONSTRAINT IF EXISTS enforce_srid_reference_point;
ALTER TABLE cadastre.spatial_unit ADD CONSTRAINT enforce_srid_reference_point CHECK (st_srid(reference_point) IN (22287, 22289));
ALTER TABLE cadastre.spatial_unit_historic DROP CONSTRAINT IF EXISTS enforce_srid_reference_point;
ALTER TABLE cadastre.spatial_unit_historic ADD CONSTRAINT enforce_srid_reference_point CHECK (st_srid(reference_point) IN (22287, 22289));

ALTER TABLE cadastre.cadastre_object DROP CONSTRAINT IF EXISTS enforce_srid_geom_polygon;
ALTER TABLE cadastre.cadastre_object ADD CONSTRAINT enforce_srid_geom_polygon CHECK (st_srid(geom_polygon) IN (22287, 22289));
ALTER TABLE cadastre.cadastre_object_historic DROP CONSTRAINT IF EXISTS enforce_srid_geom_polygon;
ALTER TABLE cadastre.cadastre_object_historic ADD CONSTRAINT enforce_srid_geom_polygon CHECK (st_srid(geom_polygon) IN (22287, 22289));

ALTER TABLE cadastre.cadastre_object_target DROP CONSTRAINT IF EXISTS enforce_srid_geom_polygon;
ALTER TABLE cadastre.cadastre_object_target ADD CONSTRAINT enforce_srid_geom_polygon CHECK (st_srid(geom_polygon) IN (22287, 22289));
ALTER TABLE cadastre.cadastre_object_target_historic DROP CONSTRAINT IF EXISTS enforce_srid_geom_polygon;
ALTER TABLE cadastre.cadastre_object_target_historic ADD CONSTRAINT enforce_srid_geom_polygon CHECK (st_srid(geom_polygon) IN (22287, 22289));

ALTER TABLE cadastre.cadastre_object_node_target DROP CONSTRAINT IF EXISTS enforce_srid_geom;
ALTER TABLE cadastre.cadastre_object_node_target ADD CONSTRAINT enforce_srid_geom CHECK (st_srid(geom) IN (22287, 22289));
ALTER TABLE cadastre.cadastre_object_node_target_historic DROP CONSTRAINT IF EXISTS enforce_srid_geom;
ALTER TABLE cadastre.cadastre_object_node_target_historic ADD CONSTRAINT enforce_srid_geom CHECK (st_srid(geom) IN (22287, 22289));

ALTER TABLE application.application DROP CONSTRAINT IF EXISTS enforce_srid_location;
ALTER TABLE application.application ADD CONSTRAINT enforce_srid_location CHECK (st_srid(location) IN (22287, 22289));
ALTER TABLE application.application_historic DROP CONSTRAINT IF EXISTS enforce_srid_location;
ALTER TABLE application.application_historic ADD CONSTRAINT enforce_srid_location CHECK (st_srid(location) IN (22287, 22289));

ALTER TABLE cadastre.survey_point DROP CONSTRAINT IF EXISTS enforce_srid_geom;
ALTER TABLE cadastre.survey_point ADD CONSTRAINT enforce_srid_geom CHECK (st_srid(geom) IN (22287, 22289));
ALTER TABLE cadastre.survey_point_historic DROP CONSTRAINT IF EXISTS enforce_srid_geom;
ALTER TABLE cadastre.survey_point_historic ADD CONSTRAINT enforce_srid_geom CHECK (st_srid(geom) IN (22287, 22289));

ALTER TABLE cadastre.survey_point DROP CONSTRAINT IF EXISTS enforce_srid_original_geom;
ALTER TABLE cadastre.survey_point ADD CONSTRAINT enforce_srid_original_geom CHECK (st_srid(original_geom) IN (22287, 22289));
ALTER TABLE cadastre.survey_point_historic DROP CONSTRAINT IF EXISTS enforce_srid_original_geom;
ALTER TABLE cadastre.survey_point_historic ADD CONSTRAINT enforce_srid_original_geom CHECK (st_srid(original_geom) IN (22287, 22289));

ALTER TABLE bulk_operation.spatial_unit_temporary DROP CONSTRAINT IF EXISTS enforce_srid_geom;
ALTER TABLE bulk_operation.spatial_unit_temporary ADD CONSTRAINT enforce_srid_geom CHECK (st_srid(geom) IN (22287, 22289));

-- Data for the table cadastre.level -- 
INSERT INTO cadastre.level (id, name, register_type_code, structure_code, type_code, change_user)
  VALUES (uuid_generate_v1(), 'Grids', 'all', 'polygon', 'mixed', 'test');
INSERT INTO cadastre.level (id, name, register_type_code, structure_code, type_code, change_user)
  VALUES (uuid_generate_v1(), 'Zones', 'all', 'polygon', 'mixed', 'test');
INSERT INTO cadastre.level (id, name, register_type_code, structure_code, type_code, change_user)
	VALUES (uuid_generate_v1(), 'Roads', 'all', 'unStructuredLine', 'network', 'test');
INSERT INTO cadastre.level (id, name, register_type_code, structure_code, type_code, change_user)
	VALUES (uuid_generate_v1(), 'Parcels', 'all', 'polygon', 'primaryRight', 'test');
INSERT INTO cadastre.level (id, name, register_type_code, structure_code, type_code, change_user)
	VALUES ('cadastreObject', 'Cadastre object', 'all', 'polygon', 'primaryRight', 'db:postgres');

-----------




-- *** Add support for multiple SRIDs
--Table system.crs ----
DROP TABLE IF EXISTS system.crs CASCADE;
CREATE TABLE system.crs(
    srid integer NOT NULL,
    from_long double precision,
    to_long double precision,
	item_order integer NOT NULL,

    -- Internal constraints   
    CONSTRAINT crs_pkey PRIMARY KEY (srid)
);
comment on table system.crs is 'In this table are given the coordinate reference systems (crs) that are applicable to the application.
The one that is with the smallest item_order will be in the top of the list. Also the extent given in setting is within the context of this crs.
from_long - to_long define the area in wgs84 that the crs is valid. This range can be used for different purposes like assigning/transforming a geometry before being stored in the database in the desired crs.';
    
 -- Data for the table system.crs -- 
insert into system.crs(srid, from_long, to_long, item_order) values(22287, 26.0, 28.0, 1);
insert into system.crs(srid, from_long, to_long, item_order) values(22289, 24.0, 26.0, 2);

-- Function public.get_geometry_with_srid --
-- SRID on new geometries is now set in the Client, so this function can simply return the geometry passed in. 
CREATE OR REPLACE FUNCTION public.get_geometry_with_srid(
 geom geometry
) RETURNS geometry 
AS $$
declare
begin
  return geom; 
end;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION public.get_geometry_with_srid(
 geom geometry
) IS 'This function assigns a srid found in the settings to the geometry passed as parameter. The srid is chosen based in the longitude where the centroid of the geometry is.';

-- Customise the cadastre.cadastre_object_name_is_valid function
CREATE OR REPLACE FUNCTION cadastre.cadastre_object_name_is_valid(name_firstpart character varying, name_lastpart character varying)
  RETURNS boolean AS
$BODY$
begin
  if name_firstpart is null then return false; end if;
  if name_lastpart is null then return false; end if;
  -- check the namefirspart is a number or number-number
  if not (name_firstpart similar to '[0-9]+' or name_firstpart similar to '[0-9]+\-[0-9]+') then return false;  end if;
  -- check name_lastpart is just number
  if name_lastpart not similar to '[0-9 ]+' then return false;  end if;
  return true;
end;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION cadastre.cadastre_object_name_is_valid(character varying, character varying)
  OWNER TO postgres;
  
  
-- Function bulk_operation.move_other_objects --
CREATE OR REPLACE FUNCTION bulk_operation.move_other_objects(
 transaction_id_v varchar
  , change_user_v varchar
) RETURNS void 
AS $$
declare
  other_object_type varchar;
  level_id_v varchar;
  geometry_type varchar;
  query_name_v varchar;
  query_sql_template varchar;
begin
  query_sql_template = 'select id, label, st_asewkb(st_transform(geom, #{srid})) as the_geom from cadastre.spatial_unit 
where level_id = ''level_id_v'' and ST_Intersects(st_transform(geom, #{srid}), ST_SetSRID(ST_MakeBox3D(ST_Point(#{minx}, #{miny}),ST_Point(#{maxx}, #{maxy})), #{srid}))';
  other_object_type = (select type_code 
    from bulk_operation.spatial_unit_temporary 
    where transaction_id = transaction_id_v limit 1);
  geometry_type = (select st_geometrytype(geom) 
    from bulk_operation.spatial_unit_temporary 
    where transaction_id = transaction_id_v limit 1);
  geometry_type = lower(substring(geometry_type from 4));
  if (select count(*) from cadastre.structure_type where code = geometry_type) = 0 then
    insert into cadastre.structure_type(code, display_value, status)
    values(geometry_type, geometry_type, 'c');
  end if;
  level_id_v = (select id from cadastre.level where name = other_object_type or id = lower(other_object_type));
  if level_id_v is null then
    level_id_v = lower(other_object_type);
    insert into cadastre.level(id, type_code, name, structure_code) 
    values(level_id_v, 'geographicLocator', other_object_type, geometry_type);
    if (select count(*) from system.config_map_layer where name = level_id_v) = 0 then
      -- A map layer is added here. For the symbology an sld file already predefined in gis component must be used.
      -- The sld file must be named after the geometry type + the word generic. 
      query_name_v = 'SpatialResult.get' || level_id_v;
      if (select count(*) from system.query where name = query_name_v) = 0 then
        -- A query is added here
        insert into system.query(name, sql) values(query_name_v, replace(query_sql_template, 'level_id_v', level_id_v));
      end if;
      insert into system.config_map_layer(name, title, type_code, active, visible_in_start, item_order, style, pojo_structure, pojo_query_name, added_from_bulk_operation) 
      values(level_id_v, other_object_type, 'pojo', true, true, 1, 'generic-' || geometry_type || '.xml', 'theGeom:Polygon,label:""', query_name_v, true);
    end if;
  end if;
  insert into cadastre.spatial_unit(id, label, level_id, geom, transaction_id, change_user)
  select id, label, level_id_v, geom, transaction_id, change_user_v
  from bulk_operation.spatial_unit_temporary where transaction_id = transaction_id_v;
  update transaction.transaction set status_code = 'approved', change_user = change_user_v where id = transaction_id_v;
  delete from bulk_operation.spatial_unit_temporary where transaction_id = transaction_id_v;
end;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION bulk_operation.move_other_objects(
 transaction_id_v varchar
  , change_user_v varchar
) IS 'This function is used to move other kinds of spatial objects except the cadastre objects. <br/>
The function will add a new level if need together with a new structure type if it is not found.';



-- Update the spatial queries to transform the geometry objects
UPDATE  system.query SET sql = 'select id, label, st_asewkb(st_transform(geom, #{srid})) as the_geom from cadastre.place_name where ST_Intersects(st_transform(geom, #{srid}), ST_SetSRID(ST_MakeBox3D(ST_Point(#{minx}, #{miny}),ST_Point(#{maxx}, #{maxy})), #{srid}))'
WHERE name = 'SpatialResult.getPlaceNames';

UPDATE system.query SET sql = 'select id, label, st_asewkb(st_transform(geom, #{srid})) as the_geom from cadastre.survey_control  where ST_Intersects(st_transform(geom, #{srid}), ST_SetSRID(ST_MakeBox3D(ST_Point(#{minx}, #{miny}),ST_Point(#{maxx}, #{maxy})), #{srid}))'
WHERE name = 'SpatialResult.getSurveyControls'; 
 
UPDATE system.query SET sql = 'select co.id, co.name_firstpart || ''-'' || co.name_lastpart as label,  st_asewkb(st_transform(co.geom_polygon, #{srid})) as the_geom from cadastre.cadastre_object co where type_code= ''parcel'' and status_code= ''current'' and ST_Intersects(st_transform(co.geom_polygon, #{srid}), ST_SetSRID(ST_MakeBox3D(ST_Point(#{minx}, #{miny}),ST_Point(#{maxx}, #{maxy})), #{srid}))'
WHERE name = 'SpatialResult.getParcels'; 

UPDATE system.query SET sql = 'select co.id, co.name_firstpart || ''-'' || co.name_lastpart as label,  st_asewkb(st_transform(co.geom_polygon, #{srid})) as the_geom  from cadastre.cadastre_object co  where type_code IN (''parcel'', ''subplot'') and status_code= ''pending''   and ST_Intersects(st_transform(co.geom_polygon, #{srid}), ST_SetSRID(ST_MakeBox3D(ST_Point(#{minx}, #{miny}),ST_Point(#{maxx}, #{maxy})), #{srid})) union select co.id, co.name_firstpart || ''-'' || co.name_lastpart as label,  st_asewkb(co_t.geom_polygon) as the_geom  from cadastre.cadastre_object co inner join cadastre.cadastre_object_target co_t on co.id = co_t.cadastre_object_id and co_t.geom_polygon is not null where ST_Intersects(co_t.geom_polygon, ST_SetSRID(ST_MakeBox3D(ST_Point(#{minx}, #{miny}),ST_Point(#{maxx}, #{maxy})), #{srid}))       and co_t.transaction_id in (select id from transaction.transaction where status_code not in (''approved'')) '
WHERE name = 'SpatialResult.getParcelsPending'; 

UPDATE system.query SET sql = 'select id, label, st_asewkb(st_transform(geom, #{srid})) as the_geom from cadastre.road where ST_Intersects(st_transform(geom, #{srid}), ST_SetSRID(ST_MakeBox3D(ST_Point(#{minx}, #{miny}),ST_Point(#{maxx}, #{maxy})), #{srid}))'
WHERE name = 'SpatialResult.getRoads';

UPDATE system.query SET sql = 'select id, nr as label, st_asewkb(st_transform(location, #{srid})) as the_geom from application.application where ST_Intersects(st_transform(location, #{srid}), ST_SetSRID(ST_MakeBox3D(ST_Point(#{minx}, #{miny}),ST_Point(#{maxx}, #{maxy})), #{srid}))'
WHERE name ='SpatialResult.getApplications';

UPDATE system.query SET sql = 'select co.id, co.name_firstpart || ''-'' || co.name_lastpart as parcel_nr,      (select string_agg(ba.name_firstpart || ''-'' || ba.name_lastpart, '','')      from administrative.ba_unit_contains_spatial_unit bas, administrative.ba_unit ba      where spatial_unit_id= co.id and bas.ba_unit_id= ba.id) as ba_units,      ( SELECT spatial_value_area.size FROM cadastre.spatial_value_area      WHERE spatial_value_area.type_code=''officialArea'' and spatial_value_area.spatial_unit_id = co.id) AS area_official_sqm,       st_asewkb(st_transform(co.geom_polygon, #{srid})) as the_geom      from cadastre.cadastre_object co      where type_code= ''parcel'' and status_code= ''current''      and ST_Intersects(st_transform(co.geom_polygon, #{srid}), ST_SetSRID(ST_GeomFromWKB(#{wkb_geom}), #{srid}))'
WHERE name = 'dynamic.informationtool.get_parcel';

UPDATE system.query SET sql = 'select co.id, co.name_firstpart || ''-'' || co.name_lastpart as parcel_nr,       ( SELECT spatial_value_area.size FROM cadastre.spatial_value_area         WHERE spatial_value_area.type_code=''officialArea'' and spatial_value_area.spatial_unit_id = co.id) AS area_official_sqm,   st_asewkb(st_transform(co.geom_polygon, #{srid})) as the_geom    from cadastre.cadastre_object co  where type_code IN (''parcel'', ''subplot'') and ((status_code= ''pending''    and ST_Intersects(st_transform(co.geom_polygon, #{srid}), ST_SetSRID(ST_GeomFromWKB(#{wkb_geom}), #{srid})))   or (co.id in (select cadastre_object_id           from cadastre.cadastre_object_target co_t inner join transaction.transaction t on co_t.transaction_id=t.id           where ST_Intersects(st_transform(co.geom_polygon, #{srid}), ST_SetSRID(ST_GeomFromWKB(#{wkb_geom}), #{srid})) and t.status_code not in (''approved''))))'
WHERE name = 'dynamic.informationtool.get_parcel_pending';

UPDATE system.query SET sql = 'select id, label,  st_asewkb(st_transform(geom, #{srid})) as the_geom from cadastre.place_name where ST_Intersects(st_transform(geom, #{srid}), ST_SetSRID(ST_GeomFromWKB(#{wkb_geom}), #{srid}))'
WHERE name = 'dynamic.informationtool.get_place_name';

UPDATE system.query SET sql = 'select id, label,  st_asewkb(st_transform(geom, #{srid})) as the_geom from cadastre.road where ST_Intersects(st_transform(geom, #{srid}), ST_SetSRID(ST_GeomFromWKB(#{wkb_geom}), #{srid}))'
WHERE name = 'dynamic.informationtool.get_road';

UPDATE system.query SET sql = 'select id, nr,  st_asewkb(st_transform(location, #{srid})) as the_geom from application.application where ST_Intersects(st_transform(location, #{srid}), ST_SetSRID(ST_GeomFromWKB(#{wkb_geom}), #{srid}))'
WHERE name = 'dynamic.informationtool.get_application';
 
UPDATE system.query SET sql = 'select id, label,  st_asewkb(st_transform(geom, #{srid})) as the_geom from cadastre.survey_control where ST_Intersects(st_transform(geom, #{srid}), ST_SetSRID(ST_GeomFromWKB(#{wkb_geom}), #{srid}))'
WHERE name = 'dynamic.informationtool.get_survey_control';

UPDATE system.query SET sql = 'select co.id, co.name_firstpart || ''-'' || co.name_lastpart as label,  st_asewkb(st_transform(co.geom_polygon, #{srid})) as the_geom from cadastre.cadastre_object co inner join administrative.ba_unit_contains_spatial_unit ba_co on co.id = ba_co.spatial_unit_id   inner join administrative.ba_unit ba_unit on ba_unit.id= ba_co.ba_unit_id where co.type_code=''parcel'' and co.status_code= ''historic'' and ba_unit.status_code = ''current'' and ST_Intersects(st_transform(co.geom_polygon, #{srid}), ST_SetSRID(ST_MakeBox3D(ST_Point(#{minx}, #{miny}),ST_Point(#{maxx}, #{maxy})), #{srid}))'
WHERE name = 'SpatialResult.getParcelsHistoricWithCurrentBA';

UPDATE system.query SET sql = 'select co.id, co.name_firstpart || ''-'' || co.name_lastpart as parcel_nr,         (select string_agg(ba.name_firstpart || ''-'' || ba.name_lastpart, '','')           from administrative.ba_unit_contains_spatial_unit bas, administrative.ba_unit ba           where spatial_unit_id= co.id and bas.ba_unit_id= ba.id) as ba_units,         (SELECT spatial_value_area.size      FROM cadastre.spatial_value_area           WHERE spatial_value_area.type_code=''officialArea'' and spatial_value_area.spatial_unit_id = co.id) AS area_official_sqm,         st_asewkb(st_transform(co.geom_polygon, #{srid})) as the_geom        from cadastre.cadastre_object co inner join administrative.ba_unit_contains_spatial_unit ba_co on co.id = ba_co.spatial_unit_id   inner join administrative.ba_unit ba_unit on ba_unit.id= ba_co.ba_unit_id where co.type_code=''parcel'' and co.status_code= ''historic'' and ba_unit.status_code = ''current''       and ST_Intersects(st_transform(co.geom_polygon, #{srid}), ST_SetSRID(ST_GeomFromWKB(#{wkb_geom}), #{srid}))'
WHERE name = 'dynamic.informationtool.get_parcel_historic_current_ba';

UPDATE system.query SET sql = 'select id, name_firstpart || ''- '' || name_lastpart as label, st_asewkb(st_transform(geom_polygon, #{srid})) as the_geom  from cadastre.cadastre_object  where status_code= ''current'' and compare_strings(#{search_string}, name_firstpart || '' '' || name_lastpart) limit 30'
WHERE name = 'map_search.cadastre_object_by_number';

UPDATE system.query SET sql = 'select distinct co.id,  ba_unit.name_firstpart || ''- '' || ba_unit.name_lastpart || '' > '' || co.name_firstpart || ''- '' || co.name_lastpart as label,  st_asewkb(st_transform(geom_polygon, #{srid})) as the_geom from cadastre.cadastre_object  co    inner join administrative.ba_unit_contains_spatial_unit bas on co.id = bas.spatial_unit_id     inner join administrative.ba_unit on ba_unit.id = bas.ba_unit_id  where (co.status_code= ''current'' or ba_unit.status_code= ''current'')    and compare_strings(#{search_string}, ba_unit.name_firstpart || '' '' || ba_unit.name_lastpart) limit 30'
WHERE name = 'map_search.cadastre_object_by_baunit';

UPDATE system.query SET sql = 'select distinct co.id,  coalesce(party.name, '''') || '' '' || coalesce(party.last_name, '''') || '' > '' || co.name_firstpart || ''- '' || co.name_lastpart as label,  st_asewkb(st_transform(co.geom_polygon, #{srid})) as the_geom  from cadastre.cadastre_object  co     inner join administrative.ba_unit_contains_spatial_unit bas on co.id = bas.spatial_unit_id     inner join administrative.ba_unit on bas.ba_unit_id= ba_unit.id     inner join administrative.rrr on (ba_unit.id = rrr.ba_unit_id and rrr.status_code = ''current'' and rrr.type_code = ''ownership'')     inner join administrative.party_for_rrr pfr on rrr.id = pfr.rrr_id     inner join party.party on pfr.party_id= party.id where (co.status_code= ''current'' or ba_unit.status_code= ''current'')     and compare_strings(#{search_string}, coalesce(party.name, '''') || '' '' || coalesce(party.last_name, '''')) limit 30'
WHERE name = 'map_search.cadastre_object_by_baunit_owner';

UPDATE system.query SET sql = 'SELECT id,  name_firstpart || ''-'' || name_lastpart as label, st_asewkb(st_transform(geom_polygon, #{srid})) as the_geom  FROM cadastre.cadastre_object WHERE transaction_id IN (  SELECT cot.transaction_id FROM (administrative.ba_unit_contains_spatial_unit ba_su     INNER JOIN cadastre.cadastre_object co ON ba_su.spatial_unit_id = co.id)     INNER JOIN cadastre.cadastre_object_target cot ON co.id = cot.cadastre_object_id     WHERE ba_su.ba_unit_id = #{search_string})  AND (SELECT COUNT(1) FROM administrative.ba_unit_contains_spatial_unit WHERE spatial_unit_id = cadastre_object.id) = 0 AND status_code = ''current'''
WHERE name = 'system_search.cadastre_object_by_baunit_id';

UPDATE system.query SET sql = 'select distinct st_astext(st_transform(geom, #{srid})) as id, '''' as label, st_asewkb(st_transform(geom, #{srid})) as the_geom from (select (ST_DumpPoints(geom_polygon)).* from cadastre.cadastre_object co  where type_code= ''parcel'' and status_code= ''current''  and ST_Intersects(st_transform(co.geom_polygon, #{srid}), ST_SetSRID(ST_MakeBox3D(ST_Point(#{minx}, #{miny}),ST_Point(#{maxx}, #{maxy})), #{srid}))) tmp_table '
WHERE name = 'SpatialResult.getParcelNodes';

UPDATE system.query SET sql = 'select co.id, co.name_firstpart as label,  st_asewkb(st_transform(co.geom_polygon, #{srid})) as the_geom from cadastre.cadastre_object co where type_code= ''parcel'' and status_code= ''current'' and name_lastpart = #{name_lastpart} and ST_Intersects(st_transform(co.geom_polygon, #{srid}), ST_SetSRID(ST_MakeBox3D(ST_Point(#{minx}, #{miny}),ST_Point(#{maxx}, #{maxy})), #{srid}))'
WHERE name = 'public_display.parcels';

UPDATE system.query SET sql =  'SELECT co_next.id, co_next.name_firstpart as label,  st_asewkb(st_transform(co_next.geom_polygon, #{srid})) as the_geom  from cadastre.cadastre_object co_next, cadastre.cadastre_object co where co.type_code= ''parcel'' and co.status_code= ''current'' and co_next.type_code= ''parcel'' and co_next.status_code= ''current'' and co.name_lastpart = #{name_lastpart} and co_next.name_lastpart != #{name_lastpart} and st_dwithin(st_transform(co.geom_polygon, #{srid}), st_transform(co_next.geom_polygon, #{srid}), 5) and ST_Intersects(st_transform(co_next.geom_polygon, #{srid}), ST_SetSRID(ST_MakeBox3D(ST_Point(#{minx}, #{miny}),ST_Point(#{maxx}, #{maxy})), #{srid}))'
WHERE name = 'public_display.parcels_next';


-- *** Add support so that subplots can be created through Cadastre Change services
INSERT INTO cadastre.cadastre_object_type(
            code, display_value, description, status, in_topology)
 SELECT 'subplot', 'Subplot', NULL, 'c', FALSE 
 WHERE NOT EXISTS (SELECT code FROM cadastre.cadastre_object_type WHERE code = 'subplot');
	
INSERT INTO cadastre.level (id, name, register_type_code, structure_code, type_code, change_user)
   SELECT uuid_generate_v1(), 'Subplots', 'all', 'polygon', 'primaryRight', 'test'
   WHERE NOT EXISTS (SELECT id FROM cadastre.level WHERE name = 'Subplots');

DELETE FROM system.config_map_layer WHERE "name" = 'subplots';
delete from system.query where name='SpatialResult.getSubplots';
delete from system.query_field where query_name='dynamic.informationtool.get_subplot';
delete from system.query where name='dynamic.informationtool.get_subplot';

INSERT INTO system.query ("name", sql) 
VALUES ('SpatialResult.getSubplots', 'select co.id, co.name_firstpart || ''-'' || co.name_lastpart as label,  st_asewkb(st_transform(co.geom_polygon, #{srid})) as the_geom from cadastre.cadastre_object co where type_code= ''subplot'' and status_code = ''current'' and ST_Intersects(st_transform(co.geom_polygon, #{srid}), ST_SetSRID(ST_MakeBox3D(ST_Point(#{minx}, #{miny}),ST_Point(#{maxx}, #{maxy})), #{srid}))
UNION select co.id, co.name_firstpart || ''-'' || co.name_lastpart as label,  st_asewkb(st_transform(co.geom_polygon, #{srid})) as the_geom from cadastre.cadastre_object co, administrative.rrr r where co.type_code= ''parcel'' and co.status_code = ''current'' and r.cadastre_object_id = co.id and r.type_code = ''subLease'' and r.status_code = ''current'' and ST_Intersects(st_transform(co.geom_polygon, #{srid}), ST_SetSRID(ST_MakeBox3D(ST_Point(#{minx}, #{miny}),ST_Point(#{maxx}, #{maxy})), #{srid}))'); 

INSERT INTO system.query ("name", sql) 
VALUES ('dynamic.informationtool.get_subplot', 'select co.id, co.name_firstpart || ''-'' || co.name_lastpart as parcel_nr,      (select string_agg(ba.name_firstpart || ''-'' || ba.name_lastpart, '','')      from administrative.rrr r, administrative.ba_unit ba where r.cadastre_object_id= co.id and r.ba_unit_id= ba.id) as ba_units,      ( SELECT spatial_value_area.size FROM cadastre.spatial_value_area      WHERE spatial_value_area.type_code=''officialArea'' and spatial_value_area.spatial_unit_id = co.id) AS area_official_sqm,       st_asewkb(st_transform(co.geom_polygon, #{srid})) as the_geom      from cadastre.cadastre_object co      where type_code= ''subplot'' and status_code= ''current''      and ST_Intersects(st_transform(co.geom_polygon, #{srid}), ST_SetSRID(ST_GeomFromWKB(#{wkb_geom}), #{srid}))
UNION select co.id, co.name_firstpart || ''-'' || co.name_lastpart as parcel_nr,      (select string_agg(ba.name_firstpart || ''-'' || ba.name_lastpart, '','')      from administrative.rrr r, administrative.ba_unit ba where r.cadastre_object_id= co.id and r.ba_unit_id= ba.id) as ba_units,      ( SELECT spatial_value_area.size FROM cadastre.spatial_value_area      WHERE spatial_value_area.type_code=''officialArea'' and spatial_value_area.spatial_unit_id = co.id) AS area_official_sqm,       st_asewkb(st_transform(co.geom_polygon, #{srid})) as the_geom      from cadastre.cadastre_object co      where type_code= ''subplot'' and status_code= ''current''  and exists (SELECT id FROM administrative.rrr WHERE cadastre_object_id = co.id)    and ST_Intersects(st_transform(co.geom_polygon, #{srid}), ST_SetSRID(ST_GeomFromWKB(#{wkb_geom}), #{srid}))');

INSERT INTO system.query_field (query_name, index_in_query, name, display_value) VALUES ('dynamic.informationtool.get_subplot', 0, 'id', NULL);
INSERT INTO system.query_field (query_name, index_in_query, name, display_value) VALUES ('dynamic.informationtool.get_subplot', 1, 'parcel_nr', 'Subplot #');
INSERT INTO system.query_field (query_name, index_in_query, name, display_value) VALUES ('dynamic.informationtool.get_subplot', 2, 'ba_units', 'Lease #');
INSERT INTO system.query_field (query_name, index_in_query, name, display_value) VALUES ('dynamic.informationtool.get_subplot', 3, 'area_official_sqm', 'Area (m²)');
INSERT INTO system.query_field (query_name, index_in_query, name, display_value) VALUES ('dynamic.informationtool.get_subplot', 4, 'the_geom', NULL); 

INSERT INTO system.config_map_layer ("name", title, type_code, pojo_query_name, pojo_structure, pojo_query_name_for_select, style, active, item_order, visible_in_start)
 VALUES ('subplots', 'Subplots', 'pojo', 'SpatialResult.getSubplots', 'theGeom:Polygon,label:""', 
 'dynamic.informationtool.get_subplot', 'subplot.xml', TRUE, 30, FALSE);
