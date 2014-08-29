--DROP TABLE administrative.transaction_type;

CREATE TABLE administrative.transaction_type
(
  code character varying(20) NOT NULL,
  display_value character varying(255) NOT NULL,
  description character varying(555),
  status character(1) NOT NULL DEFAULT 'c'::bpchar,
  CONSTRAINT pk_transaction_type PRIMARY KEY (code )
)
WITH (
  OIDS=FALSE
);

-- DROP TABLE administrative.consent;

CREATE TABLE administrative.consent
(
  id character varying(40) NOT NULL,
  reg_date date NOT NULL,
  expiration_date date NOT NULL,
  amount numeric(29,2),
  transaction_type_code character varying(20) NOT NULL,
  special_conditions character varying(5000),
  transaction_id character varying(40) NOT NULL,
  rowidentifier character varying(40) NOT NULL DEFAULT uuid_generate_v1(),
  rowversion integer NOT NULL DEFAULT 1,
  change_action character(1) DEFAULT 'i'::bpchar,
  change_user character varying(50) NOT NULL,
  change_time timestamp without time zone NOT NULL DEFAULT now(),
  CONSTRAINT pk_consent PRIMARY KEY (id ),
  CONSTRAINT fk_consent_transaction FOREIGN KEY (transaction_id)
      REFERENCES transaction.transaction (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_transaction_type FOREIGN KEY (transaction_type_code)
      REFERENCES administrative.transaction_type (code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);

-- DROP TABLE administrative.consent_party;

CREATE TABLE administrative.consent_party
(
  consent_id character varying(40) NOT NULL,
  party_id character varying(40) NOT NULL,
  rowidentifier character varying(40) NOT NULL DEFAULT uuid_generate_v1(),
  rowversion integer NOT NULL DEFAULT 0,
  change_action character(1) DEFAULT 'i'::bpchar,
  change_user character varying(50) NOT NULL,
  change_time timestamp without time zone NOT NULL DEFAULT now(),
  CONSTRAINT pk_consent_party PRIMARY KEY (consent_id , party_id ),
  CONSTRAINT fk_consent_party_consent FOREIGN KEY (consent_id)
      REFERENCES administrative.consent (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_consent_party_party FOREIGN KEY (party_id)
      REFERENCES party.party (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE
)
WITH (
  OIDS=FALSE
);

delete from administrative.transaction_type where code='servetude';
delete from administrative.transaction_type where code='sublease';
delete from administrative.transaction_type where code='transfer';

insert into administrative.transaction_type (code, display_value, description) values ('servetude', 'PRIVATE SERVITUDE', 'PRIVATE SERVITUDE');
insert into administrative.transaction_type (code, display_value, description) values ('sub_lease', 'SUB LEASE', 'SUB LEASE');
insert into administrative.transaction_type (code, display_value, description) values ('transfer', 'TRANSFER', 'TRANSFER');


---
INSERT INTO cadastre.land_use_grade(
            land_use_code, land_grade_code, admin_fee, ground_rent_rate, 
            duty_on_ground_rent, registration_fee)
    VALUES ('agricIntensive', 'grade1', '100', '300', 
            '0', '0');

INSERT INTO cadastre.land_use_grade(
            land_use_code, land_grade_code, admin_fee, ground_rent_rate, 
            duty_on_ground_rent, registration_fee)
    VALUES ('agricIntensive', 'grade2', '100', '300', 
            '0', '0');

INSERT INTO cadastre.land_use_grade(
            land_use_code, land_grade_code, admin_fee, ground_rent_rate, 
            duty_on_ground_rent, registration_fee)
    VALUES ('agricIntensive', 'grade3', '100', '300', 
            '0', '0');

INSERT INTO cadastre.land_use_grade(
            land_use_code, land_grade_code, admin_fee, ground_rent_rate, 
            duty_on_ground_rent, registration_fee)
    VALUES ('agricIntensive', 'grade4', '100', '300', 
            '0', '0');

INSERT INTO cadastre.land_use_grade(
            land_use_code, land_grade_code, admin_fee, ground_rent_rate, 
            duty_on_ground_rent, registration_fee)
    VALUES ('agricIntensive', 'grade5', '100', '300', 
            '0', '0');
