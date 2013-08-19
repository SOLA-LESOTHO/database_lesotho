
--house keeping first
delete from administrative.ba_unit;
delete from party.party;

create or replace function safe_cast(text,anyelement) 
returns anyelement 
language plpgsql as $$ 
begin 
    $0 := $1; 
    return $0; 
    exception when others then 
        return $2; 
end; $$;

--ADD transaction for lease migration
INSERT INTO transaction.transaction
(id, from_service_id, status_code, approval_datetime, bulk_generate_first_part, is_bulk_operation) 
SELECT 'adm-transaction', NULL, 'approved', now(), false, false
WHERE NOT EXISTS (SELECT status_code FROM transaction.transaction WHERE id = 'adm-transaction');


--ADD Property
WITH cadastre_list AS
(
SELECT count(cadastre_object_id) as count, cadastre_object_id
FROM lesotho_etl.lms_right 
WHERE right_type_code = 'lease' 
GROUP BY cadastre_object_id
HAVING count(cadastre_object_id) > 1
)
INSERT INTO administrative.ba_unit
(id, type_code, cadastre_object_id, name, 
name_firstpart, name_lastpart, creation_date, 
expiration_date, status_code, transaction_id)
SELECT  
uuid_generate_v1(), 
property_type, cadastre_object_id, plot_number, 
first_part, last_part, creation_date,
expiration_date, status_code, transaction_id 
FROM lesotho_etl.lms_right
WHERE right_type_code = 'lease'
AND creation_date is NOT NULL
AND NOT EXISTs (select cadastre_object_id FROM cadastre_list where
cadastre_object_id = lms_right.cadastre_object_id);

--Add Lease Rights

INSERT INTO 
administrative.rrr
(id, ba_unit_id, nr, type_code, status_code, is_primary, transaction_id, 
registration_number, registration_date, start_date, execution_date, expiration_date, 
share, lease_number, land_use_code, land_usable, personal_levy, ground_rent)
SELECT 
uuid_generate_v1(), b.id, trim(to_char(nextval('administrative.rrr_nr_seq'), '000000')),
'lease', 'current', TRUE, 'adm-transaction', b.name, b.creation_date, b.creation_date, 
b.creation_date, b.expiration_date, 1/1, b.name, r.land_use_code, 100, 1, 0 
FROM administrative.ba_unit b
INNER JOIN lesotho_etl.lms_right r
ON r.plot_number = b.name
WHERE r.right_type_code = 'lease';

-- Add Lease Notations
INSERT INTO  administrative.notation(id, rrr_id, transaction_id, change_user, notation_date, status_code, notation_text, reference_nr) 
SELECT uuid_generate_v1(), r.id, 'adm-transaction', 'test-id', r.registration_date, 'current', 'lease', r.nr
FROM administrative.rrr r;

--Load Parties first
INSERT INTO party.party
(id, type_code, name, last_name, legal_type, gender_code)
SELECT distinct p.id, p.party_type_code, trim(p.first_name), p.last_name, p.legal_type_code, p.gender_code
FROM lesotho_etl.lms_party p,
     administrative.rrr r
WHERE  r.type_code = 'lease'
AND    p.lease_number = r.lease_number
AND    p.right_type_code ='lease'
AND    NOT EXISTS (SELECT id FROM party.party where p.id = id);

--Load party for Rrr - Link using the r.registration_number to avoid
-- duplicate records where transfers have occurred. 
INSERT INTO administrative.party_for_rrr
(rrr_id, party_id)
SELECT DISTINCT r.id, p.id
FROM lesotho_etl.lms_party p,
     administrative.rrr r
WHERE  r.type_code = 'lease'
AND    p.lease_number = r.registration_number
AND    p.right_type_code ='lease';

INSERT INTO party.party_role (party_id, type_code)
SELECT DISTINCT p.id, l.party_role_code from lesotho_etl.lms_party l
INNER JOIN party.party p ON p.id = l.id
WHERE l.party_role_code = 'accountHolder';