--
-- Start localisation of parcel numbering for map view --
--

UPDATE system.query
	SET sql =  'select co.id, co.name_firstpart || ''-'' || co.name_lastpart as label,  st_asewkb(co.geom_polygon) as the_geom  from cadastre.cadastre_object co  where type_code= ''parcel'' and status_code= ''pending''   and ST_Intersects(co.geom_polygon, ST_SetSRID(ST_MakeBox3D(ST_Point(#{minx}, #{miny}),ST_Point(#{maxx}, #{maxy})), #{srid})) union select co.id, co.name_firstpart || ''-'' || co.name_lastpart as label,  st_asewkb(co_t.geom_polygon) as the_geom  from cadastre.cadastre_object co inner join cadastre.cadastre_object_target co_t on co.id = co_t.cadastre_object_id and co_t.geom_polygon is not null where ST_Intersects(co_t.geom_polygon, ST_SetSRID(ST_MakeBox3D(ST_Point(#{minx}, #{miny}),ST_Point(#{maxx}, #{maxy})), #{srid}))       and co_t.transaction_id in (select id from transaction.transaction where status_code not in (''approved'')) '
	WHERE name = 'SpatialResult.getParcelsPending'; 
	
UPDATE system.query
	SET sql = 'select id, label, st_asewkb(geom) as the_geom from cadastre.survey_control  where ST_Intersects(geom, ST_SetSRID(ST_MakeBox3D(ST_Point(#{minx}, #{miny}),ST_Point(#{maxx}, #{maxy})), #{srid}))'
	WHERE name = 'SpatialResult.getSurveyControls';
	
UPDATE system.query	
	SET sql = 'select id, label, st_asewkb(geom) as the_geom from cadastre.place_name where ST_Intersects(geom, ST_SetSRID(ST_MakeBox3D(ST_Point(#{minx}, #{miny}),ST_Point(#{maxx}, #{maxy})), #{srid}))'
	WHERE name = 'SpatialResult.getPlaceNames'; 
	
UPDATE system.query 
	SET sql = 'select id, nr as label, st_asewkb(location) as the_geom from application.application where ST_Intersects(location, ST_SetSRID(ST_MakeBox3D(ST_Point(#{minx}, #{miny}),ST_Point(#{maxx}, #{maxy})), #{srid}))'
	WHERE name = 'SpatialResult.getApplications';
	
UPDATE system.query
	SET sql = 'select co.id, co.name_firstpart || ''-'' || co.name_lastpart as parcel_nr,      (select string_agg(ba.name_firstpart || ''-'' || ba.name_lastpart, '','')      from administrative.ba_unit_contains_spatial_unit bas, administrative.ba_unit ba      where spatial_unit_id= co.id and bas.ba_unit_id= ba.id) as ba_units,      ( SELECT spatial_value_area.size FROM cadastre.spatial_value_area      WHERE spatial_value_area.type_code=''officialArea'' and spatial_value_area.spatial_unit_id = co.id) AS area_official_sqm,       st_asewkb(co.geom_polygon) as the_geom      from cadastre.cadastre_object co      where type_code= ''parcel'' and status_code= ''current''      and ST_Intersects(co.geom_polygon, ST_SetSRID(ST_GeomFromWKB(#{wkb_geom}), #{srid}))'
	WHERE name = 'dynamic.informationtool.get_parcel';
	
UPDATE system.query	
	SET sql = 'select co.id, co.name_firstpart || ''-'' || co.name_lastpart as parcel_nr,       ( SELECT spatial_value_area.size FROM cadastre.spatial_value_area         WHERE spatial_value_area.type_code=''officialArea'' and spatial_value_area.spatial_unit_id = co.id) AS area_official_sqm,   st_asewkb(co.geom_polygon) as the_geom    from cadastre.cadastre_object co  where type_code= ''parcel'' and ((status_code= ''pending''    and ST_Intersects(co.geom_polygon, ST_SetSRID(ST_GeomFromWKB(#{wkb_geom}), #{srid})))   or (co.id in (select cadastre_object_id           from cadastre.cadastre_object_target co_t inner join transaction.transaction t on co_t.transaction_id=t.id           where ST_Intersects(co_t.geom_polygon, ST_SetSRID(ST_GeomFromWKB(#{wkb_geom}), #{srid})) and t.status_code not in (''approved''))))'
	WHERE name = 'dynamic.informationtool.get_parcel_pending'; 
	
UPDATE system.query
	SET sql = 'select id, label,  st_asewkb(geom) as the_geom from cadastre.place_name where ST_Intersects(geom, ST_SetSRID(ST_GeomFromWKB(#{wkb_geom}), #{srid}))'
	WHERE name = 'dynamic.informationtool.get_place_name'; 
	
