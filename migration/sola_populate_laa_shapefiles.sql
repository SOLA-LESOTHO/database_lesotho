﻿--TO POPULATE THE SOLA DATABASE WITH LAA DATA (FROM SHAPEFILES)
--INTO SOLA LESOTHO DATABASE

--remove any existing loaded Spatial Data
--DELETE FROM  source.archive WHERE name ='Land Administration Authority';
--DELETE FROM cadastre.spatial_value_area;
--DELETE FROM cadastre.cadastre_object;
DELETE FROM cadastre.spatial_unit where spatial_unit.level_id = (select level.id from cadastre.level where level.name='Roads');
DELETE FROM cadastre.spatial_unit where spatial_unit.level_id = (select level.id from cadastre.level where level.name='Zones');

--ALTER TABLE cadastre.cadastre_object DROP CONSTRAINT enforce_geotype_geom_polygon ;
--ALTER TABLE cadastre.cadastre_object
--  ADD CONSTRAINT enforce_geotype_geom_polygon CHECK (geometrytype(geom_polygon) = 'POLYGON'::text OR geom_polygon IS NULL);

--INSERT VALUES FOR ZONE POLYGONS
INSERT INTO cadastre.spatial_unit (id, dimension_code, label, surface_relation_code, geom, level_id, change_user) 
	SELECT uuid_generate_v1(), '2D', msuvalzones."type", 'onSurface', ST_SetSRID(ST_GeometryN(the_geom, 1),22287) AS the_geom, (SELECT id FROM cadastre.level WHERE name='Zones') As l_id, 'test' AS ch_user 
	FROM interim_data.msuvalzones WHERE (ST_GeometryN(the_geom, 1) IS NOT NULL);
	
--Hlotse zones

INSERT INTO cadastre.spatial_unit (id, dimension_code, label, surface_relation_code, geom, level_id, change_user) 
	SELECT uuid_generate_v1(), '2D', value_area, 'onSurface', ST_SetSRID(ST_GeometryN(the_geom, 1),22287) AS the_geom, (SELECT id FROM cadastre.level WHERE name='Zones') As l_id, 'test' AS ch_user 
	FROM interim_data."Hlotse_Zones" WHERE (ST_GeometryN(the_geom, 1) IS NOT NULL);

	UPDATE 	cadastre.spatial_unit set label='Residential 2' where label='R 2';
	UPDATE 	cadastre.spatial_unit set label='Residential 3' where label='R 3';
	UPDATE 	cadastre.spatial_unit set label='Residential 4' where label='R 4';
	UPDATE 	cadastre.spatial_unit set label='Commercial 2' where label='C 2';

--INSERT VALUES FOR ROAD CENTRELINES
-- roads Maseru area

INSERT INTO cadastre.spatial_unit (id, dimension_code, label, surface_relation_code, geom, level_id, change_user) 
	SELECT uuid_generate_v1(), '2D', road_type_, 'onSurface', ST_SetSRID(ST_GeometryN(the_geom, 1),22287) AS the_geom, (SELECT id FROM cadastre.level WHERE name='Roads') As l_id, 'test' AS ch_user
	FROM interim_data.msu_roads 
	WHERE (ST_GeometryN(the_geom, 1) IS NOT NULL)
	AND (st_ndims(the_geom) = 2);

	--roads Maputsoe area
	
INSERT INTO cadastre.spatial_unit (id, dimension_code, label, surface_relation_code, geom, level_id, change_user) 
	SELECT uuid_generate_v1(), '2D', road_type, 'onSurface', ST_SetSRID(ST_GeometryN(the_geom, 1),22287) AS the_geom, (SELECT id FROM cadastre.level WHERE name='Roads') As l_id, 'test' AS ch_user
	FROM interim_data."Maputsoe_Rds"
	WHERE (ST_GeometryN(the_geom, 1) IS NOT NULL)
	AND (st_ndims(the_geom) = 2);

	--roads Mafeteng area
	
INSERT INTO cadastre.spatial_unit (id, dimension_code, label, surface_relation_code, geom, level_id, change_user) 
	SELECT uuid_generate_v1(), '2D', road_type, 'onSurface', ST_SetSRID(ST_GeometryN(the_geom, 1),22287) AS the_geom, (SELECT id FROM cadastre.level WHERE name='Roads') As l_id, 'test' AS ch_user
	FROM interim_data."Mafeteng_Rds"
	WHERE (ST_GeometryN(the_geom, 1) IS NOT NULL)
	AND (st_ndims(the_geom) = 2);	
	
