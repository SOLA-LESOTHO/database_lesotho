--update road classes
UPDATE cadastre.cadastre_object 
SET road_class_code=tmpRoads.code
FROM interim_data.tmpRoads 
WHERE tmpRoads.id = Cadastre_object.id;
	
--set default value for road classes 
UPDATE cadastre.cadastre_object 
SET road_class_code='minor_unsurfaced' 
WHERE cadastre_object.road_class_code=NULL;

