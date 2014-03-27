--Table application.application_stage_type ----

UPDATE application.application
SET stage_code = NULL
WHERE stage_code <> NULL;

DROP TABLE IF EXISTS system.appstage_appgroup;
DROP TABLE IF EXISTS application.application_stage_type CASCADE;
CREATE TABLE application.application_stage_type(
    code varchar(20) NOT NULL,
    display_value varchar(255) NOT NULL,
    status char(1) NOT NULL,
    description varchar(555),

    -- Internal constraints
    
    CONSTRAINT application_stage_type_display_value_unique UNIQUE (display_value),
    CONSTRAINT application_stage_type_pkey PRIMARY KEY (code)
);


comment on table application.application_stage_type is '';
    
 -- Data for the table application.application_stage_type -- 
insert into application.application_stage_type(code, display_value, status, description) values('newApp', 'New application lodged', 'c', 'Application awaiting approval for processing');
insert into application.application_stage_type(code, display_value, status, description) values('appApprove', 'Application awaiting approval', 'c', 'All services in the application have been completed and the application can now be approved');
insert into application.application_stage_type(code, display_value, status, description) values('appProcess', 'Application to be processed', 'c', 'The application has been lodged and is ready to be processed');
insert into application.application_stage_type(code, display_value, status, description) values('appInfoIncorrect', 'Application sent back to correct input information', 'c', 'Processed application has incomplete or incorrect information and cannot be approved');
insert into application.application_stage_type(code, display_value, status, description) values('missingPlot', 'Application sent back because of missing plot', 'c', 'Application cannot be processed because of missing plot. Awaiting response from Survey and Mapping department');
insert into application.application_stage_type(code, display_value, status, description) values('areaMismatch', 'Application sent back to correct plot area mismatch', 'c', 'Application cannot be processed because the cadastral area in the system is different from the area on the S10 Form');
insert into application.application_stage_type(code, display_value, status, description) values('custCollect', 'Enter collection details', 'c', 'Enter details of the person who collects the completed, approved application');
insert into application.application_stage_type(code, display_value, status, description) values('callCustomer', 'Customer Services to call customer for signature', 'c', 'The customer is called to sign the draft');
insert into application.application_stage_type(code, display_value, status, description) values('custSign', 'Customer to sign draft', 'c', 'Lease draft awaits customerâ€™s signature');
insert into application.application_stage_type(code, display_value, status, description) values('executiveSign', 'Executive Office to sign lease draft', 'c', 'The lease draft shall be signed by the Director General');
insert into application.application_stage_type(code, display_value, status, description) values('bindDraft', 'Leasing Services to bind lease draft', 'c', 'The lease draft shall now be bound and made ready for registration');
insert into application.application_stage_type(code, display_value, status, description) values('checkDraft', 'Director of Lease Services to check draft', 'c', 'The signed lease draft is ready to be checked and the application approved');
insert into application.application_stage_type(code, display_value, status, description) values('logDraft', 'Leasing Services to Log ready drafts', 'c', 'The application is ready to be logged as completed and approved for registration');
insert into application.application_stage_type(code, display_value, status, description) values('appRegister', 'Application ready for registration', 'c', 'The lease application is ready to be registered');
insert into application.application_stage_type(code, display_value, status, description) values('appArchive', 'Application ready for archiving', 'c', 'The application is ready to be archived');

------------

-- Table: system.appstage_appgroup

DROP TABLE system.appstage_appgroup;

