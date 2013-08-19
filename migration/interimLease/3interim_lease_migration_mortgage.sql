
DROP TABLE IF EXISTS lesotho_etl.lms_bank;
CREATE TABLE lesotho_etl.lms_bank
(
	id character varying(40) DEFAULT uuid_generate_v1(),
	name character varying(255)
);

INSERT INTO lesotho_etl.lms_bank (name) 
SELECT DISTINCT trim(first_name) FROM lesotho_etl.lms_party
WHERE party_role_code = 'bank';

INSERT INTO administrative.mortgage_type( code, display_value, status)
SELECT 'unknown', 'Unknown','c'
WHERE NOT EXISTS (SELECT code from administrative.mortgage_type where code = 'unknown');


-- Add the mortgage rrr's
DELETE FROM administrative.rrr where type_code = 'mortgage';
INSERT INTO 
administrative.rrr
(id, ba_unit_id, nr, type_code, status_code, is_primary, transaction_id, 
registration_number, registration_date, start_date, execution_date, expiration_date, 
share, lease_number, land_use_code, land_usable, personal_levy, ground_rent, mortgage_type_code, 
amount)
SELECT 
uuid_generate_v1(), b.id, trim(to_char(nextval('administrative.rrr_nr_seq'), '000000')),
'mortgage', 'current', TRUE, 'adm-transaction', r.registration_number, r.creation_date, r.creation_date, 
r.creation_date, r.expiration_date, 1/1, b.name, r.land_use_code, 100, 1, 0, 'unknown',
-- Extract the mortgage amount using regular expressions
safe_cast(regexp_replace(regexp_replace(r.consent_amount, '\..*', '', 'g'), '\D', '', 'g'), null::numeric(29,2))
FROM administrative.ba_unit b
INNER JOIN lesotho_etl.lms_right r ON r.plot_number = b.name
WHERE r.right_type_code ='mortgage'
AND r.registration_number <> ''
AND r.creation_date is NOT NULL;

-- Update properties with multiple mortgages so that only the most recently registered
-- mortgage remains current. If a property has multiple mortgages, then the mortgage
-- can be added again later through a Lease Correction. 
UPDATE administrative.rrr r
SET status_code = 'historic'
WHERE type_code = 'mortgage'
AND registration_date != (SELECT MAX(registration_date)
                          FROM administrative.rrr
                          WHERE type_code = 'mortgage'
                          AND ba_unit_id = r.ba_unit_id);

-- Add the mortgage notations
INSERT INTO  administrative.notation(id, rrr_id, transaction_id, change_user, notation_date, status_code, notation_text, reference_nr) 
SELECT uuid_generate_v1(), r.id, 'adm-transaction', 'test-id', r.registration_date, 'current', 'mortgage', r.nr
FROM administrative.rrr r
WHERE r.type_code = 'mortgage';


--Load list of banks
INSERT INTO party.party
(id, type_code, name, last_name, legal_type, gender_code)
SELECT b.id, 'nonNaturalPerson', b.name, NULL, 'regCompany', NULL
FROM lesotho_etl.lms_bank b
WHERE  NOT EXISTS (SELECT id FROM party.party where b.id = id);

-- Create the bank party role 
INSERT INTO party.party_role(party_id, type_code)
SELECT b.id, 'bank'
FROM lesotho_etl.lms_bank b
WHERE NOT EXISTS (SELECT party_id FROM party.party_role
                  WHERE party_id = b.id 
				  AND type_code = 'bank');

--Add party for rrr
INSERT INTO administrative.party_for_rrr
(rrr_id, party_id)
SELECT DISTINCT r.id, b.id
FROM lesotho_etl.lms_party p,
     lesotho_etl.lms_bank b,
     administrative.rrr r
WHERE  r.type_code = 'mortgage'
AND    p.registration_number = r.registration_number
AND    p.party_role_code = 'bank'
AND    b.name = trim(p.first_name);

