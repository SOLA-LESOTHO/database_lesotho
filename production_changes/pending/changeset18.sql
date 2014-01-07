-- Function: administrative.get_financial_start_date(timestamp without time zone)

DROP FUNCTION if exists administrative.get_financial_start_date(timestamp without time zone);

CREATE OR REPLACE FUNCTION administrative.get_financial_start_date(start_date timestamp without time zone)
  RETURNS date AS
$BODY$
  DECLARE
     registration_month INT = 0;
     financial_year INT = 0;
     financial_period_start DATE;
   BEGIN
	registration_month = DATE_PART('month',start_date);
       IF registration_month > 4 THEN
         -- Reference point will be next financial year
            financial_year = DATE_PART('year',start_date) + 1;
       ELSE
            financial_year = DATE_PART('year',start_date);
       END IF;
          
            financial_period_start = financial_year || '-04-01';
            RETURN financial_period_start;
   END;
   $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION administrative.get_financial_start_date(timestamp without time zone)
  OWNER TO postgres;
  

-- Function: administrative.get_remaining_months(timestamp without time zone, timestamp without time zone)

DROP FUNCTION IF EXISTS administrative.get_remaining_months(timestamp without time zone, timestamp without time zone);

CREATE OR REPLACE FUNCTION administrative.get_remaining_months(start_date timestamp without time zone, financial_date timestamp without time zone)
  RETURNS integer AS
$BODY$
  DECLARE
     remaining_months INT = 0;
   BEGIN
	remaining_months = (DATE_PART('year', financial_date::date) - DATE_PART('year', start_date::date)) * 12 +
              (DATE_PART('month', financial_date::date) - DATE_PART('month', start_date::date));

         RETURN remaining_months;
   END;
   $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION administrative.get_remaining_months(timestamp without time zone, timestamp without time zone)
  OWNER TO postgres;
  

-- Function: administrative.get_lease(character varying, character varying)

DROP FUNCTION IF EXISTS administrative.get_lease(character varying, character varying);

CREATE OR REPLACE FUNCTION administrative.get_lease(IN character varying, IN character varying)
  RETURNS TABLE(ba_unit_id character varying, right_status character varying, right_status_date timestamp without time zone, right_id character varying, right_type character varying, registration_date timestamp without time zone, registration_number character varying, expiration_date timestamp without time zone, right_tracking_number character varying, ground_rent numeric, land_use_code character varying, lease_number character varying, start_date date, execution_date date, land_usable numeric, personal_levy numeric, stamp_duty numeric, transfer_duty numeric, registration_fee numeric, service_fee numeric, owners text, payee_id character varying, payee_name character varying, payee_last_name character varying, payee_address character varying, payee_phone character varying, payee_mobile character varying, payee_email character varying, payee_id_number character varying, payee_id_type_code character varying, payee_birth_date date, payee_gender character varying, parcel_number text, area numeric, pro_rated_groud_rent numeric) AS
$BODY$ 
SELECT DISTINCT b.id AS ba_unit_id, r.status_code AS right_status, r.status_change_date AS right_status_date,
    r.id AS right_id, r.type_code AS right_type, r.registration_date, r.registration_number, r.expiration_date,
    r.nr AS right_tracking_number, r.ground_rent, r.land_use_code, r.lease_number, r.start_date, r.execution_date,
    r.land_usable, r.personal_levy, r.stamp_duty, r.transfer_duty, r.registration_fee, s.service_fee,
    (SELECT string_agg(COALESCE(p.name, '') || ' ' || COALESCE(p.last_name, ''), ',')
    FROM administrative.party_for_rrr pr INNER JOIN party.party p ON pr.party_id = p.id WHERE pr.rrr_id = r.id) AS owners,
    payee.payee_id, payee.payee_name, payee.payee_last_name, payee.payee_address, payee.payee_phone, payee.payee_mobile,
    payee.payee_email, payee.payee_id_number, payee.payee_id_type_code, payee.payee_birth_date, payee.payee_gender,
    (SELECT name_firstpart || '-' || name_lastpart FROM cadastre.cadastre_object WHERE id = b.cadastre_object_id LIMIT 1) AS parcel_number,
    (SELECT size FROM cadastre.spatial_value_area WHERE spatial_unit_id = b.cadastre_object_id AND type_code='officialArea' LIMIT 1) AS area,
    administrative.get_remaining_months(r.registration_date, administrative.get_financial_start_date(r.registration_date)) * r.ground_rent/ 12 as pro_rated_groud_rent
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
$BODY$
  LANGUAGE sql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION administrative.get_lease(character varying, character varying)
  OWNER TO postgres;
GRANT EXECUTE ON FUNCTION administrative.get_lease(character varying, character varying) TO public;
GRANT EXECUTE ON FUNCTION administrative.get_lease(character varying, character varying) TO postgres;
GRANT EXECUTE ON FUNCTION administrative.get_lease(character varying, character varying) TO accpac_reader;


-- Function: administrative.get_leases_by_dates(date, date)

DROP FUNCTION administrative.get_leases_by_dates(date, date);

CREATE OR REPLACE FUNCTION administrative.get_leases_by_dates(IN date, IN date)
  RETURNS TABLE(ba_unit_id character varying, right_status character varying, right_status_date timestamp without time zone, right_id character varying, right_type character varying, registration_date timestamp without time zone, registration_number character varying, expiration_date timestamp without time zone, right_tracking_number character varying, ground_rent numeric, land_use_code character varying, lease_number character varying, start_date date, execution_date date, land_usable numeric, personal_levy numeric, stamp_duty numeric, transfer_duty numeric, registration_fee numeric, service_fee numeric, owners text, payee_id character varying, payee_name character varying, payee_last_name character varying, payee_address character varying, payee_phone character varying, payee_mobile character varying, payee_email character varying, payee_id_number character varying, payee_id_type_code character varying, payee_birth_date date, payee_gender character varying, parcel_number text, area numeric, pro_rated_groud_rent numeric) AS
