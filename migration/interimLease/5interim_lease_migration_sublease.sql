SELECT lesotho_etl.number_subleases();

--sublease rrr
INSERT INTO 
administrative.rrr
(id, ba_unit_id, nr, type_code, status_code, is_primary, transaction_id, 
registration_number, registration_date, start_date, execution_date, expiration_date, 
share, lease_number, land_use_code, land_usable, personal_levy, ground_rent)
SELECT 
uuid_generate_v1(), b.id, trim(to_char(nextval('administrative.rrr_nr_seq'), '000000')),
'subLease', 'current', TRUE, 'adm-transaction', r.registration_number, r.creation_date, r.creation_date, 
r.creation_date, r.expiration_date, 1/1, r.plot_number, r.land_use_code, 100, 1, 0 
FROM administrative.ba_unit b
INNER JOIN lesotho_etl.lms_right r ON r.first_part = b.name_firstpart AND r.last_part = b.name_lastpart
WHERE r.right_type_code ='sublease'
AND r.registration_number <> ''
AND r.creation_date is NOT NULL;

--add sublease notations
INSERT INTO  administrative.notation(id, rrr_id, transaction_id, change_user, notation_date, status_code, notation_text, reference_nr) 
SELECT uuid_generate_v1(), r.id, 'adm-transaction', 'test-id', r.registration_date, 'current', 'Sublease', r.nr
FROM administrative.rrr r,
     lesotho_etl.lms_right rt
WHERE  rt.plot_number = r.lease_number
AND    rt.registration_number = r.registration_number
AND    rt.right_type_code ='sublease'
AND    r.type_code = 'subLease';

--Load Parties first
INSERT INTO party.party
(id, type_code, name, last_name, legal_type, gender_code)
SELECT distinct p.id, p.party_type_code, trim(p.first_name), p.last_name, p.legal_type_code, p.gender_code
FROM lesotho_etl.lms_party p,
     administrative.rrr r
WHERE  r.type_code = 'subLease'
AND    p.registration_number = r.registration_number
AND    p.right_type_code ='sublease'
AND    NOT EXISTS (SELECT id FROM party.party where p.id = id);


--Load party for Rrr
INSERT INTO administrative.party_for_rrr
(rrr_id, party_id)
SELECT DISTINCT r.id, p.id
FROM lesotho_etl.lms_party p,
     administrative.rrr r
WHERE  r.type_code = 'subLease'
AND    p.registration_number = r.registration_number
AND    p.right_type_code ='sublease';
