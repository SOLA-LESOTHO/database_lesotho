DROP FUNCTION IF EXISTS administrative.transfer_lease_data(varchar,varchar);
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