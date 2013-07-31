
INSERT INTO 
administrative.rrr
(id, ba_unit_id, nr, type_code, status_code, is_primary, transaction_id, 
registration_number, registration_date, start_date, execution_date, expiration_date, 
share, lease_number, land_use_code, land_usable, personal_levy, ground_rent)
SELECT 
uuid_generate_v1(), b.id, trim(to_char(nextval('administrative.rrr_nr_seq'), '000000')),
'lease', 'current', TRUE, 'adm-transaction', r.registration_number, b.creation_date, b.creation_date, 
b.creation_date, b.expiration_date, 1/1, b.name, r.land_use_code, 100, 1, 0 
FROM administrative.ba_unit b
INNER JOIN lesotho_etl.lms_right r ON r.plot_number = b.name
WHERE r.right_type_code ='variation'
AND r.registration_number <> ''
AND r.creation_date is NOT NULL;

--add variation notations
INSERT INTO  administrative.notation(id, rrr_id, transaction_id, change_user, notation_date, status_code, notation_text, reference_nr) 
SELECT uuid_generate_v1(), r.id, 'adm-transaction', 'test-id', r.registration_date, 'current', 'variation', r.nr
FROM administrative.rrr r
INNER JOIN lesotho_etl.lms_right rt ON rt.plot_number = r.lease_number
WHERE r.id not in (select rrr_id from administrative.notation)
AND rt.right_type_code ='variation';
