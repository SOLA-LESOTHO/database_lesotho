--INSERT INTO transaction.transaction(id,from_service_id,status_code,approval_datetime,bulk_generate_first_part,is_bulk_operation,rowidentifier,rowversion,change_action,change_user,change_time) VALUES('cadastre-transaction', NULL, 'approved', '2013-03-18 09:45:26.165', false, false, 'cc1f3724-8f9f-11e2-831e-6b51c1532276', 1, 'i', 'test-id', '2013-03-21 15:21:29.765');
INSERT INTO transaction.transaction(id,from_service_id,status_code,approval_datetime,bulk_generate_first_part,is_bulk_operation,rowidentifier,rowversion,change_action,change_user,change_time) VALUES('adm-transaction', NULL, 'approved', '2013-03-18 09:49:06.907', false, false, '4fb38bb2-8fa0-11e2-9545-d31d30bdd274', 1, 'i', 'test', '2013-03-21 15:21:29.765');


--load property

INSERT INTO lesotho_etl.ba_unit 
(id, 
type_code, 
name, 
name_firstpart, 
name_lastpart, 
status_code, 
creation_date, 
transaction_id, 
change_user)
SELECT DISTINCT
plot_number, 
'basicPropertyUnit', 
plot_number, 
substring(plot_number, 0, 6) AS firstpart, 
substring(plot_number, position ('-' in plot_number) + 1, length(plot_number)), 
'current', 
registration_date, 
'adm-transaction', 
'test-id'  
FROM lesotho_etl.entity_plots
WHERE transaction_type = 'lease';


with property as 
(
select distinct
b.type_code as type_code, 
b.name as name, 
b.name_firstpart as name_firstpart, 
b.name_lastpart as name_lastpart, 
b.creation_date as creation_date, 
b.expiration_date as expiration_date, 
b.status_code as status_code, 
b.transaction_id as transaction_id
FROM lesotho_etl.ba_unit b)

INSERT INTO administrative.ba_unit(
id, 
type_code, 
cadastre_object_id, 
name, 
name_firstpart, 
name_lastpart, 
creation_date, 
expiration_date, 
status_code, 
transaction_id)
SELECT 
uuid_generate_v1(), 
p.type_code,
c.id, 
p.name, 
p.name_firstpart, 
p.name_lastpart, 
p.creation_date, 
p.expiration_date, 
p.status_code, 
p.transaction_id
FROM property p 
INNER JOIN  cadastre.cadastre_object c
on c.name_firstpart = p.name_firstpart and c.name_lastpart = p.name_lastpart;