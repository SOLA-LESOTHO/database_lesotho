--Tlali Phoofolo 24/03/2013
--make all roads visible on the roads layer by removing the second condition [st_area(geom)> power(5 * #{pixel_res}, 2)] from sql


UPDATE system.query
   SET sql='select id, label, st_asewkb(geom) as the_geom from cadastre.road 
   where ST_Intersects(geom, ST_SetSRID(ST_MakeBox3D(ST_Point(#{minx}, #{miny}),ST_Point(#{maxx}, #{maxy})), #{srid}))'
 WHERE name='SpatialResult.getRoads';