UPDATE system.query
	SET sql = 'select id, label,  st_asewkb(geom) as the_geom from cadastre.road where ST_Intersects(geom, ST_SetSRID(ST_GeomFromWKB(#{wkb_geom}), #{srid}))'
	WHERE name = 'dynamic.informationtool.get_road'; 
	
UPDATE system.query	
	SET sql = 'select id, nr,  st_asewkb(location) as the_geom from application.application where ST_Intersects(location, ST_SetSRID(ST_GeomFromWKB(#{wkb_geom}), #{srid}))'
	WHERE name = 'dynamic.informationtool.get_application'; 
	
UPDATE system.query	 
	SET sql = 'select id, label,  st_asewkb(geom) as the_geom from cadastre.survey_control where ST_Intersects(geom, ST_SetSRID(ST_GeomFromWKB(#{wkb_geom}), #{srid}))'
	WHERE name = 'dynamic.informationtool.get_survey_control';
	
UPDATE system.query	 
	SET sql = 'select co.id, co.name_firstpart || ''-'' || co.name_lastpart as label,  st_asewkb(co.geom_polygon) as the_geom from cadastre.cadastre_object co inner join administrative.ba_unit_contains_spatial_unit ba_co on co.id = ba_co.spatial_unit_id   inner join administrative.ba_unit ba_unit on ba_unit.id= ba_co.ba_unit_id where co.type_code=''parcel'' and co.status_code= ''historic'' and ba_unit.status_code = ''current'' and ST_Intersects(co.geom_polygon, ST_SetSRID(ST_MakeBox3D(ST_Point(#{minx}, #{miny}),ST_Point(#{maxx}, #{maxy})), #{srid}))'
	WHERE name = 'SpatialResult.getParcelsHistoricWithCurrentBA';
	
UPDATE system.query		
	SET sql = 'select co.id, co.name_firstpart || ''-'' || co.name_lastpart as parcel_nr,         (select string_agg(ba.name_firstpart || ''-'' || ba.name_lastpart, '','')           from administrative.ba_unit_contains_spatial_unit bas, administrative.ba_unit ba           where spatial_unit_id= co.id and bas.ba_unit_id= ba.id) as ba_units,         (SELECT spatial_value_area.size      FROM cadastre.spatial_value_area           WHERE spatial_value_area.type_code=''officialArea'' and spatial_value_area.spatial_unit_id = co.id) AS area_official_sqm,         st_asewkb(co.geom_polygon) as the_geom        from cadastre.cadastre_object co inner join administrative.ba_unit_contains_spatial_unit ba_co on co.id = ba_co.spatial_unit_id   inner join administrative.ba_unit ba_unit on ba_unit.id= ba_co.ba_unit_id where co.type_code=''parcel'' and co.status_code= ''historic'' and ba_unit.status_code = ''current''       and ST_Intersects(co.geom_polygon, ST_SetSRID(ST_GeomFromWKB(#{wkb_geom}), #{srid}))'
	WHERE name = 'dynamic.informationtool.get_parcel_historic_current_ba'; 
	
UPDATE system.query		
	SET sql = 'select id, name_firstpart || ''- '' || name_lastpart as label, st_asewkb(geom_polygon) as the_geom  from cadastre.cadastre_object  where status_code= ''current'' and compare_strings(#{search_string}, name_firstpart || '' '' || name_lastpart) limit 30'
	WHERE name = 'map_search.cadastre_object_by_number'; 
	
UPDATE system.query		
	SET sql = 'select distinct co.id,  ba_unit.name_firstpart || ''- '' || ba_unit.name_lastpart || '' > '' || co.name_firstpart || ''- '' || co.name_lastpart as label,  st_asewkb(geom_polygon) as the_geom from cadastre.cadastre_object  co    inner join administrative.ba_unit_contains_spatial_unit bas on co.id = bas.spatial_unit_id     inner join administrative.ba_unit on ba_unit.id = bas.ba_unit_id  where (co.status_code= ''current'' or ba_unit.status_code= ''current'')    and compare_strings(#{search_string}, ba_unit.name_firstpart || '' '' || ba_unit.name_lastpart) limit 30'
	WHERE name = 'map_search.cadastre_object_by_baunit';
	
