do 
$body$
declare 
  num_users integer;
begin
   SELECT count(*) 
     into num_users
   FROM pg_user
   WHERE usename = 'accpac_reader';

   IF num_users = 0 THEN
      CREATE ROLE accpac_reader LOGIN PASSWORD 'AccpacReader';
   ELSE
      ALTER USER accpac_reader WITH PASSWORD 'AccpacReader';
   END IF;
end
$body$
;

-- Drop all privileges from user 
DROP OWNED BY accpac_reader CASCADE;
REVOKE ALL PRIVILEGES ON DATABASE sola FROM accpac_reader;

CREATE OR REPLACE FUNCTION administrative.get_leases_by_dates(date, date) 
RETURNS TABLE(
ba_unit_id character varying(40),
right_status character varying(20),
right_status_date timestamp without time zone,
right_id character varying(40),
right_type character varying(20),
registration_date timestamp without time zone,
registration_number character varying(40),
expiration_date timestamp without time zone,
right_tracking_number character varying(20),
ground_rent numeric(29,2),
land_use_code character varying(20),
lease_number character varying(40),
start_date date,
execution_date date,
land_usable numeric(29,2),
personal_levy numeric(19,2),
stamp_duty numeric(29,2),
transfer_duty numeric(29,2),
registration_fee numeric(29,2),
service_fee numeric(29,2),
owners text,
payee_id character varying(40),
payee_name character varying(255),
payee_last_name character varying(255),
payee_address character varying(255),
payee_phone character varying(15),
payee_mobile character varying(15),
payee_email character varying(50),
payee_id_number character varying(20),
payee_id_type_code character varying(20),
payee_birth_date date,
payee_gender character varying(20),
parcel_number text,
area numeric(29,2)
)
AS $$ 
SELECT DISTINCT b.id AS ba_unit_id, r.status_code AS right_status, r.status_change_date AS right_status_date,
    r.id AS right_id, r.type_code AS right_type, r.registration_date, r.registration_number, r.expiration_date,
    r.nr AS right_tracking_number, r.ground_rent, r.land_use_code, r.lease_number, r.start_date, r.execution_date,
    r.land_usable, r.personal_levy, r.stamp_duty, r.transfer_duty, r.registration_fee, s.service_fee,
    (SELECT string_agg(COALESCE(p.name, '') || ' ' || COALESCE(p.last_name, ''), ',')
    FROM administrative.party_for_rrr pr INNER JOIN party.party p ON pr.party_id = p.id WHERE pr.rrr_id = r.id) AS owners,
    payee.payee_id, payee.payee_name, payee.payee_last_name, payee.payee_address, payee.payee_phone, payee.payee_mobile,
    payee.payee_email, payee.payee_id_number, payee.payee_id_type_code, payee.payee_birth_date, payee.payee_gender,
    (SELECT name_firstpart || '-' || name_lastpart FROM cadastre.cadastre_object WHERE id = b.cadastre_object_id LIMIT 1) AS parcel_number,
    (SELECT size FROM cadastre.spatial_value_area WHERE spatial_unit_id = b.cadastre_object_id AND type_code='officialArea' LIMIT 1) AS area
    FROM (administrative.ba_unit b INNER JOIN
    ((administrative.rrr r LEFT JOIN
      (administrative.party_for_rrr prrr INNER JOIN
	   (
		SELECT p.id AS payee_id, p.name AS payee_name, p.last_name AS payee_last_name, p.birth_date as payee_birth_date,
		ad.description AS payee_address, p.phone AS payee_phone, p.mobile AS payee_mobile, p.gender_code AS payee_gender,
		p.email AS payee_email, p.id_number AS payee_id_number, p.id_type_code AS payee_id_type_code
		FROM (party.party p INNER JOIN party.party_role pr ON p.id=pr.party_id)
		LEFT JOIN address.address ad ON p.address_id = ad.id
		WHERE pr.type_code = 'accountHolder'
	    ) AS payee ON payee.payee_id = prrr.party_id)
	 ON r.id = prrr.rrr_id) INNER JOIN 
	 (transaction.transaction t LEFT JOIN application.service s ON t.from_service_id = s.id) ON r.transaction_id = t.id)
       ON b.id = r.ba_unit_id)
       WHERE r.type_code = 'lease'
       AND b.status_code != 'pending' AND r.status_code IN ('current', 'historic')
       AND r.registration_date BETWEEN $1 AND $2
       ORDER BY r.registration_date