CREATE TABLE system.appstage_appgroup
(
  appstage_code character varying(40) NOT NULL,
  appgroup_id character varying(40) NOT NULL,
  CONSTRAINT appstage_appgroup_pkey PRIMARY KEY (appstage_code , appgroup_id ),
  CONSTRAINT appstage_appgroup_appgroup_id_fk142 FOREIGN KEY (appgroup_id)
      REFERENCES system.appgroup (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT appstage_appgroup_appstage_code_fk141 FOREIGN KEY (appstage_code)
      REFERENCES application.application_stage_type (code) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE
)
WITH (
  OIDS=FALSE
);
ALTER TABLE system.appstage_appgroup
  OWNER TO postgres;
COMMENT ON TABLE system.appstage_appgroup
  IS 'This many-to-many table contains users, related to groups. Allows to have multiple groups for one user.';

-- Index: system.appstage_appgroup_appgroup_id_fk142_ind

-- DROP INDEX system.appstage_appgroup_appgroup_id_fk142_ind;

CREATE INDEX appstage_appgroup_appgroup_id_fk142_ind
  ON system.appstage_appgroup
  USING btree
  (appgroup_id COLLATE pg_catalog."default" );

-- Index: system.appstage_appgroup_appstage_code_fk141_ind

-- DROP INDEX system.appstage_appgroup_appstage_code_fk141_ind;

CREATE INDEX appstage_appgroup_appstage_code_fk141_ind
  ON system.appstage_appgroup
  USING btree
  (appstage_code COLLATE pg_catalog."default" );


 -- Data for the table system.appstage_appgroup -- 
INSERT INTO system.appstage_appgroup(appstage_code, appgroup_id) VALUES ('newApp', 'cust-reps-id');
INSERT INTO system.appstage_appgroup(appstage_code, appgroup_id) VALUES ('newApp', 'deeds-reps-id');
INSERT INTO system.appstage_appgroup(appstage_code, appgroup_id) VALUES ('newApp', 'surveymapp-id');
INSERT INTO system.appstage_appgroup(appstage_code, appgroup_id) VALUES ('appApprove', 'deeds-reps-id');
INSERT INTO system.appstage_appgroup(appstage_code, appgroup_id) VALUES ('appApprove', 'lease-id');
INSERT INTO system.appstage_appgroup(appstage_code, appgroup_id) VALUES ('appApprove', 'surveymapp-id');
INSERT INTO system.appstage_appgroup(appstage_code, appgroup_id) VALUES ('appApprove', 'manager-id');
INSERT INTO system.appstage_appgroup(appstage_code, appgroup_id) VALUES ('appProcess', 'deeds-reps-id');
INSERT INTO system.appstage_appgroup(appstage_code, appgroup_id) VALUES ('appProcess', 'lease-id');
INSERT INTO system.appstage_appgroup(appstage_code, appgroup_id) VALUES ('appProcess', 'lease-correct-id');
INSERT INTO system.appstage_appgroup(appstage_code, appgroup_id) VALUES ('appProcess', 'surveymapp-id');
INSERT INTO system.appstage_appgroup(appstage_code, appgroup_id) VALUES ('appArchive', 'cust-reps-id');
INSERT INTO system.appstage_appgroup(appstage_code, appgroup_id) VALUES ('appArchive', 'deeds-reps-id');
INSERT INTO system.appstage_appgroup(appstage_code, appgroup_id) VALUES ('appArchive', 'lease-id');
INSERT INTO system.appstage_appgroup(appstage_code, appgroup_id) VALUES ('appArchive', 'surveymapp-id');
INSERT INTO system.appstage_appgroup(appstage_code, appgroup_id) VALUES ('appInfoIncorrect', 'cust-reps-id');
INSERT INTO system.appstage_appgroup(appstage_code, appgroup_id) VALUES ('appInfoIncorrect', 'deeds-reps-id');
INSERT INTO system.appstage_appgroup(appstage_code, appgroup_id) VALUES ('appInfoIncorrect', 'lease-id');
INSERT INTO system.appstage_appgroup(appstage_code, appgroup_id) VALUES ('appInfoIncorrect', 'surveymapp-id');
INSERT INTO system.appstage_appgroup(appstage_code, appgroup_id) VALUES ('missingPlot', 'lease-id');
INSERT INTO system.appstage_appgroup(appstage_code, appgroup_id) VALUES ('areaMismatch', 'lease-id');
INSERT INTO system.appstage_appgroup(appstage_code, appgroup_id) VALUES ('custCollect', 'cust-reps-id');
INSERT INTO system.appstage_appgroup(appstage_code, appgroup_id) VALUES ('custCollect', 'deeds-reps-id');
INSERT INTO system.appstage_appgroup(appstage_code, appgroup_id) VALUES ('callCustomer', 'cust-reps-id');
INSERT INTO system.appstage_appgroup(appstage_code, appgroup_id) VALUES ('custSign', 'cust-reps-id');
INSERT INTO system.appstage_appgroup(appstage_code, appgroup_id) VALUES ('executiveSign', 'dg-id');
INSERT INTO system.appstage_appgroup(appstage_code, appgroup_id) VALUES ('bindDraft', 'lease-id');
INSERT INTO system.appstage_appgroup(appstage_code, appgroup_id) VALUES ('checkDraft', 'lease-id');
INSERT INTO system.appstage_appgroup(appstage_code, appgroup_id) VALUES ('logDraft', 'lease-id');
INSERT INTO system.appstage_appgroup(appstage_code, appgroup_id) VALUES ('appRegister', 'deeds-reps-id');



