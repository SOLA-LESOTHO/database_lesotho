
---Change SRID dependent constraints to NZTM projection srid = 22287


ALTER TABLE cadastre.spatial_unit DROP CONSTRAINT IF EXISTS enforce_srid_geom;
ALTER TABLE cadastre.spatial_unit DROP CONSTRAINT IF EXISTS enforce_srid_reference_point;
ALTER TABLE cadastre.spatial_unit ADD CONSTRAINT enforce_srid_geom CHECK (st_srid(geom) = 22287);
--ALTER TABLE cadastre.spatial_unit ADD CONSTRAINT enforce_srid_reference_point CHECK (st_srid(reference_point) = 22287);
ALTER TABLE cadastre.cadastre_object DROP CONSTRAINT IF EXISTS enforce_srid_geom_polygon;
ALTER TABLE cadastre.cadastre_object DROP CONSTRAINT IF EXISTS enforce_valid_geom_polygon;
--ALTER TABLE cadastre.cadastre_object ADD CONSTRAINT enforce_srid_geom_polygon CHECK (st_srid(geom_polygon) = 22287);
ALTER TABLE cadastre.cadastre_object_historic DROP CONSTRAINT IF EXISTS enforce_srid_geom_polygon;
ALTER TABLE cadastre.cadastre_object_historic DROP CONSTRAINT IF EXISTS enforce_valid_geom_polygon;
ALTER TABLE cadastre.spatial_value_area DROP CONSTRAINT IF EXISTS spatial_value_area_spatial_unit_id_fk83;
ALTER TABLE administrative.ba_unit DROP CONSTRAINT IF EXISTS ba_unit_cadastre_object_id_fk41;

---Disable triggers on cadastre object
ALTER TABLE cadastre.cadastre_object DISABLE TRIGGER ALL;
---------------------------------------------------------


DROP SCHEMA IF EXISTS test_etl2 CASCADE;
CREATE SCHEMA test_etl2;

CREATE OR REPLACE FUNCTION test_etl2.load_parcel() RETURNS varchar
 AS
$BODY$
DECLARE 
    rec record;
    first_part varchar;
    last_part varchar;
    transaction_id_vl varchar;