$$
LANGUAGE SQL;

CREATE OR REPLACE FUNCTION administrative.get_lease(character varying, character varying) 
RETURNS TABLE(
ba_unit_id character varying(40),
right_status character varying(20),
right_status_date timestamp without time zone,
right_id character varying(40),
right_type character varying(20),
registration_date timestamp without time zone,
registration_number character varying(40),
expiration_date timestamp without time zone,
right_tracking_number character varying(20),
ground_rent numeric(29,2),
land_use_code character varying(20),
lease_number character varying(40),
start_date date,
execution_date date,
land_usable numeric(29,2),
personal_levy numeric(19,2),
stamp_duty numeric(29,2),
transfer_duty numeric(29,2),
registration_fee numeric(29,2),
service_fee numeric(29,2),
owners text,
payee_id character varying(40),
payee_name character varying(255),
payee_last_name character varying(255),
payee_address character varying(255),
payee_phone character varying(15),
payee_mobile character varying(15),
payee_email character varying(50),
payee_id_number character varying(20),
payee_id_type_code character varying(20),
payee_birth_date date,
payee_gender character varying(20),
parcel_number text,
area numeric(29,2)
)
AS $$ 
SELECT DISTINCT b.id AS ba_unit_id, r.status_code AS right_status, r.status_change_date AS right_status_date,
    r.id AS right_id, r.type_code AS right_type, r.registration_date, r.registration_number, r.expiration_date,
    r.nr AS right_tracking_number, r.ground_rent, r.land_use_code, r.lease_number, r.start_date, r.execution_date,
    r.land_usable, r.personal_levy, r.stamp_duty, r.transfer_duty, r.registration_fee, s.service_fee,
    (SELECT string_agg(COALESCE(p.name, '') || ' ' || COALESCE(p.last_name, ''), ',')
    FROM administrative.party_for_rrr pr INNER JOIN party.party p ON pr.party_id = p.id WHERE pr.rrr_id = r.id) AS owners,
    payee.payee_id, payee.payee_name, payee.payee_last_name, payee.payee_address, payee.payee_phone, payee.payee_mobile,
    payee.payee_email, payee.payee_id_number, payee.payee_id_type_code, payee.payee_birth_date, payee.payee_gender,
    (SELECT name_firstpart || '-' || name_lastpart FROM cadastre.cadastre_object WHERE id = b.cadastre_object_id LIMIT 1) AS parcel_number,
    (SELECT size FROM cadastre.spatial_value_area WHERE spatial_unit_id = b.cadastre_object_id AND type_code='officialArea' LIMIT 1) AS area
    FROM (administrative.ba_unit b INNER JOIN
    ((administrative.rrr r LEFT JOIN
      (administrative.party_for_rrr prrr INNER JOIN
	   (
		SELECT p.id AS payee_id, p.name AS payee_name, p.last_name AS payee_last_name, p.birth_date as payee_birth_date,
		ad.description AS payee_address, p.phone AS payee_phone, p.mobile AS payee_mobile, p.gender_code AS payee_gender,
		p.email AS payee_email, p.id_number AS payee_id_number, p.id_type_code AS payee_id_type_code
		FROM (party.party p INNER JOIN party.party_role pr ON p.id=pr.party_id)
		LEFT JOIN address.address ad ON p.address_id = ad.id
		WHERE pr.type_code = 'accountHolder'
	    ) AS payee ON payee.payee_id = prrr.party_id)
	 ON r.id = prrr.rrr_id) INNER JOIN 
	 (transaction.transaction t LEFT JOIN application.service s ON t.from_service_id = s.id) ON r.transaction_id = t.id)
       ON b.id = r.ba_unit_id)
       WHERE r.type_code = 'lease' AND r.lease_number = $1 AND r.status_code = $2
