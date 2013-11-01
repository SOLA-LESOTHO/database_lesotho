-- Function: application.getresponsetime(character varying, character varying)

-- DROP FUNCTION application.getresponsetime(character varying, character varying);

CREATE OR REPLACE FUNCTION application.count_weekend_days(start_date DATE, end_date DATE)
RETURNS INT AS
$$
	SELECT CAST(SUM(case when application.is_weekend_day($1 + ofs) then 1 else 0 end) as int)
from generate_series(0, $2 - $1) ofs
$$
LANGUAGE 'sql';

CREATE OR REPLACE FUNCTION application.is_weekend_day(fromdate DATE)
RETURNS BOOLEAN AS
$$
	SELECT CASE EXTRACT(DOW FROM $1)
		WHEN 0 THEN
			TRUE
		WHEN 6 THEN
			TRUE
		ELSE
			FALSE
		END
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION application.count_workdays(start_date DATE, end_date DATE)
RETURNS INT AS
$$ 
DECLARE
		lead_time integer:= (($2-$1) +1);
		weekend_days integer := application.count_weekend_days($1,$2);
		workdays integer := lead_time - weekend_days;
		
BEGIN

	RETURN workdays;
END;
$$
LANGUAGE 'plpgsql';

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

	WITH new_table AS (SELECT id, application_id, request_type_code, r.display_value AS request_type,
	lodging_datetime::date, change_time::date, application.count_workdays(lodging_datetime::date,change_time::date) AS lead_time, status_code
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
		
		select into recToReturn request_type::varchar, service_count::integer, total_time::integer, round(average_time::float);        
		return next recToReturn;
	end loop;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 10000;
ALTER FUNCTION application.getresponsetime(character varying, character varying)
  OWNER TO postgres;

  
select * from application.getresponsetime('2013-02-02','2014-01-14')
 AS ResponseTimeReport(request_type varchar, service_count integer, total_time integer, average_time float)