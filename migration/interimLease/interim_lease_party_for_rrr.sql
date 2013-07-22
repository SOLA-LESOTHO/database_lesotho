
--load party for rrr

INSERT INTO administrative.party_for_rrr(
rrr_id,  
share_id,
party_id, 
rowversion, 
change_action, 
change_user)
SELECT distinct
r.id,
s.id,
p.id,
1,
'i',
'test-id'
FROM administrative.ba_unit b
inner join lesotho_etl.entity_plots e --link plot with property
on e.plot_number = b.name
inner join party.party p
on e.id = p.id
inner join administrative.rrr r -- link property with rrr
on b.id = r.ba_unit_id
inner join administrative.rrr_share s --link share with rrr and party (via entity plot)
on r.id = s.rrr_id and s.id = p.id;

INSERT INTO party.party_role (party_id, type_code)
SELECT DISTINCT party_id, 'accountHolder' from administrative.party_for_rrr;