--roads Mohale's Hoek area
	
INSERT INTO cadastre.spatial_unit (id, dimension_code, label, surface_relation_code, geom, level_id, change_user) 
	SELECT uuid_generate_v1(), '2D', road_type, 'onSurface', ST_SetSRID(ST_GeometryN(the_geom, 1),22287) AS the_geom, (SELECT id FROM cadastre.level WHERE name='Roads') As l_id, 'test' AS ch_user
	FROM interim_data."Mh_Roads"
	WHERE (ST_GeometryN(the_geom, 1) IS NOT NULL)
	AND (st_ndims(the_geom) = 2);		

--roads Quthing area
	
INSERT INTO cadastre.spatial_unit (id, dimension_code, label, surface_relation_code, geom, level_id, change_user) 
	SELECT uuid_generate_v1(), '2D', road_type, 'onSurface', ST_SetSRID(ST_GeometryN(the_geom, 1),22287) AS the_geom, (SELECT id FROM cadastre.level WHERE name='Roads') As l_id, 'test' AS ch_user
	FROM interim_data."Quthing_Roads"
	WHERE (ST_GeometryN(the_geom, 1) IS NOT NULL)
	AND (st_ndims(the_geom) = 2);	

--roads TY area
	
INSERT INTO cadastre.spatial_unit (id, dimension_code, label, surface_relation_code, geom, level_id, change_user) 
	SELECT uuid_generate_v1(), '2D', road_type, 'onSurface', ST_SetSRID(ST_GeometryN(the_geom, 1),22287) AS the_geom, (SELECT id FROM cadastre.level WHERE name='Roads') As l_id, 'test' AS ch_user
	FROM interim_data."TY_Roads"
	WHERE (ST_GeometryN(the_geom, 1) IS NOT NULL)
	AND (st_ndims(the_geom) = 2);	
	
--roads Butha-Bothe area
	
INSERT INTO cadastre.spatial_unit (id, dimension_code, label, surface_relation_code, geom, level_id, change_user) 
	SELECT uuid_generate_v1(), '2D', road_type, 'onSurface', ST_SetSRID(ST_GeometryN(the_geom, 1),22287) AS the_geom, (SELECT id FROM cadastre.level WHERE name='Roads') As l_id, 'test' AS ch_user
	FROM interim_data."Botha_Bothe_Rds"
	WHERE (ST_GeometryN(the_geom, 1) IS NOT NULL)
	AND (st_ndims(the_geom) = 2);	
	
--roads Hlotse area
	
INSERT INTO cadastre.spatial_unit (id, dimension_code, label, surface_relation_code, geom, level_id, change_user) 
	SELECT uuid_generate_v1(), '2D', road_type, 'onSurface', ST_SetSRID(ST_GeometryN(the_geom, 1),22287) AS the_geom, (SELECT id FROM cadastre.level WHERE name='Roads') As l_id, 'test' AS ch_user
	FROM interim_data."Hlotse_Rds1"
	WHERE (ST_GeometryN(the_geom, 1) IS NOT NULL)
	AND (st_ndims(the_geom) = 2);		

	
--update labels for the roads

UPDATE 	cadastre.spatial_unit set label='Main Tarred Road' where label='Main_Roads_Tarred';
	UPDATE 	cadastre.spatial_unit set label='Secondary Tarred Road' where label='Sec_Roads_Tarred';
	UPDATE 	cadastre.spatial_unit set label='Minor Tarred Road' where label='Minor_Roads_Tarred';
	UPDATE 	cadastre.spatial_unit set label='Main Untarred Road' where label='Main_Roads_Untarred';
	UPDATE 	cadastre.spatial_unit set label='Secondary Untarred Road' where label='Sec_Roads_Untarred';
	UPDATE 	cadastre.spatial_unit set label='Minor Untarred Road' where label='Minor_Roads_Untarred';
	UPDATE 	cadastre.spatial_unit set label='No Vehicular Access' where label='No_Vehicular_Access';
	UPDATE 	cadastre.spatial_unit set label='Minor Untarred Road' where label='Minor_Untarred';
	UPDATE 	cadastre.spatial_unit set label='Main Tarred Road' where label='Main_road';
	UPDATE 	cadastre.spatial_unit set label='Main Tarred Road' where label='Main_Roads';
	UPDATE 	cadastre.spatial_unit set label='Secondary Tarred Road' where label='Sec_Tarred';
	UPDATE 	cadastre.spatial_unit set label='Secondary Untarred Road' where label='Sec_Untarred';


	
