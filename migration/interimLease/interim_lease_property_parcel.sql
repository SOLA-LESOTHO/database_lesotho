
--link plots with property

INSERT INTO administrative.ba_unit_contains_spatial_unit
(ba_unit_id, spatial_unit_id, rowidentifier, rowversion, change_action, change_user)
select b.id, s.id,  uuid_generate_v1(), 1, 'i', 'test-id'
from administrative.ba_unit b
inner join cadastre.spatial_unit s
on s.label = b.name;


--update land use type
lesotho_etl.update_land_use_type();