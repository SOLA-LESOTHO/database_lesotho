
CREATE OR REPLACE FUNCTION application.getmortgagestats(fromdate character varying, todate character varying)
  RETURNS SETOF record AS
$BODY$
DECLARE 
   mortgages  integer;
   amount float;
   average_amount float;
   recToReturn record;
   rec record;
   sqlSt varchar;
   
BEGIN
	sqlSt = 'with result_table as (select count(*) as mortgages, sum(r.amount) as amount from administrative.rrr r 
	where r.transaction_id in (select tr.id from (transaction.transaction tr
	join application.service sv on tr.from_service_id = sv.id)) and r.type_code = ''mortgage''
	and r.registration_date BETWEEN to_date('''|| fromdate || ''',''yyyy-mm-dd'')  and to_date('''|| todate || ''',''yyyy-mm-dd'')
	and r.status_code = ''current'')

	select mortgages, amount, round(amount/mortgages) as average_amount from result_table';

	FOR rec in EXECUTE sqlSt loop
		mortgages:= rec.mortgages;
		amount:= rec.amount;
		average_amount:= rec.average_amount;
		
		select into recToReturn mortgages::integer, amount::float, average_amount::float;        
		return next recToReturn;
	end loop;
END;
$BODY$
language plpgsql;
