

--ensure that plots are mapped with
--1. 	primary rightholders:
--i) 	non natural persons
--ii)	natural persons
--iii)	co-owners (natural persons)
--2. 	mortgage lenders
--3. 	beneficiaries for subleases, surrender, transfers, variation

with plots as
(
--map with primary rightholders (non Natural Persons)
select 
p.id as party_id, 
l."Plot_Number" as plot_number, 
l."RegistrationDate" as reg_date, 
'lease' as transaction_type
from lesotho_etl.lease l 
inner join party.party p
on p.ext_id = l."OwnerOtherNames"
where p.type_code = 'nonNaturalPerson'
--map with primary rightholders (natural person)
union select distinct
p.id as party_id, 
l."Plot_Number" as plot_number, 
l."RegistrationDate" as reg_date,
'lease' as transaction_type
from lesotho_etl.lease l 
inner join party.party p
on  l."OwnerOtherNames" || l."OwnerFamilyName" || l."Plot_Number" = p.ext_id
where p.type_code = 'naturalPerson'
--map with co-owners (natural person)
union select distinct
p.id as party_id, 
l."Plot_Number" as plot_number, 
l."RegistrationDate" as reg_date,
'lease' as transaction_type
from lesotho_etl.lease l 
inner join party.party p
on l."Owner2OtherNames" || l."Owner2FamilyName" || l."Plot_Number" = p.ext_id 
where p.type_code = 'naturalPerson'
--map with mortgage lenders (i.e financial institutions)
union select distinct
p.id as party_id,
t."Plot_Number" as plot_number, 
t."RegistrationDate" as reg_date,
'mortgage' as transaction_type
from lesotho_etl.lease_transaction t
inner join lesotho_etl.lease l
on t."Plot_Number" = l."Plot_Number"
inner join party.party p
on t."OwnerOtherNames" = p.ext_id
where length(t."DeedNumber") > 0
and t."TransactionType" in ('MORTGAGE')
and length(t."OwnerFamilyName") = 0 
and length(t."OwnerOtherNames") > 0
--map with other beneficiaries for given transactions (institutions/non natural persons)
union select distinct
p.id as party_id,
t."Plot_Number" as plot_number, 
t."RegistrationDate" as reg_date,
(select CASE 	
	WHEN t."TransactionType" = 'VARIATION' THEN 'variation'
	WHEN t."TransactionType" = 'SUBLEASE' THEN 'sublease'
	WHEN t."TransactionType" = 'TRANSFER' THEN 'transfer'
	WHEN t."TransactionType" = 'SURRENDER' THEN 'surrender'   
	ELSE null end
) as transaction_type
from lesotho_etl.lease_transaction t
inner join lesotho_etl.lease l
on t."Plot_Number" = l."Plot_Number"
inner join party.party p
on t."BenOtherName" = p.ext_id
where length(t."DeedNumber") > 0
and length(trim(both from t."Plot_Number")) > 0 
and t."TransactionType" in ( 'VARIATION', 'SUBLEASE', 'TRANSFER', 'SURRENDER')
and length(t."BenOtherName") > 0
and length(t."BenFamilyName") = 0 
--map with beneficiaries for the given transactions (natural persons)
union select distinct
p.id as party_id,
t."Plot_Number" as plot_number, 
t."RegistrationDate" as reg_date,
(select CASE 	
	WHEN t."TransactionType" = 'VARIATION' THEN 'variation'
	WHEN t."TransactionType" = 'SUBLEASE' THEN 'sublease'
	WHEN t."TransactionType" = 'TRANSFER' THEN 'transfer'
	WHEN t."TransactionType" = 'SURRENDER' THEN 'surrender'   
	ELSE null end
) as transaction_type
from lesotho_etl.lease_transaction t
inner join lesotho_etl.lease l
on t."Plot_Number" = l."Plot_Number"
inner join party.party p
on t."BenOtherName"|| t."BenFamilyName" || t."Plot_Number" = p.ext_id
where length(t."DeedNumber") > 0
and length(trim(both from t."Plot_Number")) > 0 
and t."TransactionType" in ( 'VARIATION', 'SUBLEASE', 'TRANSFER', 'SURRENDER')
and length(t."BenOtherName") > 0
and length(t."BenFamilyName") > 0
--map with co-beneficiaries for the given transactions (natural persons)
union select distinct
p.id as party_id,
t."Plot_Number" as plot_number, 
t."RegistrationDate" as reg_date,
(select CASE 	
	WHEN t."TransactionType" = 'VARIATION' THEN 'variation'
	WHEN t."TransactionType" = 'SUBLEASE' THEN 'sublease'
	WHEN t."TransactionType" = 'TRANSFER' THEN 'transfer'
	WHEN t."TransactionType" = 'SURRENDER' THEN 'surrender'   
	ELSE null end
) as transaction_type
from lesotho_etl.lease_transaction t
inner join lesotho_etl.lease l
on t."Plot_Number" = l."Plot_Number"
inner join party.party p
on t."Ben2OtherName"|| t."Ben2FamilyName" || t."Plot_Number" = p.ext_id
where length(t."DeedNumber") > 0
and length(trim(both from t."Plot_Number")) > 0 
)
--load the data
insert into lesotho_etl.entity_plots
select distinct
p.party_id, 
p.plot_number,
p.reg_date,
p.transaction_type
from plots p
where p.transaction_type is not null;


