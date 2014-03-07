-----------------------------------------------------------administrative.transfer_lease_data(character varying, character varying)---------------------------------------------------------

--DROP FUNCTION IF EXISTS administrative.transfer_lease_data(varchar,varchar);
CREATE OR REPLACE FUNCTION administrative.transfer_lease_data(varchar,varchar)
  RETURNS TABLE(service varchar, gender varchar, kind varchar, status varchar, amount float, stamp_duty float ,transfer_duty float, registration_fee float) AS
$BODY$
BEGIN
	return query execute '(with transfers as (with holders as (with rights as(with apps as (select tr.id transaction_id, ser.id service_id, ser.request_type_code request, application_id
	from transaction.transaction as tr join application.service as ser on tr.from_service_id = ser.id) select  display_value, app.change_user,
	apps.transaction_id, rrr.id rrr_id, app.status_code,rrr.amount, rrr.stamp_duty, rrr.transfer_duty, rrr.registration_fee
	from application.application app, administrative.rrr as rrr,application.request_type as rt
	join apps on rt.code = apps.request where rt.code = ''newOwnership''
	and apps.application_id = app.id and app.status_code = ''approved''
	and rrr.transaction_id = apps.transaction_id
	and rrr.registration_date BETWEEN to_date('''|| $1 || ''',''yyyy-mm-dd'')  and to_date('''|| $2 || ''',''yyyy-mm-dd''))
	select display_value, pfr.party_id, rights.rrr_id, status_code, amount, stamp_duty, transfer_duty, registration_fee
	from administrative.party_for_rrr as pfr, rights 
	where pfr.rrr_id in (select rights.rrr_id))

	select holders.display_value service, gender_code gender, type_code, legal_type, amount::float, stamp_duty::float, transfer_duty::float, registration_fee::float
	from party.party, holders
	where party.id in (select holders.party_id))

	select * from transfers)';
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 10000;

/*select * from administrative.transfer_lease_data('2013-01-01','2014-02-27')*/

-----------------------------------------------------------administrative.mortgage_data(character varying, character varying)---------------------------------------------------------

-- DROP FUNCTION administrative.mortgage_data(character varying, character varying);

CREATE OR REPLACE FUNCTION administrative.mortgage_data(IN character varying, IN character varying)
  RETURNS TABLE(service character varying, gender character varying, kind character varying, status character varying, amount double precision, stamp_duty double precision, transfer_duty double precision, registration_fee double precision) AS
$BODY$
BEGIN
	return query execute '(with final_mortgages as (with mortgage as (with mortgages as (with holders as (with rights as(with apps as (select tr.id transaction_id, ser.id service_id, ser.request_type_code request, application_id
	from transaction.transaction as tr join application.service as ser on tr.from_service_id = ser.id) select  display_value, app.change_user,
	apps.transaction_id, rrr.id rrr_id, app.status_code,rrr.amount, rrr.stamp_duty, rrr.transfer_duty, rrr.registration_fee
	from application.application app, administrative.rrr as rrr,application.request_type as rt
	join apps on rt.code = apps.request where rt.code = ''mortgage'' 
	and apps.application_id = app.id and app.status_code = ''approved''
	and rrr.transaction_id = apps.transaction_id
	and rrr.registration_date BETWEEN to_date('''|| $1 || ''',''yyyy-mm-dd'')  and to_date('''|| $2 || ''',''yyyy-mm-dd''))
	select distinct rights.rrr_id, display_value, pfr.party_id, status_code, amount, stamp_duty, transfer_duty, registration_fee
	from administrative.party_for_rrr as pfr, rights 
	where pfr.rrr_id in (select rights.rrr_id)) 

	select holders.display_value service, gender_code gender, type_code, legal_type, rrr_id, amount::float, stamp_duty::float, transfer_duty::float, registration_fee::float
	from party.party, holders
	where party.id in (select holders.party_id))
	select * from mortgages)
	select distinct rrr_id, service, gender, type_code, legal_type, amount, stamp_duty, transfer_duty, registration_fee from mortgage)
	select service, gender, type_code, legal_type, amount, stamp_duty, transfer_duty, registration_fee from final_mortgages)';
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 10000;
ALTER FUNCTION administrative.mortgage_data(character varying, character varying)
  OWNER TO postgres;

  /*select * from administrative.mortgage_data('2013-01-01','2014-02-27')*/
  
  
-----------------------------------------------------------administrative.sub_lease_data(character varying, character varying)---------------------------------------------------------

 --DROP FUNCTION IF EXISTS administrative.sub_lease_data(varchar,varchar);
