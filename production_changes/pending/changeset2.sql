-- Production SQL Script 27-Aug-2013
ALTER TABLE application.application ALTER COLUMN action_notes SET DATA TYPE CHARACTER VARYING(8000);

ALTER TABLE administrative.dispute ALTER COLUMN nr SET DATA TYPE CHARACTER VARYING(255);

ALTER TABLE administrative.dispute ALTER COLUMN status_code SET DATA TYPE character varying(20);

ALTER TABLE administrative.dispute ALTER COLUMN status_code SET DEFAULT 'Pending'::character varying;

ALTER TABLE administrative.dispute ALTER COLUMN plot_location SET DATA TYPE character varying(255);

ALTER TABLE administrative.dispute ADD COLUMN dispute_description character varying(255);

ALTER TABLE administrative.dispute ALTER COLUMN lodgement_date SET NOT NULL;

-----

ALTER TABLE application.application_historic ALTER COLUMN action_notes SET DATA TYPE CHARACTER VARYING(8000);

ALTER TABLE administrative.dispute_historic ALTER COLUMN nr SET DATA TYPE CHARACTER VARYING(255);

ALTER TABLE administrative.dispute_historic ALTER COLUMN status_code SET DATA TYPE character varying(20);

ALTER TABLE administrative.dispute_historic ALTER COLUMN status_code SET DEFAULT 'Pending'::character varying;

ALTER TABLE administrative.dispute_historic ALTER COLUMN plot_location SET DATA TYPE character varying(255);

ALTER TABLE administrative.dispute_historic ADD COLUMN dispute_description character varying(255);

ALTER TABLE administrative.dispute_historic ALTER COLUMN lodgement_date SET NOT NULL;

---

DELETE FROM administrative.other_authorities WHERE code = 'laa';

---

CREATE TABLE administrative.dispute_reports
(
  code character varying(40) NOT NULL,
  display_value character varying(250) NOT NULL,
  description character varying(555),
  status character(1) NOT NULL,
  CONSTRAINT dispute_reports_pkey PRIMARY KEY (code ),
  CONSTRAINT dispute_reports_display_value_unique UNIQUE (display_value )
)
WITH (
  OIDS=FALSE
);
ALTER TABLE administrative.dispute_reports
  OWNER TO postgres;
COMMENT ON TABLE administrative.dispute_reports
  IS 'Reference table for dispute reports.';

--
insert into administrative.dispute_reports(code, display_value, status) values('monthrep', 'Monthly Report', 'c');
insert into administrative.dispute_reports(code, display_value, status) values('status', 'Status Report', 'c');
insert into administrative.dispute_reports(code, display_value, status) values('statistics', 'Statistics', 'c');
insert into administrative.dispute_reports(code, display_value, status) values('confirmation', 'Confirmation', 'c'); 
 
--
ALTER TABLE administrative.dispute_party ADD COLUMN party_name character varying(100);
ALTER TABLE administrative.dispute_party ALTER COLUMN party_name SET NOT NULL;


ALTER TABLE administrative.dispute_party_historic ADD COLUMN party_name character varying(100);
ALTER TABLE administrative.dispute_party_historic ALTER COLUMN party_name SET NOT NULL;