UPDATE system.query		
	SET sql = 'select co.id, co.name_firstpart || ''-'' || co.name_lastpart AS label,  st_asewkb(co.geom_polygon) AS the_geom FROM cadastre.cadastre_object co WHERE type_code= ''parcel'' and status_code= ''current'' 
	AND ST_Intersects(co.geom_polygon, ST_SetSRID(ST_MakeBox3D(ST_Point(#{minx}, #{miny}),ST_Point(#{maxx}, #{maxy})), #{srid}))'
	WHERE name = 'SpatialResult.getParcels';

UPDATE system.query		
	SET sql = 'select id, label, st_asewkb(geom) as the_geom from cadastre.road where ST_Intersects(geom, ST_SetSRID(ST_MakeBox3D(ST_Point(#{minx}, #{miny}),ST_Point(#{maxx}, #{maxy})), #{srid})) '
	WHERE name = 'SpatialResult.getRoads'; 
	
UPDATE system.query		
	SET sql = 'select distinct co.id,  coalesce(party.name, '''') || '' '' || coalesce(party.last_name, '''') || '' > '' || co.name_firstpart || ''- '' || co.name_lastpart as label,  st_asewkb(co.geom_polygon) as the_geom  from cadastre.cadastre_object  co     inner join administrative.ba_unit_contains_spatial_unit bas on co.id = bas.spatial_unit_id     inner join administrative.ba_unit on bas.ba_unit_id= ba_unit.id     inner join administrative.rrr on (ba_unit.id = rrr.ba_unit_id and rrr.status_code = ''current'' and rrr.type_code = ''ownership'')     inner join administrative.party_for_rrr pfr on rrr.id = pfr.rrr_id     inner join party.party on pfr.party_id= party.id where (co.status_code= ''current'' or ba_unit.status_code= ''current'')     and compare_strings(#{search_string}, coalesce(party.name, '''') || '' '' || coalesce(party.last_name, '''')) limit 30'
	WHERE name = 'map_search.cadastre_object_by_baunit_owner'; 
	
UPDATE system.query		
	SET sql = 'SELECT id,  name_firstpart || ''- '' || name_lastpart as label, st_asewkb(geom_polygon) as the_geom  FROM cadastre.cadastre_object WHERE transaction_id IN (  SELECT cot.transaction_id FROM (administrative.ba_unit_contains_spatial_unit ba_su     INNER JOIN cadastre.cadastre_object co ON ba_su.spatial_unit_id = co.id)     INNER JOIN cadastre.cadastre_object_target cot ON co.id = cot.cadastre_object_id     WHERE ba_su.ba_unit_id = #{search_string})  AND (SELECT COUNT(1) FROM administrative.ba_unit_contains_spatial_unit WHERE spatial_unit_id = cadastre_object.id) = 0 AND status_code = ''current'''
	WHERE name = 'system_search.cadastre_object_by_baunit_id'; 
	
UPDATE system.query	
	SET sql = 'select distinct st_astext(geom) as id, '''' as label, st_asewkb(geom) as the_geom from (select (ST_DumpPoints(geom_polygon)).* from cadastre.cadastre_object co  where type_code= ''parcel'' and status_code= ''current''  and ST_Intersects(co.geom_polygon, ST_SetSRID(ST_MakeBox3D(ST_Point(#{minx}, #{miny}),ST_Point(#{maxx}, #{maxy})), #{srid}))) tmp_table '
	WHERE name = 'SpatialResult.getParcelNodes'; 
	
UPDATE system.query		
	SET sql = 'select su.id, su.label,  st_asewkb(su.geom) as the_geom from cadastre.spatial_unit su, cadastre.level l where su.level_id = l.id and l."name" = ''Zones'' and ST_Intersects(su.geom, ST_SetSRID(ST_MakeBox3D(ST_Point(#{minx}, #{miny}),ST_Point(#{maxx}, #{maxy})), #{srid}))'
	WHERE name = 'SpatialResult.getZones'; 
	
UPDATE system.query 	
	SET sql = 'select su.id, su.label, st_asewkb(su.geom) as the_geom from cadastre.spatial_unit su, cadastre.level l where su.level_id = l.id and l."name" = ''Zones''  and ST_Intersects(su.geom, ST_SetSRID(ST_GeomFromWKB(#{wkb_geom}), #{srid}))'
	WHERE name = 'dynamic.informationtool.get_zones'; 
	
UPDATE system.query		
	SET sql = 'select su.id, su.label,  st_asewkb(su.geom) as the_geom from cadastre.spatial_unit su, cadastre.level l where su.level_id = l.id and l."name" = ''Grids'' '
	WHERE name = 'SpatialResult.getGrids'; 
	
UPDATE system.query		
	SET sql = 'select su.id, su.label, st_asewkb(su.geom) as the_geom from cadastre.spatial_unit su, cadastre.level l where su.level_id = l.id and l."name" = ''Grids'' and ST_Intersects(su.geom, ST_SetSRID(ST_GeomFromWKB(#{wkb_geom}), #{srid}))'
	WHERE name = 'dynamic.informationtool.get_grids';
--

