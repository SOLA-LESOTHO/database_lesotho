drop table if exists interim_data.parcel_zones; 
create table  interim_data.parcel_zones
  (id character varying(40) ,
   plot_number character varying(30),
   parcel_zone character varying(30)
 
  );

CREATE OR REPLACE FUNCTION interim_data.parcel_ground_rent_zones() 
RETURNS varchar
 AS
$BODY$
DECLARE 

    rec record;

BEGIN
    
    FOR rec IN select co.id,co.geom_polygon,su.label from cadastre.cadastre_object co,cadastre.spatial_unit su where co.id=su.id
	LOOP
        insert into interim_data.parcel_zones(id,plot_number,parcel_zone) 
        select rec.id, rec.label,label from cadastre.spatial_unit as SU, cadastre.level l where l.id=su.level_id and l.name='Zones' and ST_contains(st_transform(su.geom,22287),st_transform(st_centroid(rec.geom_polygon),22287))=True;
		
	END LOOP;
    RETURN 'ok';
END;
$BODY$
LANGUAGE plpgsql;

SELECT interim_data.parcel_ground_rent_zones();
drop table if exists interim_data.parcel_zones; 
create table  interim_data.parcel_zones
  (id character varying(40) ,
   plot_number character varying(30),
   parcel_zone character varying(30)
 
  );

CREATE OR REPLACE FUNCTION interim_data.parcel_ground_rent_zones() 
RETURNS varchar
 AS
$BODY$
DECLARE 

    rec record;

BEGIN
    
    FOR rec IN select co.id,co.geom_polygon,su.label from cadastre.cadastre_object co,cadastre.spatial_unit su where co.id=su.id
	LOOP
        insert into interim_data.parcel_zones(id,plot_number,parcel_zone) 
        select rec.id, rec.label,label from cadastre.spatial_unit as SU, cadastre.level l where l.id=su.level_id and l.name='Zones' and ST_contains(st_transform(su.geom,22287),st_transform(st_centroid(rec.geom_polygon),22287))=True;
		
	END LOOP;
    RETURN 'ok';
END;
$BODY$
LANGUAGE plpgsql;

SELECT interim_data.parcel_ground_rent_zones();
UPDATE interim_data.parcel_zones set parcel_zone='grade1' where parcel_zone like '%1';
UPDATE interim_data.parcel_zones set parcel_zone='grade2' where parcel_zone like '%2';
UPDATE interim_data.parcel_zones set parcel_zone='grade3' where parcel_zone like '%3';
UPDATE interim_data.parcel_zones set parcel_zone='grade4' where parcel_zone like '%4';
UPDATE interim_data.parcel_zones set parcel_zone='grade5' where parcel_zone like '%5';
UPDATE interim_data.parcel_zones set parcel_zone='grade6' where parcel_zone like '%6';

UPDATE Cadastre.Cadastre_object 
SET land_grade_code = parcel_zones.parcel_zone
FROM interim_data.parcel_zones 
WHERE parcel_zones.id = Cadastre_object.id;