CREATE OR REPLACE FUNCTION administrative.sub_lease_data(varchar,varchar)
  RETURNS TABLE(service varchar, gender varchar, kind varchar, status varchar, amount float, stamp_duty float ,transfer_duty float, registration_fee float) AS
$BODY$
BEGIN
	return query execute 'with finale as (with mortgages as (with holders as (with rights as(with apps as (select tr.id transaction_id, ser.id service_id, ser.request_type_code request, application_id
	from transaction.transaction as tr join application.service as ser on tr.from_service_id = ser.id) select  display_value, app.change_user,
	apps.transaction_id, rrr.id rrr_id, app.status_code,rrr.amount, rrr.stamp_duty, rrr.transfer_duty, rrr.registration_fee
	from application.application app, administrative.rrr as rrr,application.request_type as rt
	join apps on rt.code = apps.request where rt.code = ''regSublease''
	and apps.application_id = app.id and app.status_code = ''approved''
	and rrr.registration_date BETWEEN to_date('''|| $1 || ''',''yyyy-mm-dd'')  and to_date('''|| $2 || ''',''yyyy-mm-dd'')
	and rrr.transaction_id = apps.transaction_id)
	select rights.rrr_id, display_value, pfr.party_id, status_code, amount, stamp_duty, transfer_duty, registration_fee
	from administrative.party_for_rrr as pfr, rights 
	where pfr.rrr_id in (select rights.rrr_id)) 

	select holders.display_value service, gender_code gender, type_code, legal_type, rrr_id, party.id party_id, amount::float, stamp_duty::float, transfer_duty::float, registration_fee::float
	from party.party, holders
	where party.id in (select holders.party_id))
	select rrr_id, mortgages.party_id, service, pr.type_code, gender, mortgages.type_code kind, legal_type status, amount, stamp_duty, transfer_duty, registration_fee
	from mortgages, party.party_role as pr where mortgages.party_id = pr.party_id and pr.type_code = ''accountHolder'')

	select service, gender, kind, status, amount, stamp_duty, transfer_duty, registration_fee from finale';

END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 10000;

/*select * from administrative.sub_lease_data('2013-01-01','2014-02-27')*/

-----------------------------------------------------------administrative.lease_data(character varying, character varying)---------------------------------------------------------

--DROP FUNCTION IF EXISTS administrative.lease_data(varchar,varchar);
CREATE OR REPLACE FUNCTION administrative.lease_data(varchar,varchar)
  RETURNS TABLE(service varchar, gender varchar, kind varchar, status varchar, amount float, stamp_duty float ,transfer_duty float, registration_fee float) AS
$BODY$
BEGIN
	return query execute 'with finale as (with mortgages as (with holders as (with rights as(with apps as (select tr.id transaction_id, ser.id service_id, ser.request_type_code request, application_id
	from transaction.transaction as tr join application.service as ser on tr.from_service_id = ser.id) select  display_value, app.change_user,
	apps.transaction_id, rrr.id rrr_id, app.status_code,rrr.amount, rrr.stamp_duty, rrr.transfer_duty, rrr.registration_fee
	from application.application app, administrative.rrr as rrr,application.request_type as rt
	join apps on rt.code = apps.request where rt.code = ''regOnLease''
	and apps.application_id = app.id and app.status_code = ''approved''
	and rrr.registration_date BETWEEN to_date('''|| $1 || ''',''yyyy-mm-dd'')  and to_date('''|| $2 || ''',''yyyy-mm-dd'')
	and rrr.transaction_id = apps.transaction_id)
	select rights.rrr_id, display_value, pfr.party_id, status_code, amount, stamp_duty, transfer_duty, registration_fee
	from administrative.party_for_rrr as pfr, rights 
	where pfr.rrr_id in (select rights.rrr_id)) 

	select holders.display_value service, gender_code gender, type_code, legal_type, rrr_id, party.id party_id, amount::float, stamp_duty::float, transfer_duty::float, registration_fee::float
	from party.party, holders
	where party.id in (select holders.party_id))
	select rrr_id, mortgages.party_id, service, pr.type_code, gender, mortgages.type_code kind, legal_type status, amount, stamp_duty, transfer_duty, registration_fee
	from mortgages, party.party_role as pr where mortgages.party_id = pr.party_id and pr.type_code = ''accountHolder'')

	select service, gender, kind, status, amount, stamp_duty, transfer_duty, registration_fee from finale';

END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 10000;

/*select * from administrative.lease_data('2013-01-01','2014-02-27')*/

-----------------------------------------------------------administrative.surrender_lease_data(character varying, character varying)---------------------------------------------------------


