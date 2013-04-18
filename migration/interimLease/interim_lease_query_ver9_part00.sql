-- Remove any previous records

--remove application records

--delete from transaction.transaction where id not in ('adm-transaction', 'cadastre-transaction');
--delete from application.service cascade;
--delete from application.application cascade;
--delete from application.application_property cascade; 

--remove administrative schema records
--DELETE FROM administrative.ba_unit_contains_spatial_unit;
--DELETE FROM application.application_property;
--DELETE FROM administrative.rrr;
--DELETE FROM administrative.ba_unit_area;
--DELETE FROM administrative.ba_unit_historic;
--DELETE FROM administrative.required_relationship_baunit;
--DELETE FROM administrative.ba_unit;
--Remove Ownership details for primary rrr
--DELETE FROM party.party cascade;
--DELETE FROM administrative.party_for_rrr;
--DELETE FROM administrative.rrr_share;