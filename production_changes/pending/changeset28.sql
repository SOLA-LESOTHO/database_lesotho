-- Function: system.is_not_manager(character varying)

-- DROP FUNCTION system.is_not_manager(character varying);

CREATE OR REPLACE FUNCTION system.is_not_manager(character varying)
  RETURNS boolean AS
$BODY$
declare
	user_id varchar;
begin
	select id into user_id from system.appuser where username = $1;

	if user_id in (select appuser_id from system.appuser_appgroup where appgroup_id = 'manager-id') then
		return false;
	else 
		return true;
	end if;
end
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION system.is_not_manager(character varying)
  OWNER TO postgres;

-- Function: system.is_manager(character varying)

-- DROP FUNCTION system.is_manager(character varying);

CREATE OR REPLACE FUNCTION system.is_manager(character varying)
  RETURNS boolean AS
$BODY$
declare
	user_id varchar;
begin
	select id into user_id from system.appuser where username = $1;

	if user_id in (select appuser_id from system.appuser_appgroup where appgroup_id = 'manager-id') then
		return true;
	else 
		return false;
	end if;
end
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION system.is_manager(character varying)
  OWNER TO postgres;

-- Function: system.is_lease_coord(character varying)

-- DROP FUNCTION system.is_lease_coord(character varying);

CREATE OR REPLACE FUNCTION system.is_lease_coord(character varying)
  RETURNS boolean AS
$BODY$

begin
	
	if $1 in (select appuser_id from system.appuser_appgroup where appgroup_id = 'lease-id') then
		return true;
	else 
		return false;
	end if;
end
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION system.is_lease_coord(character varying)
  OWNER TO postgres;

-- Function: system.is_customer_rep(character varying)

-- DROP FUNCTION system.is_customer_rep(character varying);

CREATE OR REPLACE FUNCTION system.is_customer_rep(character varying)
  RETURNS boolean AS
$BODY$

begin
	
	if $1 in (select appuser_id from system.appuser_appgroup where appgroup_id = 'cust-reps-id') 
	and $1 not in (select appuser_id from system.appuser_appgroup where appgroup_id = 'manager-id') then
		return true;
	else 
		return false;
	end if;
end
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION system.is_customer_rep(character varying)
  OWNER TO postgres;

DROP FUNCTION IF EXISTS application.customer_services_report( date, date);
CREATE OR REPLACE FUNCTION application.customer_services_report( date, date)
  RETURNS TABLE(application varchar, lodged int, queried int, awaiting_collection int, collected int) AS
$BODY$ 
DECLARE

BEGIN
return query

	WITH app_lodged AS (with requests as (
	select ser.id service_id, application_id, ser.request_type_code request_type, ser.status_code service_status, app.status_code application_status,
	ser.change_user service_user, app.change_user app_user, app.stage_code app_stage, app.lodging_datetime, app.change_time
	from application.service as ser 
	inner join application.application as app on ser.application_id = app.id 
	where ser.status_code = 'lodged' and app.status_code = 'lodged'
	and app.lodging_datetime BETWEEN $1 and $2 
	order by ser.request_type_code)
	select request.display_value, count(*) as application_count
	from requests 
	inner join application.request_type as request on requests.request_type = request.code group by request_type ,request.display_value),

	app_queried AS (with requests as (
	select ser.id service_id, application_id, ser.request_type_code request_type, ser.status_code service_status, app.status_code application_status,
	ser.change_user service_user, app.change_user app_user, app.stage_code app_stage, app.lodging_datetime, app.change_time
	from application.service as ser 
	inner join application.application as app on ser.application_id = app.id 
	where system.is_manager(app.change_user) and system.is_customer_rep(app.assignee_id) 
	and app.status_code = 'lodged' and ser.status_code = 'lodged'
	and app.lodging_datetime BETWEEN $1 and $2 
	order by ser.request_type_code)
	select request.display_value, count(*) as application_count
	from requests 
	inner join application.request_type as request on requests.request_type = request.code group by request_type ,request.display_value), 

	
	collection AS (with requests as (
	select ser.id service_id, application_id, ser.request_type_code request_type, ser.status_code service_status, app.status_code application_status,
	ser.change_user service_user, app.change_user app_user, app.stage_code app_stage, app.lodging_datetime, app.change_time
	from application.service as ser 
	inner join application.application as app on ser.application_id = app.id 
	where app.status_code = 'approved' and app.stage_code = 'collection' 
	and app.lodging_datetime BETWEEN $1 and $2 
	order by ser.request_type_code)
	select request.display_value, count(*) as application_count
	from requests 
	inner join application.request_type as request on requests.request_type = request.code group by request_type ,request.display_value),

	collected AS (with requests as (
	select ser.id service_id, application_id, ser.request_type_code request_type, ser.status_code service_status, app.status_code application_status,
	ser.change_user service_user, app.change_user app_user, app.stage_code app_stage, app.lodging_datetime, app.change_time
	from application.service as ser inner join application.application as app on ser.application_id = app.id 
	where app.status_code = 'completed'  
	and app.lodging_datetime BETWEEN $1 and $2 
	order by ser.request_type_code)
	select request.display_value, count(*) as application_count
	from requests 
	inner join application.request_type as request on requests.request_type = request.code group by request_type ,request.display_value)
	
	select distinct rt.display_value, (
	select application_count from app_lodged 
	where app_lodged.display_value = rt.display_value)::int as lodged,
	(select application_count from app_queried 
	where app_queried.display_value = rt.display_value)::int as queried,
	(select application_count from collection 
	where collection.display_value = rt.display_value)::int as awaiting_collection,
	(select application_count from collected 
	where collected.display_value = rt.display_value)::int as collected
	from application.request_type as rt, application.service as ser 
	where rt.code = ser.request_type_code and rt.request_category_code in ('registrationServices','leaseServices') 
	order by rt.display_value; 
      

           
END;
$BODY$
  LANGUAGE plpgsql VOLATILE;

 /*select * from application.customer_services_report( '2014-01-02', '2014-03-21') ;*/


  /*select * from application.service ser, application.application app where ser.application_id = app.id and ser.request_type_code = 'consentApplication' 
  and app.stage_code='appCorrection' --and app.id not in (select id from application.application_historic)
*/





  