 -- *** Mortgages *** 
 

CREATE OR REPLACE FUNCTION lesotho_etl.process_transfers()
  RETURNS character varying AS
$BODY$
DECLARE 
	rec RECORD;
	ba_unit_id VARCHAR(150) := '';
	curr_ba_unit_id VARCHAR(150) := '';
	rrr_id VARCHAR(150) := '';
	curr_status VARCHAR(20);
	curr_type_code VARCHAR(20);
	insttype SMALLINT;
	hist_count INT := 0;
	
BEGIN
	-- Process each title. 
	FOR rec IN EXECUTE 'select rrr_id, ba_unit_id, instrument_type From lesotho_etl.instruments order by ba_unit_id, instrument_type desc'
	LOOP
	
		ba_unit_id := rec.ba_unit_id;
		
		insttype := rec.instrument_type;
		
		rrr_id := rec.rrr_id;
		
		--for rrrs of same ba unit
		
		if ba_unit_id != curr_ba_unit_id THEN
			curr_ba_unit_id = ba_unit_id;
			hist_count := 0;
			curr_status := 'current';
		END IF;
		
		IF insttype = 2 THEN
		   -- transfer - set the rrr to current
		   curr_status := 'current';
		   curr_type_code :='lease';
		   hist_count := 2;
		END IF;
		
		IF insttype = 1 THEN
			curr_type_code :='lease';
			IF hist_count > 0 THEN
		   -- transfer - set the rrr to historic so all subsequent
				curr_status := 'historic';
				curr_type_code :='lease';
				hist_count := 2;
			END IF;
		END IF;
		
		IF insttype = 3 THEN
			curr_type_code :='mortgage';
		END IF;
		
		
		update administrative.rrr set status_code = curr_status, type_code = curr_type_code
		WHERE id = rrr_id;
		
		
	END LOOP;
		
	RETURN 'ok';
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION lesotho_etl.process_transfers()
  OWNER TO postgres; 
 
-- Create a table to help process the mortgage rrrs 
DROP TABLE IF EXISTS lesotho_etl.sola_mortgage;
CREATE TABLE lesotho_etl.sola_mortgage (
   sola_rrr_id VARCHAR(40),
   sola_rrr_nr VARCHAR(20),
   titleid VARCHAR(40),
   deed_number VARCHAR(20),
   titleref VARCHAR(20),
   insttype VARCHAR(100), 
   memorial VARCHAR(100),
   regdate timestamp without time zone, 
   status VARCHAR(20),
   lender VARCHAR(255));
   
-- Get all of the mortgage records 
DELETE FROM lesotho_etl.sola_mortgage; 
 INSERT INTO lesotho_etl.sola_mortgage (titleid, deed_number, titleref, insttype, memorial, regdate, status, lender )
select t."Plot_Number", t."DeedNumber",  t."TransactionNumber",  t."TransactionType", 'mortgage', t."RegistrationDate", 'current', t."OwnerOtherNames"
from lesotho_etl.lease_transaction t inner join lesotho_etl.lease l
on t."Plot_Number" = l."Plot_Number"
where length(t."DeedNumber") > 0 
and t."TransactionType" in ('MORTGAGE')
AND t."OwnerOtherNames" <> ''
AND LENGTH(t."OwnerFamilyName") <= 0;

UPDATE lesotho_etl.sola_mortgage
SET sola_rrr_id = uuid_generate_v1(),
    sola_rrr_nr =  trim(to_char(nextval('administrative.rrr_nr_seq'), '000000')); 


-- Add the mortgage rrr's
delete from administrative.rrr where type_code = 'mortgage';
INSERT INTO administrative.rrr(id, ba_unit_id, is_primary, registration_date, type_code, status_code, nr, registration_number, transaction_id, change_user)
SELECT m.sola_rrr_id, b.id, FALSE, m.regdate, 'mortgage', m.status, m.sola_rrr_nr, m.deed_number ,'adm-transaction', 'test-id'
FROM lesotho_etl.sola_mortgage m
inner join administrative.ba_unit b on
m.titleid = b.name; 

-- Add the mortgage notations
delete from  administrative.notation where notation_text = 'mortgage';
INSERT INTO  administrative.notation(id, rrr_id, transaction_id, change_user, notation_date, status_code, notation_text, reference_nr) 
SELECT uuid_generate_v1(), sola_rrr_id, 'adm-transaction', 'test-id', regdate, status, 'mortgage', COALESCE(deed_number, '')
FROM  lesotho_etl.sola_mortgage
WHERE EXISTS (SELECT id FROM administrative.rrr WHERE id = sola_rrr_id); 

--Add mortgage share
insert into administrative.rrr_share (id, rrr_id, nominator, denominator)
select uuid_generate_v1(), id, 1, 1
from administrative.rrr
where type_code = 'mortgage'; 

--Add party for rrr
INSERT INTO administrative.party_for_rrr(rrr_id, share_id, party_id)
select m.sola_rrr_id, s.id, p.id
from administrative.rrr_share s
inner join lesotho_etl.sola_mortgage m on m.sola_rrr_id = s.rrr_id
inner join party.party p on m.lender = p.ext_id;



 -- *** Transfer
