--update zones using interim data script
UPDATE cadastre.cadastre_object 
SET land_grade_code = parcel_zones.parcel_zone
FROM interim_data.parcel_zones 
WHERE parcel_zones.id = Cadastre_object.id;