--DROP FUNCTION IF EXISTS administrative.surrender_lease_data(varchar,varchar);
CREATE OR REPLACE FUNCTION administrative.surrender_lease_data(varchar,varchar)
  RETURNS TABLE(service varchar, gender varchar, kind varchar, status varchar, amount float, stamp_duty float ,transfer_duty float, registration_fee float) AS
$BODY$
BEGIN
	return query execute 'with finale as (with mortgages as (with holders as (with rights as(with apps as (select tr.id transaction_id, ser.id service_id, ser.request_type_code request, application_id
	from transaction.transaction as tr join application.service as ser on tr.from_service_id = ser.id) select  display_value, app.change_user,
	apps.transaction_id, rrr.id rrr_id, app.status_code,rrr.amount, rrr.stamp_duty, rrr.transfer_duty, rrr.registration_fee
	from application.application app, administrative.rrr as rrr,application.request_type as rt
	join apps on rt.code = apps.request where rt.code = ''cancelProperty''
	and apps.application_id = app.id and app.status_code = ''approved''
	and rrr.registration_date BETWEEN to_date('''|| $1 || ''',''yyyy-mm-dd'')  and to_date('''|| $2 || ''',''yyyy-mm-dd'')
	and rrr.transaction_id = apps.transaction_id)
	select rights.rrr_id, display_value, pfr.party_id, status_code, amount, stamp_duty, transfer_duty, registration_fee
	from administrative.party_for_rrr as pfr, rights 
	where pfr.rrr_id in (select rights.rrr_id)) 

	select holders.display_value service, gender_code gender, type_code, legal_type, rrr_id, party.id party_id, amount::float, stamp_duty::float, transfer_duty::float, registration_fee::float
	from party.party, holders
	where party.id in (select holders.party_id))
	select rrr_id, mortgages.party_id, service, pr.type_code, gender, mortgages.type_code kind, legal_type status, amount, stamp_duty, transfer_duty, registration_fee
	from mortgages, party.party_role as pr where mortgages.party_id = pr.party_id and pr.type_code = ''accountHolder'')

	select service, gender, kind, status, amount, stamp_duty, transfer_duty, registration_fee from finale';

END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 10000;

/*select * from administrative.surrender_lease_data('2013-01-01','2014-02-27')*/


-----------------------------------------------------------administrative.vary_lease_data(character varying, character varying)---------------------------------------------------------


DROP FUNCTION IF EXISTS administrative.vary_lease_data(varchar,varchar);
CREATE OR REPLACE FUNCTION administrative.vary_lease_data(varchar,varchar)
  RETURNS TABLE(service varchar, gender varchar, kind varchar, status varchar, amount float, stamp_duty float ,transfer_duty float, registration_fee float) AS
$BODY$
BEGIN
	return query execute 'with finale as (with mortgages as (with holders as (with rights as(with apps as (select tr.id transaction_id, ser.id service_id, ser.request_type_code request, application_id
	from transaction.transaction as tr join application.service as ser on tr.from_service_id = ser.id) select  display_value, app.change_user,
	apps.transaction_id, rrr.id rrr_id, app.status_code,rrr.amount, rrr.stamp_duty, rrr.transfer_duty, rrr.registration_fee
	from application.application app, administrative.rrr as rrr,application.request_type as rt
	join apps on rt.code = apps.request where rt.code = ''varyLease''
	and apps.application_id = app.id and app.status_code = ''approved''
	and rrr.registration_date BETWEEN to_date('''|| $1 || ''',''yyyy-mm-dd'')  and to_date('''|| $2 || ''',''yyyy-mm-dd'')
	and rrr.transaction_id = apps.transaction_id)
	select rights.rrr_id, display_value, pfr.party_id, status_code, amount, stamp_duty, transfer_duty, registration_fee
	from administrative.party_for_rrr as pfr, rights 
	where pfr.rrr_id in (select rights.rrr_id)) 

	select holders.display_value service, gender_code gender, type_code, legal_type, rrr_id, party.id party_id, amount::float, stamp_duty::float, transfer_duty::float, registration_fee::float
	from party.party, holders
	where party.id in (select holders.party_id))
	select rrr_id, mortgages.party_id, service, pr.type_code, gender, mortgages.type_code kind, legal_type status, amount, stamp_duty, transfer_duty, registration_fee
	from mortgages, party.party_role as pr where mortgages.party_id = pr.party_id and pr.type_code = ''accountHolder'')

	select service, gender, kind, status, amount, stamp_duty, transfer_duty, registration_fee from finale';

END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 10000;

/*select * from administrative.vary_lease_data('2013-01-01','2014-02-27')*/


-----------------------------------------------------------administrative.cancel_mortgage_data(character varying, character varying)---------------------------------------------------------


