SELECT lesotho_etl.number_subleases();

--sublease rrr
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
INNER JOIN lesotho_etl.lms_right r ON r.first_part = b.name_firstpart AND r.last_part = b.name_lastpart
WHERE r.right_type_code ='sublease'
AND r.registration_number <> ''
AND r.creation_date is NOT NULL;

--add sublease notations
INSERT INTO  administrative.notation(id, rrr_id, transaction_id, change_user, notation_date, status_code, notation_text, reference_nr) 
SELECT uuid_generate_v1(), r.id, 'adm-transaction', 'test-id', r.registration_date, 'current', 'sublease', r.nr
FROM administrative.rrr r
INNER JOIN lesotho_etl.lms_right rt ON rt.plot_number = r.lease_number
WHERE r.id not in (select rrr_id from administrative.notation)
AND rt.right_type_code ='sublease';

--Load Parties first
INSERT INTO party.party
(id, type_code, name, last_name, legal_type, gender_code)
SELECT distinct id, party_type_code, trim(first_name), last_name, legal_type_code, gender_code
FROM lesotho_etl.lms_party 
WHERE lease_number in (SELECT lease_number FROM administrative.rrr)
AND right_type_code = 'sublease'
AND id NOT IN (SELECT id FROM party.party);

--Load party for Rrr
INSERT INTO administrative.party_for_rrr
(rrr_id, share_id, party_id)
SELECT DISTINCT
s.rrr_id, s.id, p.id
FROM  administrative.rrr_share s
INNER JOIN administrative.rrr r ON
s.rrr_id = r.id
INNER JOIN lesotho_etl.lms_party p ON
r.lease_number = p.lease_number
WHERE p.right_type_code = 'sublease';