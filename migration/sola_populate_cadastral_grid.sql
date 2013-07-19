ALTER TABLE interim_data."1to2500 Survey Grid Drawing_CombinedAreas" DROP COLUMN IF EXISTS grid_number;
ALTER TABLE interim_data."1to2500 Survey Grid Drawing_CombinedAreas" ADD COLUMN grid_number character varying(6);
update interim_data."1to2500 Survey Grid Drawing_CombinedAreas" set grid_number=right('0' || cpindexnum,5);
--select * from interim_data."1to2500 Survey Grid Drawing_CombinedAreas";

DELETE FROM cadastre.spatial_unit AS su WHERE su.level_id= (select cl.id from cadastre.level as cl WHERE cl.name='Grids');
delete from cadastre.level cascade  where name='Grids';
INSERT INTO cadastre.level(id, name, register_type_code, structure_code, type_code, change_user)
    VALUES (uuid_generate_v1(), 'Grids', 'all', 'polygon', 'mixed', 'test');


INSERT INTO cadastre.spatial_unit (id, dimension_code, label, surface_relation_code, geom, level_id, change_user) 
	SELECT uuid_generate_v1(), '2D', grid_number, 'onSurface', ST_SetSRID(the_geom,22287) as the_geom, (SELECT id FROM cadastre.level WHERE name='Grids') As l_id, 'test' AS ch_user 
	FROM interim_data."1to2500 Survey Grid Drawing_CombinedAreas" 
	WHERE (ST_GeometryN(the_geom, 1) IS NOT NULL);
	

-- Layers must be configured in lesotho_spatial_config.sql and nowhere else!
--delete from system.config_map_layer where name='grid';
--delete from system.query where name='SpatialResult.getGrids';
--delete from system.query where name='dynamic.informationtool.get_grids';
	
--insert into system.query (name,sql) values('SpatialResult.getGrids','select su.id, su.label,  st_asewkb(su.geom) as the_geom from cadastre.spatial_unit su, cadastre.level l where su.level_id = l.id and l."name" = ''Grids'' ');
--insert into system.query (name,sql) values('dynamic.informationtool.get_grids','select su.id, su.label, st_asewkb(su.geom) as the_geom from cadastre.spatial_unit su, cadastre.level l where su.level_id = l.id and l."name" = ''Grids'' and ST_Intersects(su.geom, ST_SetSRID(ST_GeomFromWKB(#{wkb_geom}), #{srid}))');

--delete from system.query_field where query_name='dynamic.informationtool.get_grids';
--delete from system.config_map_layer where name='grid';
--insert into system.query_field (query_name, index_in_query,name) values('dynamic.informationtool.get_grids', 0, 'id');
--insert into system.query_field (query_name, index_in_query,name,display_value) values('dynamic.informationtool.get_grids', 1, 'label', 'Grid Number');
--insert into system.query_field (query_name, index_in_query,name) values('dynamic.informationtool.get_grids', 2, 'the_geom');
--insert into system.config_map_layer(name, title, type_code, active, visible_in_start, item_order, style, pojo_structure, pojo_query_name, pojo_query_name_for_select) values('grid', 'Grids::::Particelle', 'pojo', true, true, 20, 'parcel.xml', 'theGeom:Polygon,label:""', 'SpatialResult.getGrids', 'dynamic.informationtool.get_grids');