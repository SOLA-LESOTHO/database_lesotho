--Table application.application_stage_type ----
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




