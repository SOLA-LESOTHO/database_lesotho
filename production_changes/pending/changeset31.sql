-- Function: application.lease_services_report(date, date)
DROP FUNCTION application.application_stages_report(date, date, varchar);

CREATE OR REPLACE FUNCTION application.application_stages_report(IN date, IN date, varchar)
  RETURNS TABLE(application varchar, app_lodged integer, to_be_processed integer, missing_plot integer, area_mismatch integer, queried integer, bind_draft integer, check_draft integer, log_draft integer,
executive_to_sign integer, app_to_be_approved integer, customer_to_sign integer, to_be_archived integer, call_customer integer, collected_by_customer integer, to_be_registered integer
) AS
$BODY$ 
DECLARE

BEGIN


if $3 is not null then

return query

	WITH app_lodged AS (with requests as (
	select ser.id service_id, application_id, ser.request_type_code request_type, request_category_code category, ser.status_code service_status, app.status_code application_status,
	ser.change_user service_user, app.change_user app_user, app.stage_code app_stage, app.lodging_datetime, app.change_time
	from application.service ser, application.application app, application.request_type req_type
	where ser.application_id = app.id and ser.request_type_code = req_type.code
	and app.stage_code = 'newApp' and ser.request_type_code = $3
	and app.change_time BETWEEN $1 and $2 
	order by ser.request_type_code)
	select request.display_value, count(*) as application_count
	from requests inner join application.request_type as request on requests.request_type = request.code group by request_type ,request.display_value),

	app_to_be_approved AS (with requests as (
	select ser.id service_id, application_id, ser.request_type_code request_type, request_category_code category, ser.status_code service_status, app.status_code application_status,
	ser.change_user service_user, app.change_user app_user, app.stage_code app_stage, app.lodging_datetime, app.change_time
	from application.service ser, application.application app, application.request_type req_type
	where ser.application_id = app.id and ser.request_type_code = req_type.code
	and app.stage_code = 'appApprove' and ser.request_type_code = $3
	and app.change_time BETWEEN $1 and $2 
	order by ser.request_type_code)
	select request.display_value, count(*) as application_count
	from requests inner join application.request_type as request on requests.request_type = request.code group by request_type ,request.display_value),


	
	to_be_archived AS (with requests as (
	select ser.id service_id, application_id, ser.request_type_code request_type, request_category_code category, ser.status_code service_status, app.status_code application_status,
	ser.change_user service_user, app.change_user app_user, app.stage_code app_stage, app.lodging_datetime, app.change_time
	from application.service ser, application.application app, application.request_type req_type
	where ser.application_id = app.id and ser.request_type_code = req_type.code
	and app.stage_code = 'appArchive' and ser.request_type_code = $3
	and app.change_time BETWEEN $1 and $2 
	order by ser.request_type_code)
	select request.display_value, count(*) as application_count
	from requests inner join application.request_type as request on requests.request_type = request.code group by request_type ,request.display_value),


	customer_to_sign AS (with requests as (
	select ser.id service_id, application_id, ser.request_type_code request_type, request_category_code category, ser.status_code service_status, app.status_code application_status,
	ser.change_user service_user, app.change_user app_user, app.stage_code app_stage, app.lodging_datetime, app.change_time
	from application.service ser, application.application app, application.request_type req_type
	where ser.application_id = app.id and ser.request_type_code = req_type.code
	and app.stage_code = 'custSign' and ser.request_type_code = $3
	and app.change_time BETWEEN $1 and $2 
	order by ser.request_type_code)
	select request.display_value, count(*) as application_count
	from requests inner join application.request_type as request on requests.request_type = request.code group by request_type ,request.display_value),


	collected_by_customer AS (with requests as (
	select ser.id service_id, application_id, ser.request_type_code request_type, request_category_code category, ser.status_code service_status, app.status_code application_status,
	ser.change_user service_user, app.change_user app_user, app.stage_code app_stage, app.lodging_datetime, app.change_time
	from application.service ser, application.application app, application.request_type req_type
	where ser.application_id = app.id and ser.request_type_code = req_type.code
	and app.stage_code = 'custCollect' and ser.request_type_code = $3
	and app.change_time BETWEEN $1 and $2 
	order by ser.request_type_code)
	select request.display_value, count(*) as application_count
	from requests inner join application.request_type as request on requests.request_type = request.code group by request_type ,request.display_value),


	call_customer AS (with requests as (
	select ser.id service_id, application_id, ser.request_type_code request_type, request_category_code category, ser.status_code service_status, app.status_code application_status,
	ser.change_user service_user, app.change_user app_user, app.stage_code app_stage, app.lodging_datetime, app.change_time
	from application.service ser, application.application app, application.request_type req_type
	where ser.application_id = app.id and ser.request_type_code = req_type.code
	and app.stage_code = 'callCustomer' and ser.request_type_code = $3
	and app.change_time BETWEEN $1 and $2 
	order by ser.request_type_code)
	select request.display_value, count(*) as application_count
	from requests inner join application.request_type as request on requests.request_type = request.code group by request_type ,request.display_value),


	queried AS (with requests as (
	select ser.id service_id, application_id, ser.request_type_code request_type, request_category_code category, ser.status_code service_status, app.status_code application_status,
	ser.change_user service_user, app.change_user app_user, app.stage_code app_stage, app.lodging_datetime, app.change_time
	from application.service ser, application.application app, application.request_type req_type
	where ser.application_id = app.id and ser.request_type_code = req_type.code
	and app.stage_code = 'appInfoIncorrect' and ser.request_type_code = $3
	and app.change_time BETWEEN $1 and $2 
	order by ser.request_type_code)
	select request.display_value, count(*) as application_count
	from requests inner join application.request_type as request on requests.request_type = request.code group by request_type ,request.display_value),

	to_be_processed AS (with requests as (
	select ser.id service_id, application_id, ser.request_type_code request_type, request_category_code category, ser.status_code service_status, app.status_code application_status,
	ser.change_user service_user, app.change_user app_user, app.stage_code app_stage, app.lodging_datetime, app.change_time
	from application.service ser, application.application app, application.request_type req_type
	where ser.application_id = app.id and ser.request_type_code = req_type.code
	and app.stage_code = 'appProcess' and ser.request_type_code = $3
	and app.change_time BETWEEN $1 and $2 
	order by ser.request_type_code)
	select request.display_value, count(*) as application_count
	from requests inner join application.request_type as request on requests.request_type = request.code group by request_type ,request.display_value),

	to_be_registered AS (with requests as (
	select ser.id service_id, application_id, ser.request_type_code request_type, request_category_code category, ser.status_code service_status, app.status_code application_status,
	ser.change_user service_user, app.change_user app_user, app.stage_code app_stage, app.lodging_datetime, app.change_time
	from application.service ser, application.application app, application.request_type req_type
	where ser.application_id = app.id and ser.request_type_code = req_type.code
	and app.stage_code = 'appRegister' and ser.request_type_code = $3
	and app.change_time BETWEEN $1 and $2 
	order by ser.request_type_code)
	select request.display_value, count(*) as application_count
	from requests inner join application.request_type as request on requests.request_type = request.code group by request_type ,request.display_value),

	missing_plot AS (with requests as (
	select ser.id service_id, application_id, ser.request_type_code request_type, request_category_code category, ser.status_code service_status, app.status_code application_status,
	ser.change_user service_user, app.change_user app_user, app.stage_code app_stage, app.lodging_datetime, app.change_time
	from application.service ser, application.application app, application.request_type req_type
	where ser.application_id = app.id and ser.request_type_code = req_type.code
	and app.stage_code = 'missingPlot' and ser.request_type_code = $3
	and app.change_time BETWEEN $1 and $2 
	order by ser.request_type_code)
	select request.display_value, count(*) as application_count
	from requests inner join application.request_type as request on requests.request_type = request.code group by request_type ,request.display_value),

	area_mismatch AS (with requests as (
	select ser.id service_id, application_id, ser.request_type_code request_type, request_category_code category, ser.status_code service_status, app.status_code application_status,
	ser.change_user service_user, app.change_user app_user, app.stage_code app_stage, app.lodging_datetime, app.change_time
	from application.service ser, application.application app, application.request_type req_type
	where ser.application_id = app.id and ser.request_type_code = req_type.code
	and app.stage_code = 'areaMismatch' and ser.request_type_code = $3
	and app.change_time BETWEEN $1 and $2 
	order by ser.request_type_code)
	select request.display_value, count(*) as application_count
	from requests inner join application.request_type as request on requests.request_type = request.code group by request_type ,request.display_value),

	executive_to_sign AS (with requests as (
	select ser.id service_id, application_id, ser.request_type_code request_type, request_category_code category, ser.status_code service_status, app.status_code application_status,
	ser.change_user service_user, app.change_user app_user, app.stage_code app_stage, app.lodging_datetime, app.change_time
	from application.service ser, application.application app, application.request_type req_type
	where ser.application_id = app.id and ser.request_type_code = req_type.code
	and app.stage_code = 'appProcess' 
	and app.change_time BETWEEN $1 and $2 
	order by ser.request_type_code)
	select request.display_value, count(*) as application_count
	from requests inner join application.request_type as request on requests.request_type = request.code group by request_type ,request.display_value),

	bind_draft AS (with requests as (
	select ser.id service_id, application_id, ser.request_type_code request_type, request_category_code category, ser.status_code service_status, app.status_code application_status,
	ser.change_user service_user, app.change_user app_user, app.stage_code app_stage, app.lodging_datetime, app.change_time
	from application.service ser, application.application app, application.request_type req_type
	where ser.application_id = app.id and ser.request_type_code = req_type.code
	and app.stage_code = 'bindDraft' and ser.request_type_code = $3
	and app.change_time BETWEEN $1 and $2 
	order by ser.request_type_code)
	select request.display_value, count(*) as application_count
	from requests inner join application.request_type as request on requests.request_type = request.code group by request_type ,request.display_value),

	check_draft AS (with requests as (
	select ser.id service_id, application_id, ser.request_type_code request_type, request_category_code category, ser.status_code service_status, app.status_code application_status,
	ser.change_user service_user, app.change_user app_user, app.stage_code app_stage, app.lodging_datetime, app.change_time
	from application.service ser, application.application app, application.request_type req_type
	where ser.application_id = app.id and ser.request_type_code = req_type.code
	and app.stage_code = 'checkDraft	' and ser.request_type_code = $3
	and app.change_time BETWEEN $1 and $2 
	order by ser.request_type_code)
	select request.display_value, count(*) as application_count
	from requests inner join application.request_type as request on requests.request_type = request.code group by request_type ,request.display_value),

	log_draft AS (with requests as (
	select ser.id service_id, application_id, ser.request_type_code request_type, request_category_code category, ser.status_code service_status, app.status_code application_status,
	ser.change_user service_user, app.change_user app_user, app.stage_code app_stage, app.lodging_datetime, app.change_time
	from application.service ser, application.application app, application.request_type req_type
	where ser.application_id = app.id and ser.request_type_code = req_type.code
	and app.stage_code = 'logDraft' and ser.request_type_code = $3
	and app.change_time BETWEEN $1 and $2 
	order by ser.request_type_code)
	select request.display_value, count(*) as application_count
	from requests inner join application.request_type as request on requests.request_type = request.code group by request_type ,request.display_value),

	exec_to_sign AS (with requests as (
	select ser.id service_id, application_id, ser.request_type_code request_type, request_category_code category, ser.status_code service_status, app.status_code application_status,
	ser.change_user service_user, app.change_user app_user, app.stage_code app_stage, app.lodging_datetime, app.change_time
	from application.service ser, application.application app, application.request_type req_type
	where ser.application_id = app.id and ser.request_type_code = req_type.code
	and app.stage_code = 'executiveSign' and ser.request_type_code = $3
	and app.change_time BETWEEN $1 and $2 
	order by ser.request_type_code)
	select request.display_value, count(*) as application_count
	from requests inner join application.request_type as request on requests.request_type = request.code group by request_type ,request.display_value)
	

	select distinct rt.display_value, (select application_count
	from app_lodged 
	where app_lodged.display_value = rt.display_value)::int as lodged,
	(select application_count
	from to_be_processed
	where to_be_processed.display_value = rt.display_value)::int as to_be_processed,
	(select application_count
	from missing_plot
	where missing_plot.display_value = rt.display_value)::int as missing_plot,
	(select application_count 
	from area_mismatch 
	where area_mismatch.display_value = rt.display_value)::int as area_mismatch,
	(select application_count 
	from queried
	where queried.display_value = rt.display_value)::int as queried,
	(select application_count 
	from bind_draft
	where bind_draft.display_value = rt.display_value)::int as bind_draft,
	(select application_count
	from check_draft
	where check_draft.display_value = rt.display_value)::int as check_draft,
	(select application_count
	from log_draft 
	where log_draft.display_value = rt.display_value)::int as log_draft,
	(select application_count
	from executive_to_sign
	where executive_to_sign.display_value = rt.display_value)::int as executive_to_sign,
	(select application_count
	from app_to_be_approved
	where app_to_be_approved.display_value = rt.display_value)::int as app_to_be_approved,
	(select application_count
	from customer_to_sign 
	where customer_to_sign.display_value = rt.display_value)::int as customer_to_sign,
	(select application_count
	from to_be_archived 
	where to_be_archived.display_value = rt.display_value)::int as to_be_archived,
	(select application_count
	from call_customer
	where call_customer.display_value = rt.display_value)::int as call_customer,
	(select application_count
	from collected_by_customer
	where collected_by_customer.display_value = rt.display_value)::int as collected_by_customer,
	(select application_count
	from to_be_registered
	where to_be_registered.display_value = rt.display_value)::int as to_be_registered
	
	from application.request_type as rt, application.service as ser 
	where rt.code = ser.request_type_code order by rt.display_value;

