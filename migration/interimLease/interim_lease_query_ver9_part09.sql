
 -- *** Mortgages *** 
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
   status VARCHAR(20));
   
-- Get all of the mortgage records  
 INSERT INTO lesotho_etl.sola_mortgage (titleid, deed_number, titleref, insttype, memorial, regdate, status )
select t."Plot_Number", t."DeedNumber",  t."TransactionNumber",  t."TransactionType", 'mortgage', t."RegistrationDate", 'current'
from lesotho_etl.lease_transaction t inner join lesotho_etl.lease l
on t."Plot_Number" = l."Plot_Number"
where length(t."DeedNumber") > 0 and t."TransactionType" in ('MORTGAGE');

UPDATE lesotho_etl.sola_mortgage
SET sola_rrr_id = uuid_generate_v1(),
    sola_rrr_nr =  trim(to_char(nextval('administrative.rrr_nr_seq'), '000000')); 


-- Add the mortgage rrr's
INSERT INTO administrative.rrr(id, ba_unit_id, is_primary, registration_date, type_code, status_code, nr, transaction_id, change_user)
SELECT m.sola_rrr_id, b.id, FALSE, m.regdate, 'mortgage', m.status, m.sola_rrr_nr, 'adm-transaction', 'test-id'
FROM lesotho_etl.sola_mortgage m
inner join administrative.ba_unit b on
m.titleid = b.name; 

-- Add the mortgage notations
INSERT INTO  administrative.notation(id, rrr_id, transaction_id, change_user, notation_date, status_code, notation_text, reference_nr) 
SELECT uuid_generate_v1(), sola_rrr_id, 'adm-transaction', 'test-id', regdate, status, 'mortgage', COALESCE(deed_number, '')
FROM  lesotho_etl.sola_mortgage
WHERE EXISTS (SELECT id FROM administrative.rrr WHERE id = sola_rrr_id); 




 -- *** Transfer
-- Create a table to help process transmission rrrs 
DROP TABLE IF EXISTS lesotho_etl.sola_transfer;
CREATE TABLE lesotho_etl.sola_transfer (
   sola_rrr_id VARCHAR(40),
   sola_rrr_nr VARCHAR(20),
   titleid VARCHAR(40),
   titleref VARCHAR(20),
   insttype VARCHAR(100),
   memorial VARCHAR(100),
   regdate timestamp without time zone,
   status VARCHAR(20));
   
-- Get all of the transfers.  
INSERT INTO lesotho_etl.sola_transfer (titleid, titleref, insttype, memorial, regdate, status)
select t."Plot_Number", t."DeedNumber", t."TransactionType", 'transfer', t."RegistrationDate", 'current'
from lesotho_etl.lease_transaction t inner join lesotho_etl.lease l
on t."Plot_Number" = l."Plot_Number"
where length(t."DeedNumber") > 0 and t."TransactionType" in ('TRANSFER');

UPDATE lesotho_etl.sola_transfer
SET sola_rrr_id = uuid_generate_v1(),
    sola_rrr_nr =  trim(to_char(nextval('administrative.rrr_nr_seq'), '000000'));

-- Add the transfer rrr's
INSERT INTO administrative.rrr(id, ba_unit_id, is_primary, registration_date, type_code, status_code, nr, transaction_id, change_user)
SELECT t.sola_rrr_id, b.id, FALSE, t.regdate, 'ownership', t.status, t.sola_rrr_nr, 'adm-transaction', 'test-id'
FROM lesotho_etl.sola_transfer t
inner join administrative.ba_unit b on
t.titleid = b.name; 

-- Add the transfer notations
INSERT INTO  administrative.notation(id, rrr_id, transaction_id, change_user, notation_date, status_code, notation_text, reference_nr) 
SELECT uuid_generate_v1(), sola_rrr_id, 'adm-transaction', 'test-id', regdate, status, 'transfer', COALESCE(titleref, '')
FROM  lesotho_etl.sola_transfer
WHERE EXISTS (SELECT id FROM administrative.rrr WHERE id = sola_rrr_id);


--process transfers to make some to be previous

insert into lesotho_etl.title
SELECT  ba_unit_id , COUNT(ba_unit_id)
FROM administrative.rrr where type_code in ('ownership')
group by ba_unit_id   having count(ba_unit_id) > 1;


insert into lesotho_etl.title_rrr
select r.ba_unit_id, n.rrr_id, r.registration_date, n.notation_text FROM administrative.notation n
inner join  administrative.rrr r 
on n.rrr_id = r.id
inner join lesotho_etl.title t
on r.ba_unit_id = t.ba_unit_id
where  n.notation_text in ('ownership', 'transfer')
and r.type_code = 'ownership'; 


select lesotho_etl.process_title();

--process cancelled titles

insert into lesotho_etl.cancelled_title
SELECT p.plot_number, b.id
FROM lesotho_etl.entity_plots p
inner join administrative.ba_unit b
on b.name = p.plot_number
WHERE p.transaction_type = 'surrender';

select lesotho_etl.process_surrendered_titles();
