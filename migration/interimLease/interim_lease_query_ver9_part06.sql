
--load rrrs

INSERT INTO 
administrative.rrr(
id, 
ba_unit_id, 
nr, 
type_code, 
status_code, 
is_primary, 
transaction_id, 
registration_date, 
share)
select 
uuid_generate_v1(), 
b.id, 
trim(to_char(nextval('administrative.rrr_nr_seq'), '000000')),
'ownership',
'current', 
TRUE, 
'adm-transaction', 
creation_date, 
1/1 
FROM administrative.ba_unit b;


INSERT INTO  administrative.notation(id, rrr_id, transaction_id, change_user, notation_date, status_code, notation_text, reference_nr) 
SELECT uuid_generate_v1(), r.id, 'adm-transaction', 'test-id', 
r.registration_date, 'current', 'ownership', r.nr
FROM administrative.rrr r;