else 
	return query

	WITH app_lodged AS (with requests as (
	select ser.id service_id, application_id, ser.request_type_code request_type, request_category_code category, ser.status_code service_status, app.status_code application_status,
	ser.change_user service_user, app.change_user app_user, app.stage_code app_stage, app.lodging_datetime, app.change_time
	from application.service ser, application.application app, application.request_type req_type
	where ser.application_id = app.id and ser.request_type_code = req_type.code
	and app.stage_code = 'newApp' 
	and app.change_time BETWEEN $1 and $2 
	order by ser.request_type_code)
	select request.display_value, count(*) as application_count
	from requests inner join application.request_type as request on requests.request_type = request.code group by request_type ,request.display_value),

	app_to_be_approved AS (with requests as (
	select ser.id service_id, application_id, ser.request_type_code request_type, request_category_code category, ser.status_code service_status, app.status_code application_status,
	ser.change_user service_user, app.change_user app_user, app.stage_code app_stage, app.lodging_datetime, app.change_time
	from application.service ser, application.application app, application.request_type req_type
	where ser.application_id = app.id and ser.request_type_code = req_type.code
	and app.stage_code = 'appApprove' 
	and app.change_time BETWEEN $1 and $2 
	order by ser.request_type_code)
	select request.display_value, count(*) as application_count
	from requests inner join application.request_type as request on requests.request_type = request.code group by request_type ,request.display_value),


	
	to_be_archived AS (with requests as (
	select ser.id service_id, application_id, ser.request_type_code request_type, request_category_code category, ser.status_code service_status, app.status_code application_status,
	ser.change_user service_user, app.change_user app_user, app.stage_code app_stage, app.lodging_datetime, app.change_time
	from application.service ser, application.application app, application.request_type req_type
	where ser.application_id = app.id and ser.request_type_code = req_type.code
	and app.stage_code = 'appArchive' 
	and app.change_time BETWEEN $1 and $2 
	order by ser.request_type_code)
	select request.display_value, count(*) as application_count
	from requests inner join application.request_type as request on requests.request_type = request.code group by request_type ,request.display_value),


	customer_to_sign AS (with requests as (
	select ser.id service_id, application_id, ser.request_type_code request_type, request_category_code category, ser.status_code service_status, app.status_code application_status,
	ser.change_user service_user, app.change_user app_user, app.stage_code app_stage, app.lodging_datetime, app.change_time
	from application.service ser, application.application app, application.request_type req_type
	where ser.application_id = app.id and ser.request_type_code = req_type.code
	and app.stage_code = 'custSign' 
	and app.change_time BETWEEN $1 and $2 
	order by ser.request_type_code)
	select request.display_value, count(*) as application_count
	from requests inner join application.request_type as request on requests.request_type = request.code group by request_type ,request.display_value),


	collected_by_customer AS (with requests as (
	select ser.id service_id, application_id, ser.request_type_code request_type, request_category_code category, ser.status_code service_status, app.status_code application_status,
	ser.change_user service_user, app.change_user app_user, app.stage_code app_stage, app.lodging_datetime, app.change_time
	from application.service ser, application.application app, application.request_type req_type
	where ser.application_id = app.id and ser.request_type_code = req_type.code
	and app.stage_code = 'custCollect' 
	and app.change_time BETWEEN $1 and $2 
	order by ser.request_type_code)
	select request.display_value, count(*) as application_count
	from requests inner join application.request_type as request on requests.request_type = request.code group by request_type ,request.display_value),


	call_customer AS (with requests as (
	select ser.id service_id, application_id, ser.request_type_code request_type, request_category_code category, ser.status_code service_status, app.status_code application_status,
	ser.change_user service_user, app.change_user app_user, app.stage_code app_stage, app.lodging_datetime, app.change_time
	from application.service ser, application.application app, application.request_type req_type
	where ser.application_id = app.id and ser.request_type_code = req_type.code
	and app.stage_code = 'callCustomer' 
	and app.change_time BETWEEN $1 and $2 
	order by ser.request_type_code)
	select request.display_value, count(*) as application_count
	from requests inner join application.request_type as request on requests.request_type = request.code group by request_type ,request.display_value),


	queried AS (with requests as (
	select ser.id service_id, application_id, ser.request_type_code request_type, request_category_code category, ser.status_code service_status, app.status_code application_status,
	ser.change_user service_user, app.change_user app_user, app.stage_code app_stage, app.lodging_datetime, app.change_time
	from application.service ser, application.application app, application.request_type req_type
	where ser.application_id = app.id and ser.request_type_code = req_type.code
	and app.stage_code = 'appInfoIncorrect' 
	and app.change_time BETWEEN $1 and $2 
	order by ser.request_type_code)
	select request.display_value, count(*) as application_count
	from requests inner join application.request_type as request on requests.request_type = request.code group by request_type ,request.display_value),

	to_be_processed AS (with requests as (
	select ser.id service_id, application_id, ser.request_type_code request_type, request_category_code category, ser.status_code service_status, app.status_code application_status,
	ser.change_user service_user, app.change_user app_user, app.stage_code app_stage, app.lodging_datetime, app.change_time
	from application.service ser, application.application app, application.request_type req_type
	where ser.application_id = app.id and ser.request_type_code = req_type.code
	and app.stage_code = 'appProcess' 
	and app.change_time BETWEEN $1 and $2 
	order by ser.request_type_code)
	select request.display_value, count(*) as application_count
	from requests inner join application.request_type as request on requests.request_type = request.code group by request_type ,request.display_value),

	executive_to_sign AS (with requests as (
	select ser.id service_id, application_id, ser.request_type_code request_type, request_category_code category, ser.status_code service_status, app.status_code application_status,
	ser.change_user service_user, app.change_user app_user, app.stage_code app_stage, app.lodging_datetime, app.change_time
	from application.service ser, application.application app, application.request_type req_type
	where ser.application_id = app.id and ser.request_type_code = req_type.code
	and app.stage_code = 'appProcess' 
	and app.change_time BETWEEN $1 and $2 
	order by ser.request_type_code)
	select request.display_value, count(*) as application_count
	from requests inner join application.request_type as request on requests.request_type = request.code group by request_type ,request.display_value),

	to_be_registered AS (with requests as (
	select ser.id service_id, application_id, ser.request_type_code request_type, request_category_code category, ser.status_code service_status, app.status_code application_status,
	ser.change_user service_user, app.change_user app_user, app.stage_code app_stage, app.lodging_datetime, app.change_time
	from application.service ser, application.application app, application.request_type req_type
	where ser.application_id = app.id and ser.request_type_code = req_type.code
	and app.stage_code = 'appRegister' 
	and app.change_time BETWEEN $1 and $2 
	order by ser.request_type_code)
	select request.display_value, count(*) as application_count
	from requests inner join application.request_type as request on requests.request_type = request.code group by request_type ,request.display_value),

	missing_plot AS (with requests as (
	select ser.id service_id, application_id, ser.request_type_code request_type, request_category_code category, ser.status_code service_status, app.status_code application_status,
	ser.change_user service_user, app.change_user app_user, app.stage_code app_stage, app.lodging_datetime, app.change_time
	from application.service ser, application.application app, application.request_type req_type
	where ser.application_id = app.id and ser.request_type_code = req_type.code
	and app.stage_code = 'missingPlot' 
	and app.change_time BETWEEN $1 and $2 
	order by ser.request_type_code)
	select request.display_value, count(*) as application_count
	from requests inner join application.request_type as request on requests.request_type = request.code group by request_type ,request.display_value),

	area_mismatch AS (with requests as (
	select ser.id service_id, application_id, ser.request_type_code request_type, request_category_code category, ser.status_code service_status, app.status_code application_status,
	ser.change_user service_user, app.change_user app_user, app.stage_code app_stage, app.lodging_datetime, app.change_time
	from application.service ser, application.application app, application.request_type req_type
	where ser.application_id = app.id and ser.request_type_code = req_type.code
	and app.stage_code = 'areaMismatch' 
	and app.change_time BETWEEN $1 and $2 
	order by ser.request_type_code)
	select request.display_value, count(*) as application_count
	from requests inner join application.request_type as request on requests.request_type = request.code group by request_type ,request.display_value),

	bind_draft AS (with requests as (
	select ser.id service_id, application_id, ser.request_type_code request_type, request_category_code category, ser.status_code service_status, app.status_code application_status,
	ser.change_user service_user, app.change_user app_user, app.stage_code app_stage, app.lodging_datetime, app.change_time
	from application.service ser, application.application app, application.request_type req_type
	where ser.application_id = app.id and ser.request_type_code = req_type.code
	and app.stage_code = 'bindDraft' 
	and app.change_time BETWEEN $1 and $2 
	order by ser.request_type_code)
	select request.display_value, count(*) as application_count
	from requests inner join application.request_type as request on requests.request_type = request.code group by request_type ,request.display_value),

	check_draft AS (with requests as (
	select ser.id service_id, application_id, ser.request_type_code request_type, request_category_code category, ser.status_code service_status, app.status_code application_status,
	ser.change_user service_user, app.change_user app_user, app.stage_code app_stage, app.lodging_datetime, app.change_time
	from application.service ser, application.application app, application.request_type req_type
	where ser.application_id = app.id and ser.request_type_code = req_type.code
	and app.stage_code = 'checkDraft' 
	and app.change_time BETWEEN $1 and $2 
	order by ser.request_type_code)
	select request.display_value, count(*) as application_count
	from requests inner join application.request_type as request on requests.request_type = request.code group by request_type ,request.display_value),

	log_draft AS (with requests as (
	select ser.id service_id, application_id, ser.request_type_code request_type, request_category_code category, ser.status_code service_status, app.status_code application_status,
	ser.change_user service_user, app.change_user app_user, app.stage_code app_stage, app.lodging_datetime, app.change_time
	from application.service ser, application.application app, application.request_type req_type
	where ser.application_id = app.id and ser.request_type_code = req_type.code
	and app.stage_code = 'logDraft' 
	and app.change_time BETWEEN $1 and $2 
	order by ser.request_type_code)
	select request.display_value, count(*) as application_count
	from requests inner join application.request_type as request on requests.request_type = request.code group by request_type ,request.display_value),

	exec_to_sign AS (with requests as (
	select ser.id service_id, application_id, ser.request_type_code request_type, request_category_code category, ser.status_code service_status, app.status_code application_status,
	ser.change_user service_user, app.change_user app_user, app.stage_code app_stage, app.lodging_datetime, app.change_time
	from application.service ser, application.application app, application.request_type req_type
	where ser.application_id = app.id and ser.request_type_code = req_type.code
	and app.stage_code = 'executiveSign' 
	and app.change_time BETWEEN $1 and $2 
	order by ser.request_type_code)
	select request.display_value, count(*) as application_count
	from requests inner join application.request_type as request on requests.request_type = request.code group by request_type ,request.display_value)
	

	select distinct rt.display_value, (select application_count
	from app_lodged 
	where app_lodged.display_value = rt.display_value)::int as lodged,
	(select application_count
	from to_be_processed
	where to_be_processed.display_value = rt.display_value)::int as to_be_processed,
	(select application_count
	from missing_plot
	where missing_plot.display_value = rt.display_value)::int as missing_plot,
	(select application_count 
	from area_mismatch
	where area_mismatch.display_value = rt.display_value)::int as area_mismatch,
	(select application_count 
	from queried
	where queried.display_value = rt.display_value)::int as queried,
	(select application_count 
	from bind_draft
	where bind_draft.display_value = rt.display_value)::int as bind_draft,
	(select application_count
	from check_draft
	where check_draft.display_value = rt.display_value)::int as check_draft,
	(select application_count
	from log_draft 
	where log_draft.display_value = rt.display_value)::int as log_draft,
	(select application_count
	from executive_to_sign
	where executive_to_sign.display_value = rt.display_value)::int as executive_to_sign,
	(select application_count
	from app_to_be_approved
	where app_to_be_approved.display_value = rt.display_value)::int as app_to_be_approved,
	(select application_count
	from customer_to_sign 
	where customer_to_sign.display_value = rt.display_value)::int as customer_to_sign,
	(select application_count
	from to_be_archived 
	where to_be_archived.display_value = rt.display_value)::int as to_be_archived,
	(select application_count
	from call_customer
	where call_customer.display_value = rt.display_value)::int as call_customer,
	(select application_count
	from collected_by_customer
	where collected_by_customer.display_value = rt.display_value)::int as collected_by_customer,
	(select application_count
	from to_be_registered
	where to_be_registered.display_value = rt.display_value)::int as to_be_registered
	
	from application.request_type as rt, application.service as ser 
	where rt.code = ser.request_type_code order by rt.display_value;
end if;

           
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION application.application_stages_report(date, date, varchar)
  OWNER TO postgres;

 /*select * from application.application_stages_report('2013-08-01', '2014-03-25','leaseServices')*/
