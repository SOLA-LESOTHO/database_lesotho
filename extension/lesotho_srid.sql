insert into spatial_ref_sys(srid, auth_name, auth_srid, srtext, proj4text)
select 40000, auth_name, 40000, srtext, proj4text
from spatial_ref_sys 
where srid = 22287;


update spatial_ref_sys set srtext = 
'PROJCS["Cape / Lo27",GEOGCS["Cape",DATUM["Cape",SPHEROID["Clarke 1880 (Arc)",6378249.145,293.4663077,AUTHORITY["EPSG","7013"]],AUTHORITY["EPSG","6222"]],PRIMEM["Greenwich",0,AUTHORITY["EPSG","8901"]],UNIT["degree",0.01745329251994328,AUTHORITY["EPSG","9122"]],AUTHORITY["EPSG","4222"]],UNIT["metre",1,AUTHORITY["EPSG","9001"]],PROJECTION["Transverse Mercator (South Orientated)"],PARAMETER["latitude_of_origin",0],PARAMETER["central_meridian",27],PARAMETER["scale_factor",1],PARAMETER["false_easting",0],PARAMETER["false_northing",0],AUTHORITY["EPSG","22287"],AXIS["Y",WEST],AXIS["X",SOUTH]]'
where srid = 40000;