--DROP FUNCTION IF EXISTS administrative.cancel_mortgage_data(varchar,varchar);
CREATE OR REPLACE FUNCTION administrative.cancel_mortgage_data(varchar,varchar)
  RETURNS TABLE(service varchar, gender varchar, kind varchar, status varchar, amount float, stamp_duty float ,transfer_duty float, registration_fee float) AS
$BODY$
BEGIN
	return query execute 'with finale as (with mortgages as (with holders as (with rights as(with apps as (select tr.id transaction_id, ser.id service_id, ser.request_type_code request, application_id
	from transaction.transaction as tr join application.service as ser on tr.from_service_id = ser.id) select  display_value, app.change_user,
	apps.transaction_id, rrr.id rrr_id, app.status_code,rrr.amount, rrr.stamp_duty, rrr.transfer_duty, rrr.registration_fee
	from application.application app, administrative.rrr as rrr,application.request_type as rt
	join apps on rt.code = apps.request where rt.code = ''cancelMortBonds''
	and apps.application_id = app.id and app.status_code = ''approved''
	and rrr.registration_date BETWEEN to_date('''|| $1 || ''',''yyyy-mm-dd'')  and to_date('''|| $2 || ''',''yyyy-mm-dd'')
	and rrr.transaction_id = apps.transaction_id)
	select rights.rrr_id, display_value, pfr.party_id, status_code, amount, stamp_duty, transfer_duty, registration_fee
	from administrative.party_for_rrr as pfr, rights 
	where pfr.rrr_id in (select rights.rrr_id)) 

	select holders.display_value service, gender_code gender, type_code, legal_type, rrr_id, party.id party_id, amount::float, stamp_duty::float, transfer_duty::float, registration_fee::float
	from party.party, holders
	where party.id in (select holders.party_id))
	select rrr_id, mortgages.party_id, service, pr.type_code, gender, mortgages.type_code kind, legal_type status, amount, stamp_duty, transfer_duty, registration_fee
	from mortgages, party.party_role as pr where mortgages.party_id = pr.party_id and pr.type_code = ''bank'')

	select service, gender, kind, status, amount, stamp_duty, transfer_duty, registration_fee from finale';

END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 10000;

/*select * from administrative.cancel_mortgage_data('2013-01-01','2014-02-27')*/


-----------------------------------------------------------administrative.endorse_right_data(character varying, character varying)---------------------------------------------------------


--DROP FUNCTION IF EXISTS administrative.endorse_right_data(varchar,varchar);
CREATE OR REPLACE FUNCTION administrative.endorse_right_data(varchar,varchar)
  RETURNS TABLE(service varchar, gender varchar, kind varchar, status varchar, amount float, stamp_duty float ,transfer_duty float, registration_fee float) AS
$BODY$
BEGIN
	return query execute 'with finale as (with mortgages as (with holders as (with rights as(with apps as (select tr.id transaction_id, ser.id service_id, ser.request_type_code request, application_id
	from transaction.transaction as tr join application.service as ser on tr.from_service_id = ser.id) select  display_value, app.change_user,
	apps.transaction_id, rrr.id rrr_id, app.status_code,rrr.amount, rrr.stamp_duty, rrr.transfer_duty, rrr.registration_fee
	from application.application app, administrative.rrr as rrr,application.request_type as rt
	join apps on rt.code = apps.request where rt.code = ''endorseRight''
	and apps.application_id = app.id and app.status_code = ''approved''
	and rrr.registration_date BETWEEN to_date('''|| $1 || ''',''yyyy-mm-dd'')  and to_date('''|| $2 || ''',''yyyy-mm-dd'')
	and rrr.transaction_id = apps.transaction_id)
	select rights.rrr_id, display_value, pfr.party_id, status_code, amount, stamp_duty, transfer_duty, registration_fee
	from administrative.party_for_rrr as pfr, rights 
	where pfr.rrr_id in (select rights.rrr_id)) 

	select holders.display_value service, gender_code gender, type_code, legal_type, rrr_id, party.id party_id, amount::float, stamp_duty::float, transfer_duty::float, registration_fee::float
	from party.party, holders
	where party.id in (select holders.party_id))
	select rrr_id, mortgages.party_id, service, pr.type_code, gender, mortgages.type_code kind, legal_type status, amount, stamp_duty, transfer_duty, registration_fee
	from mortgages, party.party_role as pr where mortgages.party_id = pr.party_id and pr.type_code = ''accountHolder'')

	select service, gender, kind, status, amount, stamp_duty, transfer_duty, registration_fee from finale';

END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 10000;

/*select * from administrative.endorse_right_data('2013-01-01','2014-02-27')*/



