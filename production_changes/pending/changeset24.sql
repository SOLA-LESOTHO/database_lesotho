<<<<<<< HEAD
﻿--Table application.application_stage_type ----
DROP TABLE IF EXISTS application.application_stage_type CASCADE;
CREATE TABLE application.application_stage_type(
    code varchar(20) NOT NULL,
    display_value varchar(250) NOT NULL,
    status char(1) NOT NULL DEFAULT ('t'),
    description varchar(555),

    -- Internal constraints
    
    CONSTRAINT application_stage_type_display_value_unique UNIQUE (display_value),
    CONSTRAINT application_stage_type_pkey PRIMARY KEY (code)
);


comment on table application.application_stage_type is 'Reference Table / Code list of stage types that are performed in relation to an (land office) application for services
LADM Reference Object 
FLOSS SOLA Extension
LADM Definition
Not Applicable';
    
 -- Data for the table application.application_stage_type -- 
insert into application.application_stage_type(code, display_value, status) values('customerLodge', 'Customer Services to lodge', 'c');
insert into application.application_stage_type(code, display_value, status) values('customerSign', 'Customer Services to call customer for signature', 'c');
insert into application.application_stage_type(code, display_value, status) values('customerCollection', 'Customer Services to enter collection details', 'c');
insert into application.application_stage_type(code, display_value, status) values('leaseProcess', 'Leasing Services to process application', 'c');
insert into application.application_stage_type(code, display_value, status) values('leaseBindDraft', 'Leasing Services to bundle relevant files', 'c');
insert into application.application_stage_type(code, display_value, status) values('leaseCheckDraft', 'Director of Leasing Services to check lease draft', 'c');
insert into application.application_stage_type(code, display_value, status) values('executiveSign', 'Executive office to sign lease draft', 'c');
insert into application.application_stage_type(code, display_value, status) values('registrationProcess', 'Registration Services to process application', 'c');

ALTER table application.application
ADD COLUMN stage_code CHARACTER VARYING (20);

ALTER TABLE application.application_historic
ADD COLUMN stage_code CHARACTER VARYING (20);
=======
﻿DROP FUNCTION IF EXISTS administrative.transfer_lease_data(varchar,varchar);
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
>>>>>>> working