BEGIN
    transaction_id_vl = 'cadastre-transaction';
    delete from transaction.transaction where id = transaction_id_vl;
    insert into transaction.transaction(id, status_code, approval_datetime, change_user) values(transaction_id_vl, 'approved', now(), 'test-id');

	----Load 22289 Lesotho parcels---LO29
	
	FOR rec IN EXECUTE 'SELECT id, plotnumber, 
			ST_SetSRID(ST_GeometryN(the_geom, 1),22289) AS the_geom,  ''current'' AS parcel_status FROM interim_data."LO29 DEFAULT_Areas" WHERE (ST_GeometryN(the_geom, 1) IS NOT NULL) and st_isvalid(the_geom)=TRUE and length(plotnumber)>0'
		LOOP
		
                        first_part = left(rec.plotnumber,position('-' in rec.plotnumber)-1);
			            last_part = right(rec.plotnumber,length(trim(rec.plotnumber))-position('-' in rec.plotnumber));
	               

			DELETE FROM cadastre.cadastre_object where name_firstpart=first_part and name_lastpart=last_part;
			
			INSERT INTO cadastre.cadastre_object (id, transaction_id, name_firstpart, name_lastpart, geom_polygon, status_code, change_user, rowversion)
				VALUES (rec.id, transaction_id_vl, first_part, last_part, rec.the_geom, rec.parcel_status, 'test', 1);  
		
		END LOOP;
		FOR rec IN EXECUTE 'SELECT id, plotnumber, 
			ST_SetSRID(ST_GeometryN(the_geom, 1),22289) AS the_geom,  ''current'' AS parcel_status FROM interim_data."NewPlots_Lo29" WHERE (ST_GeometryN(the_geom, 1) IS NOT NULL) and st_isvalid(the_geom)=TRUE and length(plotnumber)>0'
		LOOP
		
                        first_part = left(rec.plotnumber,position('-' in rec.plotnumber)-1);
			            last_part = right(rec.plotnumber,length(trim(rec.plotnumber))-position('-' in rec.plotnumber));
	               

			DELETE FROM cadastre.cadastre_object where name_firstpart=first_part and name_lastpart=last_part;
			
			INSERT INTO cadastre.cadastre_object (id, transaction_id, name_firstpart, name_lastpart, geom_polygon, status_code, change_user, rowversion)
				VALUES (rec.id, transaction_id_vl, first_part, last_part, rec.the_geom, rec.parcel_status, 'test', 1);  
		
		END LOOP;
		FOR rec IN EXECUTE 'SELECT uuid_generate_v1() as id, plotnumber, 
			ST_SetSRID(the_geom,22289) AS the_geom,  ''current'' AS parcel_status FROM interim_data.regis_data_lo29 WHERE ck_plot is null and st_isvalid(the_geom)=TRUE and length(plotnumber)>0'
		LOOP
		
                        first_part = left(rec.plotnumber,position('-' in rec.plotnumber)-1);
			            last_part = right(rec.plotnumber,length(trim(rec.plotnumber))-position('-' in rec.plotnumber));
	               

			DELETE FROM cadastre.cadastre_object where name_firstpart=first_part and name_lastpart=last_part;
			
			INSERT INTO cadastre.cadastre_object (id, transaction_id, name_firstpart, name_lastpart, geom_polygon, status_code, change_user, rowversion)
				VALUES (rec.id, transaction_id_vl, first_part, last_part, rec.the_geom, rec.parcel_status, 'test', 1);  
		
		END LOOP;

 ----Load 22287 Lesotho parcels---LO27
 
	
		
	FOR rec IN EXECUTE 'SELECT id, plotnumber, 
			ST_SetSRID(ST_GeometryN(the_geom, 1),22287) AS the_geom,  ''current'' AS parcel_status FROM interim_data."NewPlots" WHERE (ST_GeometryN(the_geom, 1) IS NOT NULL) and st_isvalid(the_geom)=TRUE and length(plotnumber)>0'
		LOOP
		
                        first_part = left(rec.plotnumber,position('-' in rec.plotnumber)-1);
			            last_part = right(rec.plotnumber,length(trim(rec.plotnumber))-position('-' in rec.plotnumber));
	               

			DELETE FROM cadastre.cadastre_object where name_firstpart=first_part and name_lastpart=last_part;
			
			INSERT INTO cadastre.cadastre_object (id, transaction_id, name_firstpart, name_lastpart, geom_polygon, status_code, change_user, rowversion)
				VALUES (rec.id, transaction_id_vl, first_part, last_part, rec.the_geom, rec.parcel_status, 'test', 1);  
		
	END LOOP;
	FOR rec IN EXECUTE 'SELECT uuid_generate_v1() as id, plotnumber, 
			ST_SetSRID(the_geom,22287) AS the_geom,  ''current'' AS parcel_status FROM interim_data.regis_data WHERE ck_plot is null and st_isvalid(the_geom)=TRUE and length(plotnumber)>0'
		LOOP
		
                        first_part = left(rec.plotnumber,position('-' in rec.plotnumber)-1);
			            last_part = right(rec.plotnumber,length(trim(rec.plotnumber))-position('-' in rec.plotnumber));
	               

			DELETE FROM cadastre.cadastre_object where name_firstpart=first_part and name_lastpart=last_part;
			
			INSERT INTO cadastre.cadastre_object (id, transaction_id, name_firstpart, name_lastpart, geom_polygon, status_code, change_user, rowversion)
				VALUES (rec.id, transaction_id_vl, first_part, last_part, rec.the_geom, rec.parcel_status, 'test', 1);  
		
	END LOOP;
	
	FOR rec IN EXECUTE 'SELECT id, plotnumber AS appellatio, partplotnu AS last_part, plotnumber, 
		ST_SetSRID(ST_GeometryN(the_geom, 1),22287) AS the_geom, partplotnu AS parcel_int,  ''current'' AS parcel_status FROM interim_data."DST27 DEFAULT _Areas plus Maseru Default" WHERE (ST_GeometryN(the_geom, 1) IS NOT NULL) and st_isvalid(the_geom)=TRUE and length(plotnumber)>0'
		LOOP
		IF rec.parcel_int not in ('Hydro', 'Road') THEN
			IF POSITION(rec.last_part in rec.appellatio) > 0 THEN
				first_part = TRIM(SUBSTRING(rec.appellatio FROM 1 FOR CHAR_LENGTH(rec.appellatio) - (CHAR_LENGTH(rec.last_part) + 1)));
			ELSE
				first_part = rec.appellatio;
			END IF;
			IF first_part IS NULL THEN
			   first_part = 'QCcheck';
			END IF;
                        first_part = SUBSTRING(first_part FROM 1 FOR 20);
			IF rec.last_part IS NULL THEN 
				last_part = rec.id;
				
                         ELSE
                               last_part = SUBSTRING(rec.last_part FROM 1 FOR 39);
	               END IF;

			DELETE FROM cadastre.cadastre_object where name_firstpart=first_part and name_lastpart=last_part;
			
			INSERT INTO cadastre.cadastre_object (id, transaction_id, name_firstpart, name_lastpart, geom_polygon, status_code, change_user, rowversion)
				VALUES (rec.id, transaction_id_vl, first_part, last_part, rec.the_geom, rec.parcel_status, 'test', 1);  
		END IF;
		END LOOP;

		
    RETURN 'ok';
END;
$BODY$
LANGUAGE plpgsql;



delete from cadastre.spatial_unit AS su WHERE su.level_id= (select cl.id from cadastre.level as cl WHERE cl.name='Parcels');


 INSERT INTO cadastre.spatial_unit (id, dimension_code, label, surface_relation_code, level_id, change_user) 
	SELECT id, '2D', plotnumber, 'onSurface',  
	(SELECT id FROM cadastre.level WHERE name='Parcels') As l_id, 'test' AS ch_user
	FROM interim_data."DST27 DEFAULT _Areas plus Maseru Default" WHERE ST_GeometryN(the_geom, 1) IS NOT NULL and st_isvalid(the_geom)=TRUE and length(plotnumber)>0;

