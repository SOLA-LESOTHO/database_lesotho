UPDATE party.party
   SET  ext_id= btrim(to_char(nextval('party.party_nr_seq'::regclass), '000000'::text));
   
CREATE SEQUENCE party.party_nr_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 999999
  START 100000
  CACHE 1;
ALTER TABLE party.party_nr_seq
  OWNER TO postgres;