-- Function: application.getresponsetime(character varying, character varying)

DROP FUNCTION IF EXISTS application.getresponsetime(character varying, character varying);

CREATE OR REPLACE FUNCTION application.getresponsetime(fromdate character varying, todate character varying)
  RETURNS SETOF record AS
$BODY$
DECLARE 
   request_type  varchar;
   service_count  integer:=0;
   total_time  integer:=0;
   average_time  float:=0 ;
   frequent_day integer:=0;
   std_deviation integer:=0;
   min_days integer:=0;
   max_days integer:=0;
   rng integer:=0;
   rec record;
   recToReturn record;
   sqlSt varchar;
   
BEGIN
	sqlSt = 'WITH results_table as (

	WITH new_table AS (SELECT id, application_id, request_type_code, r.display_value AS request_type, lodging_datetime::date,
	change_time::date, application.count_workdays(lodging_datetime::date,change_time::date) AS lead_time, status_code
	FROM application.service, application.request_type r
	WHERE status_code = ''completed''
	AND request_type_code = r.code 
	ORDER BY request_type_code)

	SELECT nt.request_type, COUNT(*) AS service_count, SUM(nt.lead_time) AS total_time, application.mode(nt.lead_time) as frequent_day, stddev(nt.lead_time) as stddev,
	min(lead_time) as minimum, max(lead_time) as maximum
	FROM application.service ser, new_table nt
	WHERE ser.request_type_code = nt.request_type_code
	AND ser.application_id = nt.application_id
	AND ser.lodging_datetime BETWEEN to_date('''|| $1 ||''',''yyyy-mm-dd'')  and to_date('''|| $2 ||''',''yyyy-mm-dd'')
	GROUP BY nt.request_type)
	--standard deviation is a measure of the average distance of the values in the data set from their mean
	SELECT request_type, service_count, total_time, round(total_time/service_count::float)::float AS average_time, frequent_day, round(stddev) as stddev, minimum, maximum,
	 (maximum - minimum) as rng
	FROM results_table order by request_type';
			
	FOR rec in EXECUTE sqlSt loop
	    request_type:=rec.request_type;
	    service_count:=rec.service_count;
	    total_time:=rec.total_time;
	    average_time:=rec.average_time;
	    frequent_day:=rec.frequent_day;
            std_deviation:=rec.stddev;
	    min_days:=rec.minimum;
	    max_days:=rec.maximum;
	    rng:=rec.rng;
		
	    select into recToReturn request_type::varchar, service_count::integer, total_time::integer, round(average_time::float), frequent_day::integer, std_deviation::integer
	    ,min_days::integer, max_days::integer, rng::integer;        
	    return next recToReturn;
	    
	end loop;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 10000;
ALTER FUNCTION application.getresponsetime(character varying, character varying)
  OWNER TO postgres;

  

/*select * from application.getResponseTime('2013-01-09' ,'2014-01-24')
        AS ResponseTimeReport(request_type varchar, service_count integer, total_time integer, average_time float, frequent_day integer, std_deviation integer
	    ,min_days integer, max_days integer, rng integer);

*/








        