$BODY$ 
SELECT DISTINCT b.id AS ba_unit_id, r.status_code AS right_status, r.status_change_date AS right_status_date,
    r.id AS right_id, r.type_code AS right_type, r.registration_date, r.registration_number, r.expiration_date,
    r.nr AS right_tracking_number, r.ground_rent, r.land_use_code, r.lease_number, r.start_date, r.execution_date,
    r.land_usable, r.personal_levy, r.stamp_duty, r.transfer_duty, r.registration_fee, s.service_fee,
    (SELECT string_agg(COALESCE(p.name, '') || ' ' || COALESCE(p.last_name, ''), ',')
    FROM administrative.party_for_rrr pr INNER JOIN party.party p ON pr.party_id = p.id WHERE pr.rrr_id = r.id) AS owners,
    payee.payee_id, payee.payee_name, payee.payee_last_name, payee.payee_address, payee.payee_phone, payee.payee_mobile,
    payee.payee_email, payee.payee_id_number, payee.payee_id_type_code, payee.payee_birth_date, payee.payee_gender,
    (SELECT name_firstpart || '-' || name_lastpart FROM cadastre.cadastre_object WHERE id = b.cadastre_object_id LIMIT 1) AS parcel_number,
    (SELECT size FROM cadastre.spatial_value_area WHERE spatial_unit_id = b.cadastre_object_id AND type_code='officialArea' LIMIT 1) AS area,
    administrative.get_remaining_months(r.registration_date, administrative.get_financial_start_date(r.registration_date)) * r.ground_rent/ 12 as pro_rated_groud_rent
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
$BODY$
  LANGUAGE sql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION administrative.get_leases_by_dates(date, date)
  OWNER TO postgres;
GRANT EXECUTE ON FUNCTION administrative.get_leases_by_dates(date, date) TO postgres;
GRANT EXECUTE ON FUNCTION administrative.get_leases_by_dates(date, date) TO public;
GRANT EXECUTE ON FUNCTION administrative.get_leases_by_dates(date, date) TO accpac_reader;

-- Function: administrative.get_current_lease(character varying)

DROP FUNCTION administrative.get_current_lease(character varying);

CREATE OR REPLACE FUNCTION administrative.get_current_lease(IN character varying)
  RETURNS TABLE(ba_unit_id character varying, right_status character varying, right_status_date timestamp without time zone, right_id character varying, right_type character varying, registration_date timestamp without time zone, registration_number character varying, expiration_date timestamp without time zone, right_tracking_number character varying, ground_rent numeric, land_use_code character varying, lease_number character varying, start_date date, execution_date date, land_usable numeric, personal_levy numeric, stamp_duty numeric, transfer_duty numeric, registration_fee numeric, service_fee numeric, owners text, payee_id character varying, payee_name character varying, payee_last_name character varying, payee_address character varying, payee_phone character varying, payee_mobile character varying, payee_email character varying, payee_id_number character varying, payee_id_type_code character varying, payee_birth_date date, payee_gender character varying, parcel_number text, area numeric, pro_rated_groud_rent numeric) AS
$BODY$ 
select * from administrative.get_lease($1, 'current')
$BODY$
  LANGUAGE sql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION administrative.get_current_lease(character varying)
  OWNER TO postgres;
GRANT EXECUTE ON FUNCTION administrative.get_current_lease(character varying) TO public;
GRANT EXECUTE ON FUNCTION administrative.get_current_lease(character varying) TO postgres;
GRANT EXECUTE ON FUNCTION administrative.get_current_lease(character varying) TO accpac_reader;


-- Function: administrative.get_pending_lease(character varying)

DROP FUNCTION administrative.get_pending_lease(character varying);

CREATE OR REPLACE FUNCTION administrative.get_pending_lease(IN character varying)
  RETURNS TABLE(ba_unit_id character varying, right_status character varying, right_status_date timestamp without time zone, right_id character varying, right_type character varying, registration_date timestamp without time zone, registration_number character varying, expiration_date timestamp without time zone, right_tracking_number character varying, ground_rent numeric, land_use_code character varying, lease_number character varying, start_date date, execution_date date, land_usable numeric, personal_levy numeric, stamp_duty numeric, transfer_duty numeric, registration_fee numeric, service_fee numeric, owners text, payee_id character varying, payee_name character varying, payee_last_name character varying, payee_address character varying, payee_phone character varying, payee_mobile character varying, payee_email character varying, payee_id_number character varying, payee_id_type_code character varying, payee_birth_date date, payee_gender character varying, parcel_number text, area numeric, pro_rated_groud_rent numeric) AS
$BODY$ 
select * from administrative.get_lease($1, 'pending')
$BODY$
  LANGUAGE sql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION administrative.get_pending_lease(character varying)
  OWNER TO postgres;
GRANT EXECUTE ON FUNCTION administrative.get_pending_lease(character varying) TO postgres;
GRANT EXECUTE ON FUNCTION administrative.get_pending_lease(character varying) TO public;
GRANT EXECUTE ON FUNCTION administrative.get_pending_lease(character varying) TO accpac_reader;