INSERT INTO cadastre.spatial_unit (id, dimension_code, label, surface_relation_code, level_id, change_user) 
	SELECT id, '2D', plotnumber, 'onSurface',  
	(SELECT id FROM cadastre.level WHERE name='Parcels') As l_id, 'test' AS ch_user
	FROM interim_data."NewPlots" WHERE ST_GeometryN(the_geom, 1) IS NOT NULL and st_isvalid(the_geom)=TRUE and length(plotnumber)>0;


INSERT INTO cadastre.spatial_unit (id, dimension_code, label, surface_relation_code, level_id, change_user) 
	SELECT id, '2D', plotnumber, 'onSurface',  
	(SELECT id FROM cadastre.level WHERE name='Parcels') As l_id, 'test' AS ch_user
	FROM interim_data."NewPlots_Lo29" WHERE ST_GeometryN(the_geom, 1) IS NOT NULL and st_isvalid(the_geom)=TRUE and length(plotnumber)>0;
	

INSERT INTO cadastre.spatial_unit (id, dimension_code, label, surface_relation_code, level_id, change_user) 
	SELECT id, '2D', plotnumber, 'onSurface',  
	(SELECT id FROM cadastre.level WHERE name='Parcels') As l_id, 'test' AS ch_user
	FROM interim_data."LO29 DEFAULT_Areas" WHERE ST_GeometryN(the_geom, 1) IS NOT NULL and st_isvalid(the_geom)=TRUE and length(plotnumber)>0;
	
INSERT INTO cadastre.spatial_unit (id, dimension_code, label, surface_relation_code, level_id, change_user) 
	SELECT uuid_generate_v1(), '2D', plotnumber, 'onSurface',  
	(SELECT id FROM cadastre.level WHERE name='Parcels') As l_id, 'test' AS ch_user
	FROM interim_data.regis_data where ck_plot is null;
	
INSERT INTO cadastre.spatial_unit (id, dimension_code, label, surface_relation_code, level_id, change_user) 
	SELECT uuid_generate_v1(), '2D', plotnumber, 'onSurface',  
	(SELECT id FROM cadastre.level WHERE name='Parcels') As l_id, 'test' AS ch_user
	FROM interim_data.regis_data_lo29 where ck_plot is null;

DELETE FROM cadastre.cadastre_object;

---------Indicate the plot already existing in other shapefiles

UPDATE interim_data.regis_data_lo29
		SET ck_plot='Y'
		FROM interim_data."NewPlots_Lo29"
	WHERE "NewPlots_Lo29".plotnumber = regis_data_lo29.plotnumber;
UPDATE interim_data.regis_data_lo29
		SET ck_plot='Y'
		FROM interim_data."LO29 DEFAULT_Areas"
	WHERE "LO29 DEFAULT_Areas".plotnumber = regis_data_lo29.plotnumber;
UPDATE interim_data.regis_data
		SET ck_plot='Y'
		FROM interim_data."NewPlots"
	WHERE "NewPlots".plotnumber = regis_data.plotnumber;
UPDATE interim_data.regis_data
		SET ck_plot='Y'
		FROM interim_data."DST27 DEFAULT _Areas plus Maseru Default"
	WHERE "DST27 DEFAULT _Areas plus Maseru Default".plotnumber = regis_data.plotnumber;
	
---------------------------------------------------------------------------------------------
	
SELECT test_etl2.load_parcel();

UPDATE cadastre.spatial_unit SET level_id = (SELECT id FROM cadastre.level WHERE name = 'Parcels') 
			WHERE (level_id IS NULL);

	
	
DELETE FROM cadastre.spatial_value_area;

INSERT INTO cadastre.spatial_value_area (spatial_unit_id, type_code, size, change_user)
	SELECT 	co.id, 'officialArea', st_area(co.geom_polygon), 'test' AS ch_user FROM cadastre.cadastre_object as co, cadastre.spatial_unit as su where co.id=su.id;

	

INSERT INTO cadastre.spatial_value_area (spatial_unit_id, type_code, size, change_user)
	SELECT 	co.id, 'calculatedArea', st_area(co.geom_polygon), 'test' AS ch_user FROM cadastre.cadastre_object as co, cadastre.spatial_unit as su where co.id=su.id;

UPDATE administrative.ba_unit 
		SET cadastre_object_id=cadastre_object.id
		FROM cadastre.cadastre_object
	WHERE ba_unit.name = trim(cadastre_object.name_firstpart) 
	|| '-' || trim(cadastre_object.name_lastpart);
	
---Enable triggers on cadastre object
ALTER TABLE cadastre.cadastre_object ENABLE TRIGGER ALL;
--------------------------------------------------------

DROP SCHEMA IF EXISTS test_etl2 CASCADE;