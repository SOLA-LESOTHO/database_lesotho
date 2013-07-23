drop table if exists interim_data.parcel_roads_class; 
drop table if exists interim_data.tmpRoads; 
create table  interim_data.parcel_roads_class
(id character varying(40) ,
 plot_number character varying(30),
 road_class character varying(30),
 distance character varying(20)
  );
create table  interim_data.tmpRoads
(id character varying(40) ,
 code character varying(30),
 factor character varying(20)
  );
  
CREATE OR REPLACE FUNCTION interim_data.find_road_class() 
RETURNS varchar
 AS
$BODY$
DECLARE 

    rec record;

BEGIN
    
    FOR rec IN select co.id,co.geom_polygon,su.label from cadastre.cadastre_object co,cadastre.spatial_unit su where co.id=su.id
	LOOP
        insert into interim_data.parcel_roads_class(id,road_class,plot_number, distance) 
        select rec.id, label,rec.label,ST_Distance(st_transform(rec.geom_polygon,22287),st_transform(su.geom,22287)) from cadastre.spatial_unit as SU, cadastre.level l where l.id=su.level_id and l.name='Roads' and ST_Distance(st_transform(rec.geom_polygon,22287),st_transform(su.geom,22287))<=30;
		
	END LOOP;
	
	UPDATE interim_data.parcel_roads_class set road_class='main_surfaced' where road_class='Main_Roads_Tarred';
	UPDATE interim_data.parcel_roads_class set road_class='main_unsurfaced' where road_class='Main_Roads_Untarred';
	UPDATE interim_data.parcel_roads_class set road_class='main_unsurfaced' where road_class='Main_Roads';
	UPDATE interim_data.parcel_roads_class set road_class='secondary_surfaced' where road_class='Sec_Roads_Tarred';
	UPDATE interim_data.parcel_roads_class set road_class='secondary_unsurfaced' where road_class='Sec_Roads_Untarred';
	UPDATE interim_data.parcel_roads_class set road_class='minor_surfaced' where road_class='Minor_Roads_Tarred';
	UPDATE interim_data.parcel_roads_class set road_class='minor_unsurfaced' where road_class='Minor_Roads_Untarred';
	
	--FOR rec IN 
	insert into interim_data.tmpRoads(id,code,factor)
	Select max_factor.id,p.code,p.road_factor  from cadastre.road_class_type as p, 
							(SELECT parcel_roads_class.id,max(road_class_type.road_factor) as fact
							     FROM cadastre.road_class_type,interim_data.parcel_roads_class
								   WHERE road_class_type.code = parcel_roads_class.road_class
									 group by parcel_roads_class.id) as max_factor 

	                    where p.road_factor=max_factor.fact;
	--LOOP
	
	UPDATE Cadastre.Cadastre_object 
		SET road_class_code=tmpRoads.code
		FROM interim_data.tmpRoads 
	WHERE tmpRoads.id = Cadastre_object.id;
	
	--UPDATE cadastre.cadastre_object set road_class_code=rec.code where cadastre_object.id = rec.id;
		
	--END LOOP;
	
	UPDATE cadastre.cadastre_object set road_class_code='minor_unsurfaced' where cadastre_object.road_class_code=NULL;
	
	
    RETURN 'ok';
END;
$BODY$
LANGUAGE plpgsql;

SELECT interim_data.find_road_class();

