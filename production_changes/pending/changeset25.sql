DROP FUNCTION IF EXISTS administrative.mortgage_report(varchar,varchar);
CREATE OR REPLACE FUNCTION administrative.mortgage_report(varchar,varchar)
  RETURNS record AS
$BODY$
DECLARE 
	service_name  varchar;
	service_count  integer:=0;
	males  integer:=0;
	females integer:=0;
	entities integer:=0;
	joint integer:=0;
	total float:=0.0;
	stamp float:=0.0;
	transfer float:=0.0;
	registration float:=0.0;
	rec record;
	result record;
	sqlSt varchar;
   
BEGIN

	select service into service_name from  administrative.mortgage_data($1,$2) limit 1;
	select count(*) into service_count from  administrative.mortgage_data($1,$2);
	select count(*) into males from  administrative.mortgage_data($1,$2) where gender = 'male' and status != 'Married in community of property';
	select count(*) into females from  administrative.mortgage_data($1,$2) where gender = 'female' and status != 'Married in community of property';
	select count(*) into entities from  administrative.mortgage_data($1,$2) where kind = 'nonNaturalPerson';
	select count(*) into joint from  administrative.mortgage_data($1,$2) where status = 'Married in community of property';
	select sum(amount) into total from  administrative.mortgage_data($1,$2);
	select sum(stamp_duty) into stamp from  administrative.mortgage_data($1,$2);
	select sum(transfer_duty) into transfer from  administrative.mortgage_data($1,$2);
	select sum(registration_fee) into registration from  administrative.mortgage_data($1,$2);

	select into result service_name::varchar, service_count::integer, males::integer, females::integer, entities::integer, joint::integer, total::float, stamp::float,
	transfer::float, registration::float;

	return result;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE;


  /*select * from administrative.mortgage_report('2013-01-01','2014-02-27') AS report(service_name varchar, service_count integer, males integer, females integer,
  entities integer, joint integer, total_amount float, stamp_duty float,
	transfer_duty float, registration_fee float);*/
	
DROP FUNCTION IF EXISTS administrative.transfer_lease_report(varchar,varchar);
CREATE OR REPLACE FUNCTION administrative.transfer_lease_report(varchar,varchar)
  RETURNS record AS
$BODY$
DECLARE 
	service_name  varchar;
	service_count  integer:=0;
	males  integer:=0;
	females integer:=0;
	entities integer:=0;
	joint integer:=0;
	total float:=0.0;
	stamp float:=0.0;
	transfer float:=0.0;
	registration float:=0.0;
	rec record;
	result record;
	sqlSt varchar;
   
BEGIN

	select service into service_name from administrative.transfer_lease_data($1,$2) limit 1;
	select count(*) into service_count from administrative.transfer_lease_data($1,$2);
	select count(*) into males from administrative.transfer_lease_data($1,$2) where gender = 'male' and status != 'Married in community of property';
	select count(*) into females from administrative.transfer_lease_data($1,$2) where gender = 'female' and status != 'Married in community of property';
	select count(*) into entities from administrative.transfer_lease_data($1,$2) where kind = 'nonNaturalPerson';
	select count(*) into joint from administrative.transfer_lease_data($1,$2) where status = 'Married in community of property';
	select sum(amount) into total from administrative.transfer_lease_data($1,$2);
	select sum(stamp_duty) into stamp from administrative.transfer_lease_data($1,$2);
	select sum(transfer_duty) into transfer from administrative.transfer_lease_data($1,$2);
	select sum(registration_fee) into registration from administrative.transfer_lease_data($1,$2);

	select into result service_name::varchar, service_count::integer, males::integer, females::integer, entities::integer, joint::integer, total::float, stamp::float,
	transfer::float, registration::float;

	return result;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE;


 /*select * from administrative.transfer_lease_report('2013-01-01','2014-02-27') AS report(service_name varchar, service_count integer, males integer, females integer,
  entities integer, joint integer, total_amount float, stamp_duty float,
	transfer_duty float, registration_fee float) union

select * from administrative.mortgage_report('2013-01-01','2014-02-27') AS report(service_name varchar, service_count integer, males integer, females integer,
  entities integer, joint integer, total_amount float, stamp_duty float,
	transfer_duty float, registration_fee float)
*/

