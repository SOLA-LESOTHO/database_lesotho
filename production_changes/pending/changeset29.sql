DROP FUNCTION IF EXISTS application.lease_services_report( date, date);
CREATE OR REPLACE FUNCTION application.lease_services_report( date, date)
  RETURNS TABLE(application varchar, ToBeProcessed int, InProgress int, queried int, cancelled int, processed int, approved int, overdue int) AS
$BODY$ 
DECLARE

BEGIN

return query

	WITH app_lodged AS (with requests as (
	select ser.id service_id, application_id, ser.request_type_code request_type, ser.status_code service_status, app.status_code application_status,
	ser.change_user service_user, app.change_user app_user, app.stage_code app_stage, app.lodging_datetime, app.change_time
	from application.service as ser 
	inner join application.application as app on ser.application_id = app.id 
	where app.status_code = 'lodged' and app.rowversion > 2
	and app.change_time BETWEEN $1 and $2 
	order by ser.request_type_code)
	select request.display_value, count(*) as application_count
	from requests inner join application.request_type as request on requests.request_type = request.code group by request_type ,request.display_value),

	app_queried AS (with requests as (
	select ser.id service_id, application_id, ser.request_type_code request_type, ser.status_code service_status, app.status_code application_status,
	ser.change_user service_user, app.change_user app_user, app.stage_code app_stage, app.lodging_datetime, app.change_time
	from application.service as ser 
	inner join application.application as app on ser.application_id = app.id 
	where ser.action_code = 'revert'  and app.rowversion > 2 or app.action_notes is not null
	and app.change_time BETWEEN $1 and $2 
	order by ser.request_type_code)
	select request.display_value, count(*) as application_count
	from requests inner join application.request_type as request on requests.request_type = request.code group by request_type ,request.display_value), 

	
	in_progress AS (with requests as (
	select ser.id service_id, application_id, ser.request_type_code request_type, ser.status_code service_status, app.status_code application_status,
	ser.change_user service_user, app.change_user app_user, app.stage_code app_stage, app.lodging_datetime, app.change_time
	from application.service as ser 
	inner join application.application as app on ser.application_id = app.id 
	where app.status_code = 'lodged' and ser.status_code = 'pending' and app.rowversion > 2 
	and app.change_time >= $1 
	order by ser.request_type_code)
	select request.display_value, count(*) as application_count
	from requests inner join application.request_type as request on requests.request_type = request.code group by request_type ,request.display_value),

	overdue AS (with requests as (
	select ser.id service_id, application_id, ser.request_type_code request_type, ser.status_code service_status, app.status_code application_status,
	ser.change_user service_user, app.change_user app_user, app.stage_code app_stage, app.lodging_datetime, app.change_time
	from application.service as ser 
	inner join application.application as app on ser.application_id = app.id 
	where app.status_code in ( 'lodged', 'requisitioned') and  app.rowversion > 2
	and app.change_time >= $1
	and ser.expected_completion_date < current_date
	order by ser.request_type_code)
	select request.display_value, count(*) as application_count
	from requests inner join application.request_type as request on requests.request_type = request.code group by request_type ,request.display_value),

	cancelled AS (with requests as (
	select ser.id service_id, application_id, ser.request_type_code request_type, ser.status_code service_status, app.status_code application_status,
	ser.change_user service_user, app.change_user app_user, app.stage_code app_stage, app.lodging_datetime, app.change_time
	from application.service as ser 
	inner join application.application as app on ser.application_id = app.id 
	where app.status_code = 'annulled'  
	and app.change_time BETWEEN $1 and $2 
	order by ser.request_type_code)
	select request.display_value, count(*) as application_count
	from requests inner join application.request_type as request on requests.request_type = request.code group by request_type ,request.display_value),

	processed AS (with requests as (
	select ser.id service_id, application_id, ser.request_type_code request_type, ser.status_code service_status, app.status_code application_status,
	ser.change_user service_user, app.change_user app_user, app.stage_code app_stage, app.lodging_datetime, app.change_time
	from application.service as ser 
	inner join application.application as app on ser.application_id = app.id 
	where ser.status_code = 'completed' 
	and app.change_time BETWEEN $1 and $2 
	order by ser.request_type_code)
	select request.display_value, count(*) as application_count
	from requests inner join application.request_type as request on requests.request_type = request.code group by request_type ,request.display_value), 

	approved AS (with requests as (
	select ser.id service_id, application_id, ser.request_type_code request_type, ser.status_code service_status, app.status_code application_status,
	ser.change_user service_user, app.change_user app_user, app.stage_code app_stage, app.lodging_datetime, app.change_time
	from application.service as ser 
	inner join application.application as app on ser.application_id = app.id 
	where app.status_code = 'approved'
	and app.change_time BETWEEN $1 and $2 
	order by ser.request_type_code)
	select request.display_value, count(*) as application_count
	from requests inner join application.request_type as request on requests.request_type = request.code group by request_type ,request.display_value) 

	select distinct rt.display_value, (select application_count from app_lodged where app_lodged.display_value = rt.display_value)::int as lodged,
	(select application_count from in_progress 
	where in_progress.display_value = rt.display_value)::int as in_progress,
	(select application_count from app_queried 
	where app_queried.display_value = rt.display_value)::int as queried,
	(select application_count from cancelled 
	where cancelled.display_value = rt.display_value)::int as cancelled,
	(select application_count from processed 
	where processed.display_value = rt.display_value)::int as processed,
	(select application_count from approved 
	where approved.display_value = rt.display_value)::int as approved,
	(select application_count from overdue 
	where overdue.display_value = rt.display_value)::int as overdue
	from application.request_type as rt, application.service as ser 
	where rt.code = ser.request_type_code and rt.request_category_code in ('registrationServices','leaseServices')
	order by rt.display_value;
           
END;
$BODY$
  LANGUAGE plpgsql VOLATILE;

 /*select * from application.lease_services_report( '2014-01-02', '2014-03-19')*/



  /*select * from application.service ser, application.application app where ser.application_id = app.id and ser.request_type_code = 'consentApplication' 
  and app.stage_code='appCorrection' --and app.id not in (select id from application.application_historic)
*/