--INSERT INTO cadastre.spatial_unit (id, dimension_code, label, surface_relation_code, geom, level_id, change_user) 
--	SELECT uuid_generate_v1(), '2D', 'Highway', 'onSurface', the_geom, (SELECT id FROM cadastre.level WHERE name='Roads') As l_id, 'test' AS ch_user 
--	FROM interim_data.highway_roads 
--	WHERE (ST_GeometryN(the_geom, 1) IS NOT NULL)
--	AND (st_ndims(the_geom) = 2);

--INSERT INTO cadastre.spatial_unit (id, dimension_code, label, surface_relation_code, geom, level_id, change_user) 
--	SELECT uuid_generate_v1(), '2D', 'Major Road', 'onSurface', the_geom, (SELECT id FROM cadastre.level WHERE name='Roads') As l_id, 'test' AS ch_user 
--	FROM interim_data.major_roads 
--	WHERE (ST_GeometryN(the_geom, 1) IS NOT NULL)
--	AND (st_ndims(the_geom) = 2);

--INSERT INTO cadastre.spatial_unit (id, dimension_code, label, surface_relation_code, geom, level_id, change_user) 
--	SELECT uuid_generate_v1(), '2D', 'Railway', 'onSurface', the_geom, (SELECT id FROM cadastre.level WHERE name='Roads') As l_id, 'test' AS ch_user 
--	FROM interim_data.railway WHERE (ST_GeometryN(the_geom, 1) IS NOT NULL)
--	AND (st_ndims(the_geom) = 2);
		
--INSERT VALUES FOR THE EXAMINED PLOTS

--INSERT INTO cadastre.spatial_unit (id, dimension_code, label, surface_relation_code, level_id, change_user) 
--	SELECT DISTINCT ON (plotnumber) gid, '2D', plotnumber, 'onSurface', (SELECT id FROM cadastre.level WHERE name='Parcels') As l_id, 'test' AS ch_user
--	FROM interim_data.examined_plots 
--	WHERE ((ST_GeometryN(the_geom, 1) IS NOT NULL)
--	AND (geometrytype(ST_GeometryN(the_geom, 1)) = 'POLYGON'::text))
--	AND plotnumber IS NOT NULL;

--DELETE FROM transaction.transaction WHERE id = 'cadastre-transaction';
--INSERT INTO transaction.transaction(id, status_code, approval_datetime, change_user) VALUES('cadastre-transaction', 'approved', now(), 'test-id');

--INSERT INTO cadastre.cadastre_object (id, name_firstpart, name_lastpart, transaction_id, status_code, geom_polygon, change_action, change_user, change_time )
--	SELECT DISTINCT ON (plotnumber) gid, TRIM(SUBSTRING(plotnumber FROM 1 FOR POSITION('-' in plotnumber) -1)) AS firstPart,
--	TRIM(SUBSTRING(plotnumber FROM (POSITION('-' in plotnumber) + 1) FOR (LENGTH(plotnumber) - POSITION('-' in plotnumber)))) AS lastpart,
--	'cadastre-transaction', 'current', ST_GeometryN(the_geom, 1), 'i', 'test' AS ch_user, NOW() 
--	FROM interim_data.examined_plots
--	WHERE ((ST_GeometryN(the_geom, 1) IS NOT NULL) 
--	AND (geometrytype(ST_GeometryN(the_geom, 1)) = 'POLYGON'::text))
--	AND plotnumber IS NOT NULL;

--UPDATE cadastre.spatial_unit SET level_id = (SELECT id FROM cadastre.level WHERE name = 'Plots') 
--			WHERE (level_id IS NULL);

-----INSERT INTO cadastre.spatial_value_area (spatial_unit_id, type_code, size, change_user)
-----	SELECT 	DISTINCT ON (plotnumber) gid, 'officialArea', cast(areai AS int), 'test' AS ch_user FROM interim_data.examined_plots WHERE plotnumber IS NOT NULL;

--DELETE FROM source.source WHERE archive_id = 'archive-id';
--DELETE FROM source.archive WHERE id = 'archive-id';
--INSERT INTO source.archive (id, name, change_user) VALUES ('archive-id', 'Land Administration Authority', 'test'); 

--INSERT INTO source.source (id, archive_id, la_nr, submission, maintype, type_code, content, availability_status_code, change_user)
--VALUES (uuid_generate_v1(), 'archive-id', 'Survey Section', '2012-12-03', 'mapDigital', 'cadastralMap', 'Land Administration Authority', 'available', 'test');