$$
LANGUAGE SQL;

CREATE OR REPLACE FUNCTION administrative.get_current_lease(IN character varying)
RETURNS TABLE(
ba_unit_id character varying(40),
right_status character varying(20),
right_status_date timestamp without time zone,
right_id character varying(40),
right_type character varying(20),
registration_date timestamp without time zone,
registration_number character varying(40),
expiration_date timestamp without time zone,
right_tracking_number character varying(20),
ground_rent numeric(29,2),
land_use_code character varying(20),
lease_number character varying(40),
start_date date,
execution_date date,
land_usable numeric(29,2),
personal_levy numeric(19,2),
stamp_duty numeric(29,2),
transfer_duty numeric(29,2),
registration_fee numeric(29,2),
service_fee numeric(29,2),
owners text,
payee_id character varying(40),
payee_name character varying(255),
payee_last_name character varying(255),
payee_address character varying(255),
payee_phone character varying(15),
payee_mobile character varying(15),
payee_email character varying(50),
payee_id_number character varying(20),
payee_id_type_code character varying(20),
payee_birth_date date,
payee_gender character varying(20),
parcel_number text,
area numeric(29,2)
)
AS
$BODY$ 
select * from administrative.get_lease($1, 'current')
$BODY$
  LANGUAGE sql VOLATILE
  COST 100
  ROWS 1000;

CREATE OR REPLACE FUNCTION administrative.get_pending_lease(IN character varying)
RETURNS TABLE(
ba_unit_id character varying(40),
right_status character varying(20),
right_status_date timestamp without time zone,
right_id character varying(40),
right_type character varying(20),
registration_date timestamp without time zone,
registration_number character varying(40),
expiration_date timestamp without time zone,
right_tracking_number character varying(20),
ground_rent numeric(29,2),
land_use_code character varying(20),
lease_number character varying(40),
start_date date,
execution_date date,
land_usable numeric(29,2),
personal_levy numeric(19,2),
stamp_duty numeric(29,2),
transfer_duty numeric(29,2),
registration_fee numeric(29,2),
service_fee numeric(29,2),
owners text,
payee_id character varying(40),
payee_name character varying(255),
payee_last_name character varying(255),
payee_address character varying(255),
payee_phone character varying(15),
payee_mobile character varying(15),
payee_email character varying(50),
payee_id_number character varying(20),
payee_id_type_code character varying(20),
payee_birth_date date,
payee_gender character varying(20),
parcel_number text,
area numeric(29,2)
)
AS
$BODY$ 
select * from administrative.get_lease($1, 'pending')
$BODY$
  LANGUAGE sql VOLATILE
  COST 100
  ROWS 1000;
  
-- Grant user with minimum required privileges to query the data
GRANT USAGE ON schema administrative TO accpac_reader;
GRANT USAGE ON schema public TO accpac_reader;
GRANT USAGE ON schema party TO accpac_reader;
GRANT USAGE ON schema address TO accpac_reader;
GRANT USAGE ON schema transaction TO accpac_reader;
GRANT USAGE ON schema application TO accpac_reader;
GRANT USAGE ON schema cadastre TO accpac_reader;

GRANT SELECT ON TABLE administrative.ba_unit, administrative.rrr, administrative.party_for_rrr, 
transaction.transaction, application.service, party.party, party.party_role, address.address,
cadastre.cadastre_object, cadastre.spatial_value_area TO accpac_reader;

GRANT EXECUTE ON FUNCTION administrative.get_current_lease(character varying), 
administrative.get_pending_lease(IN character varying), 
administrative.get_lease(IN character varying, IN character varying), 
administrative.get_leases_by_dates(IN date, IN date) TO accpac_reader;
