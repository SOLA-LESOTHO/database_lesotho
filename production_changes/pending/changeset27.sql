--DROP FUNCTION IF EXISTS administrative.registration_report(varchar,varchar);
CREATE OR REPLACE FUNCTION administrative.registration_report(varchar,varchar)
  RETURNS TABLE(service_name varchar, service_count integer, males integer, females integer,
  entities integer, joint integer, total_amount float, stamp_duty float,
	transfer_duty float, registration_fee float) AS
$BODY$
BEGIN
	return query execute '
	select * from administrative.transfer_lease_report('''||$1||''','''||$2||''') AS report(service_name varchar, service_count integer, males integer, females integer,
	entities integer, joint integer, total_amount float, stamp_duty float,
	transfer_duty float, registration_fee float) union

	select * from administrative.mortgage_report('''||$1||''','''||$2||''') AS report(service_name varchar, service_count integer, males integer, females integer,
	entities integer, joint integer, total_amount float, stamp_duty float,
	transfer_duty float, registration_fee float) union

	select * from administrative.sub_lease_report('''||$1||''','''||$2||''') AS report(service_name varchar, service_count integer, males integer, females integer,
	entities integer, joint integer, total_amount float, stamp_duty float,
	transfer_duty float, registration_fee float) union

	select * from administrative.lease_report('''||$1||''','''||$2||''') AS report(service_name varchar, service_count integer, males integer, females integer,
	entities integer, joint integer, total_amount float, stamp_duty float,
	transfer_duty float, registration_fee float) union

	select * from administrative.surrender_lease_report('''||$1||''','''||$2||''') AS report(service_name varchar, service_count integer, males integer, females integer,
	entities integer, joint integer, total_amount float, stamp_duty float,
	transfer_duty float, registration_fee float) union

	select * from administrative.vary_lease_report('''||$1||''','''||$2||''') AS report(service_name varchar, service_count integer, males integer, females integer,
	entities integer, joint integer, total_amount float, stamp_duty float,
	transfer_duty float, registration_fee float) union

	select * from administrative.cancel_mortgage_report('''||$1||''','''||$2||''') AS report(service_name varchar, service_count integer, males integer, females integer,
	entities integer, joint integer, total_amount float, stamp_duty float,
	transfer_duty float, registration_fee float) union

	select * from administrative.endorse_right_report('''||$1||''','''||$2||''') AS report(service_name varchar, service_count integer, males integer, females integer,
	entities integer, joint integer, total_amount float, stamp_duty float,
	transfer_duty float, registration_fee float);

	';
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 10000;

select * from administrative.registration_report('2013-02-11','2014-02-27') order by service_name