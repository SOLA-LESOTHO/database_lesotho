
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

    FOR rec IN EXECUTE 'SELECT id, plotnumber AS appellatio, partplotnu AS last_part, plotnumber, areai AS area, 
        ST_SetSRID(ST_GeometryN(the_geom, 1),22287) AS the_geom, partplotnu AS parcel_int,  ''current'' AS parcel_status FROM interim_data."DST27 DEFAULT _Areas plus Maseru Default" WHERE (ST_GeometryN(the_geom, 1) IS NOT NULL) and st_isvalid(the_geom)=TRUE'
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
			
			INSERT INTO cadastre.cadastre_object (id, transaction_id, name_firstpart, name_lastpart, geom_polygon, status_code, change_user)
				VALUES (rec.id, transaction_id_vl, first_part, last_part, rec.the_geom, rec.parcel_status, 'test');  
		END IF;
	END LOOP;
    RETURN 'ok';
END;
$BODY$
LANGUAGE plpgsql;



delete from cadastre.spatial_unit AS su WHERE su.level_id= (select cl.id from cadastre.level as cl WHERE cl.name='Parcels');
 --delete from cadastre.spatial_unit;

 INSERT INTO cadastre.spatial_unit (id, dimension_code, label, surface_relation_code, level_id, change_user) 
	SELECT id, '2D', plotnumber, 'onSurface',  
	(SELECT id FROM cadastre.level WHERE name='Parcels') As l_id, 'test' AS ch_user
	FROM interim_data."DST27 DEFAULT _Areas plus Maseru Default" WHERE ST_GeometryN(the_geom, 1) IS NOT NULL;

DELETE FROM cadastre.cadastre_object;
SELECT test_etl2.load_parcel();

UPDATE cadastre.spatial_unit SET level_id = (SELECT id FROM cadastre.level WHERE name = 'Parcels') 
			WHERE (level_id IS NULL);

	
	
--INSERT INTO cadastre.spatial_value_area (spatial_unit_id, type_code, size, change_user)
	--SELECT 	id, 'officialArea', areai, 'test' AS ch_user FROM interim_data."DST27 DEFAULT _Areas plus Maseru Default";
	
DELETE FROM cadastre.spatial_value_area;

INSERT INTO cadastre.spatial_value_area (spatial_unit_id, type_code, size, change_user)
	SELECT 	co.id, 'officialArea', st_area(co.geom_polygon), 'test' AS ch_user FROM cadastre.cadastre_object as co, cadastre.spatial_unit as su where co.id=su.id;

	

INSERT INTO cadastre.spatial_value_area (spatial_unit_id, type_code, size, change_user)
	SELECT 	co.id, 'calculatedArea', st_area(co.geom_polygon), 'test' AS ch_user FROM cadastre.cadastre_object as co, cadastre.spatial_unit as su where co.id=su.id;

DROP SCHEMA IF EXISTS test_etl2 CASCADE;