-- Create a table to help process transmission rrrs 
DROP TABLE IF EXISTS lesotho_etl.sola_transfer;
CREATE TABLE lesotho_etl.sola_transfer 
(
   sola_rrr_id VARCHAR(40),
   sola_rrr_nr VARCHAR(20),
   titleid VARCHAR(40),
   titleref VARCHAR(20),
   insttype VARCHAR(100),
   memorial VARCHAR(100),
   regdate timestamp without time zone,
   status VARCHAR(20),
   first_beneficiary_name  VARCHAR(255),
   first_beneficiary_surname  VARCHAR(255),
   second_beneficiary_name  VARCHAR(255),
   second_beneficiary_surname  VARCHAR(255)
  );
   

 
 
--Create a table for recording new rightholders
DROP TABLE IF EXISTS lesotho_etl.instruments;
CREATE TABLE lesotho_etl.instruments 
(
  rrr_id character varying(40),
  ba_unit_id character varying(255),
  instrument_type integer
 );

   
-- Get all of the transfers. 
delete from lesotho_etl.sola_transfer; 
INSERT INTO lesotho_etl.sola_transfer 
(titleid, titleref, insttype, memorial, regdate, status, 
first_beneficiary_name, first_beneficiary_surname, second_beneficiary_name, second_beneficiary_surname)
select t."Plot_Number", t."DeedNumber", t."TransactionType", 'transfer', t."RegistrationDate", 'current', "BenOtherName", "BenFamilyName", "Ben2OtherName", "Ben2FamilyName"
from lesotho_etl.lease_transaction t inner join lesotho_etl.lease l
on t."Plot_Number" = l."Plot_Number"
where length(t."DeedNumber") > 0
and t."TransactionType" in ('TRANSFER')
and length(concat("BenFamilyName","BenOtherName", "Ben2FamilyName", "Ben2OtherName")) > 0;


UPDATE lesotho_etl.sola_transfer
SET sola_rrr_id = uuid_generate_v1(),
    sola_rrr_nr =  trim(to_char(nextval('administrative.rrr_nr_seq'), '000000'));

	
-- Add the transfer rrr's
INSERT INTO administrative.rrr(id, ba_unit_id, is_primary, registration_date, type_code, status_code, nr, transaction_id, change_user, registration_number)
SELECT t.sola_rrr_id, b.id, FALSE, t.regdate, 'tenancy', t.status, t.sola_rrr_nr, 'adm-transaction', 'test-id', titleref
FROM lesotho_etl.sola_transfer t
inner join administrative.ba_unit b on
t.titleid = b.name; 


-- Add the transfer notations
INSERT INTO  administrative.notation(id, rrr_id, transaction_id, change_user, notation_date, status_code, notation_text, reference_nr) 
SELECT uuid_generate_v1(), sola_rrr_id, 'adm-transaction', 'test-id', regdate, status, 'transfer', COALESCE(titleref, '')
FROM  lesotho_etl.sola_transfer
WHERE EXISTS (SELECT id FROM administrative.rrr WHERE id = sola_rrr_id);

--Add shares
insert into administrative.rrr_share (id, rrr_id, nominator, denominator)
select uuid_generate_v1(), id, 1, 1
from administrative.rrr
where type_code = 'tenancy';
 

--Add rightholders
with transfer_party as(
SELECT 
s. sola_rrr_id,  
s. first_beneficiary_name as beneficiary_name, 
s. first_beneficiary_surname as beneficiary_surname,
(select case
	when first_beneficiary_surname = '' then 'nonNaturalPerson'
	else 'naturalPerson' end
) as party_type_code
FROM lesotho_etl.sola_transfer s inner join administrative.rrr r on r.id = s.sola_rrr_id
union
select
s.sola_rrr_id,  
s.second_beneficiary_name as beneficiary_name, 
s.second_beneficiary_surname as beneficiary_surname,
(select case
	when second_beneficiary_name = '' then 'nonNaturalPerson'
	else 'naturalPerson' end
) as party_type_code
FROM lesotho_etl.sola_transfer  s inner join administrative.rrr r on r.id = s.sola_rrr_id
where length(concat(s.second_beneficiary_name, s.second_beneficiary_surname)) > 0)
insert into party.party
(
id, ext_id, type_code, name, fathers_last_name
)
select uuid_generate_v1(), sola_rrr_id, party_type_code, beneficiary_name, beneficiary_surname
from transfer_party;

--party for rrr

INSERT INTO administrative.party_for_rrr(rrr_id, share_id, party_id)
select t.sola_rrr_id, s.id, p.id
from administrative.rrr_share s
inner join lesotho_etl.sola_transfer t on t.sola_rrr_id = s.rrr_id
inner join party.party p on t.sola_rrr_id = p.ext_id;


--process transfers to make some to be historic

insert into lesotho_etl.instruments 
select 
id, 
ba_unit_id, 
(select case when type_code = 'lease' then 1 when type_code = 'tenancy' then 2 when type_code ='mortgage' then 3 end)
From administrative.rrr;

select lesotho_etl.process_transfers();