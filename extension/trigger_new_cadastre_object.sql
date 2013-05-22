-- Function: cadastre.f_for_tbl_cadastre_object_trg_new()

-- DROP FUNCTION cadastre.f_for_tbl_cadastre_object_trg_new();

CREATE OR REPLACE FUNCTION cadastre.f_for_tbl_cadastre_object_trg_new()
  RETURNS trigger AS
$BODY$

DECLARE


rec record;



BEGIN

   
  
  if (select count(*)=0 from cadastre.spatial_unit where id=new.id) then

   IF (select count(*)= 0 from cadastre.spatial_unit su, cadastre.level l, (select name_firstpart , max(to_number(name_lastpart, '999999'))+1 next_lastpart from cadastre.cadastre_object group by name_firstpart) cl 
      where su.level_id = l.id and l.name = 'Grids' and su.label=cl.name_firstpart  
      and contains(ST_GeomFromWKB(su.geom,22287), ST_Centroid(new.geom_polygon))) then
	
     insert into cadastre.spatial_unit(id,dimension_code,label, surface_relation_code,rowidentifier, level_id, change_user) 
     select new.id, '2D',su.label || '-001','onSurface', new.rowidentifier,(select id from cadastre.level where name='Parcels'), new.change_user from cadastre.spatial_unit su,cadastre.level l 
     where su.level_id = l.id and l.name = 'Grids' and contains(ST_GeomFromWKB(su.geom,22287), ST_Centroid(new.geom_polygon));

     FOR rec IN select su.label as fp, '001' as lp from cadastre.spatial_unit su,cadastre.level l 
                        where su.level_id = l.id and l.name = 'Grids' and contains(ST_GeomFromWKB(su.geom,22287), ST_Centroid(new.geom_polygon))
     LOOP
       new.name_firstpart=rec.fp;
       new.name_lastpart=rec.lp;		
		
     END LOOP;
	  
   ELSE
   
     insert into cadastre.spatial_unit(id,dimension_code,label, surface_relation_code,rowidentifier, level_id, change_user) 
     select new.id, '2D',su.label || '-' || (case when cl.next_lastpart<100 then right('00'||trim(to_char(cl.next_lastpart,'9999')),3)  else  trim(to_char(cl.next_lastpart,'9999')) end),'onSurface', new.rowidentifier,(select id from cadastre.level where name='Parcels'), new.change_user from cadastre.spatial_unit su, cadastre.level l, (select name_firstpart , max(to_number(name_lastpart, '999999'))+1 next_lastpart from cadastre.cadastre_object group by name_firstpart) cl 
     where su.level_id = l.id and l.name = 'Grids' and su.label=cl.name_firstpart  
     and contains(ST_GeomFromWKB(su.geom,22287), ST_Centroid(new.geom_polygon));
 
    FOR rec IN select su.label as fp ,(case when cl.next_lastpart<100 then right('00'||trim(to_char(cl.next_lastpart,'9999')),3)  else  trim(to_char(cl.next_lastpart,'9999')) end) as lp from cadastre.spatial_unit su, cadastre.level l, (select name_firstpart , max(to_number(name_lastpart, '999999'))+1 next_lastpart from cadastre.cadastre_object group by name_firstpart) cl 
                         where su.level_id = l.id and l.name = 'Grids' and su.label=cl.name_firstpart  
                         and contains(ST_GeomFromWKB(su.geom,22287), ST_Centroid(new.geom_polygon))
    LOOP
      new.name_firstpart=rec.fp;
      new.name_lastpart=rec.lp;		
		
    END LOOP;
     
   			
	
     
    
   
   END IF;	  
     
        
    
  end if;
  return new;
END;

$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION cadastre.f_for_tbl_cadastre_object_trg_new()
  OWNER TO postgres;
