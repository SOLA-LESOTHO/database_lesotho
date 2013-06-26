WITH spatial_unit_counter AS
(SELECT count(spatial_unit.id) as no_of_parcels, spatial_unit.id
FROM 
  cadastre.spatial_unit, 
  cadastre.cadastre_object, 
  administrative.ba_unit, 
  administrative.rrr
WHERE 
  spatial_unit.label = ba_unit.name AND
  cadastre_object.id = ba_unit.cadastre_object_id AND
  ba_unit.id = rrr.ba_unit_id AND
  rrr.type_code = 'lease' AND 
  rrr.status_code = 'current'
  group by spatial_unit.id)
 INSERT INTO administrative.lease 
(id, lease_number, cadastre_object_id, 
start_date, expiration_date, 
execution_date,  
ground_rent, stamp_duty, 
status_code, transaction_id)
SELECT 
uuid_generate_v1(),  ba_unit.name, cadastre_object.id, 
rrr.registration_date, rrr.registration_date + INTERVAL '90 YEARS',
rrr.registration_date, 
0, 0,
'current', ba_unit.transaction_id
FROM 
  cadastre.spatial_unit, 
  cadastre.cadastre_object, 
  administrative.ba_unit, 
  administrative.rrr
WHERE 
  spatial_unit.label = ba_unit.name AND
  cadastre_object.id = ba_unit.cadastre_object_id AND
  ba_unit.id = rrr.ba_unit_id AND
  rrr.type_code = 'lease' AND 
  rrr.status_code = 'current' AND
  spatial_unit.id NOT IN (SELECT id FROM spatial_unit_counter WHERE no_of_parcels > 1);
  
  
  
INSERT INTO administrative.lessee (lease_id, party_id)
SELECT lease.id, party_for_rrr.party_id
FROM 
  administrative.lease, 
  administrative.ba_unit, 
  administrative.rrr, 
  administrative.party_for_rrr
WHERE 
  lease.lease_number = ba_unit.name AND
  ba_unit.id = rrr.ba_unit_id AND
  rrr.id = party_for_rrr.rrr_id AND
  rrr.type_code = 'lease' AND 
  rrr.status_code = 'current'; 