
--load rrrs
with land_uses as
(
SELECT 
  distinct lease."Plot_Number" as plot_number, lower(lease."LandUseDescription") as land_use_code
FROM 
 lesotho_etl.lease
 where  lower(lease."LandUseDescription") in (SELECT code FROM cadastre.land_use_type)
 order by  lower(lease."LandUseDescription")
)
INSERT INTO 
administrative.rrr(
id, 
ba_unit_id, 
nr, 
type_code, 
status_code, 
is_primary, 
transaction_id,
registration_number, 
registration_date,
start_date,
execution_date,
expiration_date, 
share,
lease_number,
land_use_code,
land_usable,
personal_levy,
ground_rent)
select 
uuid_generate_v1(), 
b.id, 
trim(to_char(nextval('administrative.rrr_nr_seq'), '000000')),
'lease',
'current', 
TRUE, 
'adm-transaction',
name, 
creation_date,
creation_date,
creation_date,
creation_date + INTERVAL '90 YEARS', 
1/1,
name,
l.land_use_code,
100,
1,
0 
FROM administrative.ba_unit b, land_uses l
WHERE b.name = l.plot_number;


INSERT INTO  administrative.notation(id, rrr_id, transaction_id, change_user, notation_date, status_code, notation_text, reference_nr) 
SELECT uuid_generate_v1(), r.id, 'adm-transaction', 'test-id', 
r.registration_date, 'current', 'lease', r.nr
FROM administrative.rrr r;


INSERT INTO administrative.source_describes_rrr(rrr_id, source_id)
SELECT rrr.id, source.id
FROM  source.source, administrative.rrr
WHERE source.reference_nr = rrr.lease_number;