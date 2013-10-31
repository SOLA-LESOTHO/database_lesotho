-- Function: application.getresponsetime(character varying, character varying)

-- DROP FUNCTION application.getresponsetime(character varying, character varying);

CREATE OR REPLACE FUNCTION application.getresponsetime(fromdate character varying, todate character varying)
  RETURNS SETOF record AS
$BODY$
DECLARE 
   request_type  varchar;
   service_count  integer:=0;
   total_time  integer:=0;
   average_time  float:=0 ;
   rec record;
   recToReturn record;
   sqlSt varchar;
   
BEGIN
	sqlSt = 'WITH results_table as (

	WITH new_table AS (SELECT id, application_id, request_type_code, r.display_value AS request_type, lodging_datetime::date, change_time::date, (change_time::date - lodging_datetime::date)+1 AS lead_time, status_code
	FROM application.service, application.request_type r
	WHERE status_code = ''completed''
	AND request_type_code = r.code
	ORDER BY request_type_code)

	SELECT nt.request_type, COUNT(*) AS service_count, SUM(nt.lead_time) AS total_time
	FROM application.service ser, new_table nt
	WHERE ser.request_type_code = nt.request_type_code
	AND ser.application_id = nt.application_id
	AND ser.lodging_datetime BETWEEN to_date('''|| fromDate || ''',''yyyy-mm-dd'')  and to_date('''|| toDate || ''',''yyyy-mm-dd'')
	GROUP BY nt.request_type)

SELECT request_type, service_count, total_time, (total_time/service_count::float) AS average_time
FROM results_table';
			
	FOR rec in EXECUTE sqlSt loop
	    request_type:= rec.request_type;
	    service_count:= rec.service_count;
		total_time:=rec.total_time;
		average_time:=rec.average_time;
		
		select into recToReturn request_type::varchar, service_count::integer, total_time::integer, average_time::float;        
		return next recToReturn;
	end loop;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 10000;
ALTER FUNCTION application.getresponsetime(character varying, character varying)
  OWNER TO postgres;
