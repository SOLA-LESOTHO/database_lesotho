
-- Restart the document sequences at 500,000 so there
-- is room for other documents to be inserted if necessary
DROP SEQUENCE IF EXISTS document.document_nr_seq;
DROP SEQUENCE IF EXISTS source.source_la_nr_seq;

CREATE SEQUENCE document.document_nr_seq
  INCREMENT 1
  MINVALUE 500000
  MAXVALUE 99999999
  START 500000
  CACHE 1;
  
CREATE SEQUENCE source.source_la_nr_seq
  INCREMENT 1
  MINVALUE 500000
  MAXVALUE 99999999
  START 500000
  CACHE 1;

-- Customised Trigger function to determine the correct name for the new cadastre object
CREATE OR REPLACE FUNCTION cadastre.f_for_tbl_cadastre_object_trg_new()
  RETURNS trigger AS
$BODY$

DECLARE
  target_srid int; 
  grid_num VARCHAR(20);
  parcel_num NUMERIC;
  subplot_parcel_num VARCHAR(20);   
  subplot_num NUMERIC;   
BEGIN
   
   IF (NEW.geom_polygon IS NOT NULL) THEN
      -- Determine the SRID of the new polygon
      target_srid := ST_Srid(NEW.geom_polygon); 
   END IF;

   -- Find the grid number this new CO is within
   SELECT su.label
   INTO   grid_num
   FROM   cadastre.spatial_unit su,
	      cadastre.level l
   WHERE  su.level_id = l.id
   AND    l.name = 'Grids'
   AND    ST_contains(ST_Transform(su.geom,target_srid), ST_Centroid(NEW.geom_polygon)); 

   IF (NEW.type_code = 'subplot') THEN
      -- This is a subplot. Determine the current parcel that this subplot is contained by
	  SELECT co.name_lastpart
      INTO   subplot_parcel_num
      FROM   cadastre.cadastre_object co
      WHERE  co.type_code = 'parcel'
	  AND    co.status_code = 'current'
      AND    co.name_firstpart = grid_num
      AND    ST_contains(ST_Transform(co.geom_polygon,target_srid), ST_Centroid(NEW.geom_polygon)); 
	  
	  IF (subplot_parcel_num IS NULL) THEN
	     -- There is no current parcel containing this subplot. Check if there is a pending parcel.
	     SELECT co.name_lastpart
         INTO   subplot_parcel_num
         FROM   cadastre.cadastre_object co
         WHERE  co.type_code = 'parcel'
	     AND    co.status_code = 'pending'
         AND    co.name_firstpart = grid_num
         AND    ST_contains(ST_Transform(co.geom_polygon,target_srid), ST_Centroid(NEW.geom_polygon)); 
	  END IF;
	  
	  IF (subplot_parcel_num IS NULL) THEN
	     -- There is no current or pending parcel containing this subplot. Assume the new parcel plot 
		 -- is about to be created and use the next available parcel number in the grid
         SELECT (max(to_number(co.name_lastpart, '999999'))+1)
         INTO   parcel_num
         FROM   cadastre.cadastre_object co
         WHERE  co.name_firstpart = grid_num
         GROUP BY co.name_firstpart;
		 
		 parcel_num := COALESCE(parcel_num, 1);
		 subplot_parcel_num := CASE WHEN parcel_num < 100 THEN trim(to_char(parcel_num,'000')) ELSE trim(to_char(parcel_num,'9999')) END;
	  END IF;
	  
	  -- Determine the next subplot number for this parcel
      SELECT (max(to_number(co.name_lastpart, '999999')) + 1)
      INTO   subplot_num
      FROM   cadastre.cadastre_object co
      WHERE  co.name_firstpart = grid_num || '-' || subplot_parcel_num
      GROUP BY co.name_firstpart;

      subplot_num := COALESCE(subplot_num, 1); 
      NEW.name_firstpart := COALESCE(grid_num || '-' || subplot_parcel_num, NEW.name_firstpart);
      NEW.name_lastpart := CASE WHEN subplot_num < 100 THEN trim(to_char(subplot_num,'000')) ELSE trim(to_char(subplot_num,'9999')) END; 
   ELSE
      -- Determine the parcel number for this grid
      SELECT (max(to_number(co.name_lastpart, '999999'))+1)
      INTO   parcel_num
      FROM   cadastre.cadastre_object co
      WHERE  co.name_firstpart = grid_num
      GROUP BY co.name_firstpart;

      parcel_num := COALESCE(parcel_num, 1); 
      NEW.name_firstpart := COALESCE(grid_num, NEW.name_firstpart);
      NEW.name_lastpart := CASE WHEN parcel_num < 100 THEN trim(to_char(parcel_num,'000')) ELSE trim(to_char(parcel_num,'9999')) END; 
   END IF;
   
   
   IF (select count(*)=0 from cadastre.spatial_unit where id = NEW.id) THEN 
      -- Create a spatial_unit record for this cadastre object
      insert into cadastre.spatial_unit(id, dimension_code, label, surface_relation_code, level_id, change_user) 
      values(new.id, '2D', new.name_firstpart || '-' ||  new.name_lastpart, 'onSurface', 
	  CASE WHEN NEW.type_code = 'subplot' THEN (select id from cadastre.level where name='Subplots')
	        ELSE (select id from cadastre.level where name='Parcels') END, new.change_user);
   END IF;  
 RETURN NEW;
END;

$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION cadastre.f_for_tbl_cadastre_object_trg_new()
  OWNER TO postgres;
COMMENT ON FUNCTION cadastre.f_for_tbl_cadastre_object_trg_new() IS 'This function creates a new spatial_unit record for any new cadastre object and also determines the name for the new CO based on the grid the CO is within';

CREATE OR REPLACE FUNCTION administrative.f_for_tbl_ba_unit_trg_check_cadastre_object()
  RETURNS trigger AS
$BODY$
begin
   --IF new.cadastre_object_id is null and new.status_code is not null and new.status_code != 'pending' THEN
	--raise exception 'Cadastre object can''t be null';
   --END IF;
   
   IF (select count(1) from administrative.ba_unit b 
       where b.id!=new.id and b.cadastre_object_id = new.cadastre_object_id and 
       b.status_code in ('pending', 'current') and new.status_code in ('pending', 'current')) > 0 THEN
      raise exception 'Selected cadastre object already bound to the lease.';
   END IF;
   return new;
end
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION administrative.f_for_tbl_ba_unit_trg_check_cadastre_object()
  OWNER TO postgres;

 ALTER TABLE administrative.ba_unit
  ADD CONSTRAINT ba_unit_unique_name_parts UNIQUE (name_firstpart, name_lastpart);