
--load non natural persons (entities)
with parties as 
(
select distinct 
"OwnerOtherNames" as name
from lesotho_etl.lease
where "Owner2OtherNames" is null
and length("OwnerOtherNames") > 0
and length("OwnerFamilyName") = 0

union
select distinct
t."OwnerOtherNames" as name
from lesotho_etl.lease_transaction t
inner join lesotho_etl.lease l
on t."Plot_Number" = l."Plot_Number"
where length(t."DeedNumber") > 0
and t."TransactionType" in ('MORTGAGE')
and length(t."OwnerFamilyName") = 0  --take entities only
and length(t."OwnerOtherNames") > 0

union
select distinct
t."BenOtherName" as name
from lesotho_etl.lease_transaction t
inner join lesotho_etl.lease l
on t."Plot_Number" = l."Plot_Number"
where length(t."DeedNumber") > 0
and length(trim(both from t."Plot_Number")) > 0 
and t."TransactionType" in ( 'VARIATION', 'SUBLEASE', 'TRANSFER','SURRENDER')
and length(t."BenOtherName") > 0
and length(t."BenFamilyName") = 0 
)
insert into lesotho_etl.party
(id,
ref_id,
name,
type_code,
legal_type,
rowversion,
change_action,
change_user)
select distinct
p.name, 
p.name, --name is going to be used as reference id
p.name, 
'nonNaturalPerson',
'regCompany',
1, 	
'i', 	
'test-id'
from parties p;



--load single individulas


--load co-owners

with co_owners as 
(
select 
"OwnerOtherNames" || "OwnerFamilyName" || "Plot_Number"  as ext_id, -- ref id
"OwnerOtherNames" as name, --name
"OwnerFamilyName" as last_name, --last name
'naturalPerson' as type_code, -- type code
(select CASE 	
	WHEN "Gender1" = 'M' THEN 'male'
	WHEN "Gender1" = 'F' THEN 'female' 
	ELSE null end
) as gender_code,
(select CASE 
	WHEN "MaritalStatus" like '%Divorced%' THEN 'divorced'	
	WHEN "MaritalStatus" like '%Married in community%' THEN 'marriedInCom'
	WHEN "MaritalStatus" like '%Married out of community%' THEN 'marriedOut' 
	WHEN "MaritalStatus" like '%single%' THEN 'single' 
	WHEN "MaritalStatus" like '%Widowed%' THEN 'widowed' 
	WHEN "MaritalStatus" like '%REGISTERED SOCIETY%' THEN 'regSoc1966'
	WHEN "MaritalStatus" like '%In Trust For%' THEN 'guardian'
	WHEN "MaritalStatus" like '%Married' THEN 'marriedInCom'
	WHEN "MaritalStatus" like '%separated%' THEN 'Separated'
	ELSE 'unmarried' end
) as legal_type
from lesotho_etl.lease
where "Owner2OtherNames" is null
and length("OwnerOtherNames") > 0
and length("OwnerFamilyName")> 0
and length("Owner2OtherNames")  is null
and length("Owner2FamilyName") is null

union select 
"OwnerOtherNames" || "OwnerFamilyName" || "Plot_Number" as ext_id,
"OwnerOtherNames" as name, --name
"OwnerFamilyName" as last_name, --last name
'naturalPerson' as type_code, -- type code
(select CASE 	
	WHEN "Gender1" = 'M' THEN 'male'
	WHEN "Gender1" = 'F' THEN 'female' 
	ELSE null end
) as gender_code,
(select CASE 
	WHEN "MaritalStatus" like '%Divorced%' THEN 'divorced'	
	WHEN "MaritalStatus" like '%Married in community%' THEN 'marriedInCom'
	WHEN "MaritalStatus" like '%Married out of community%' THEN 'marriedOut' 
	WHEN "MaritalStatus" like '%single%' THEN 'single' 
	WHEN "MaritalStatus" like '%Widowed%' THEN 'widowed' 
	WHEN "MaritalStatus" like '%REGISTERED SOCIETY%' THEN 'regSoc1966'
	WHEN "MaritalStatus" like '%In Trust For%' THEN 'guardian'
	WHEN "MaritalStatus" like '%Married' THEN 'marriedInCom'
	WHEN "MaritalStatus" like '%separated%' THEN 'Separated'
	ELSE 'unmarried' end
) as legal_type
from lesotho_etl.lease l
where length("Owner2OtherNames") > 0
and length("OwnerOtherNames") > 0

union select 
"Owner2OtherNames" || "Owner2FamilyName" || "Plot_Number"  as ext_id, -- ref id
"Owner2OtherNames"  as name, --name
"Owner2FamilyName"  as last_name, --last name
'naturalPerson'  as type_code, -- type code
(select CASE 	
	WHEN "Gender2" = 'M' THEN 'male'
	WHEN "Gender2" = 'F' THEN 'female' 
	ELSE null end
) as gender_code,
(select CASE 
	WHEN "MaritalStatus" like '%Divorced%' THEN 'divorced'	
	WHEN "MaritalStatus" like '%Married in community%' THEN 'marriedInCom'
	WHEN "MaritalStatus" like '%Married out of community%' THEN 'marriedOut' 
	WHEN "MaritalStatus" like '%single%' THEN 'single' 
	WHEN "MaritalStatus" like '%Widowed%' THEN 'widowed' 
	WHEN "MaritalStatus" like '%REGISTERED SOCIETY%' THEN 'regSoc1966'
	WHEN "MaritalStatus" like '%In Trust For%' THEN 'guardian'
	WHEN "MaritalStatus" like '%Married' THEN 'marriedInCom'
	WHEN "MaritalStatus" like '%separated%' THEN 'Separated'
	ELSE 'unmarried' end
) as legal_type
from lesotho_etl.lease
where length("Owner2OtherNames") > 0
and length("OwnerOtherNames") > 0

union select
t."BenOtherName"|| t."BenFamilyName" || t."Plot_Number" as ext_id,
t."BenOtherName" as name, --name
t."BenFamilyName" as last_name, --last name
'naturalPerson' as type_code, -- type code
null as gender_code,
(select CASE 
	WHEN "MaritalStatusBen" like '%Divorced%' THEN 'divorced'	
	WHEN "MaritalStatusBen" like '%Married in community%' THEN 'marriedInCom'
	WHEN "MaritalStatusBen" like '%Married out of community%' THEN 'marriedOut' 
	WHEN "MaritalStatusBen" like '%single%' THEN 'single' 
	WHEN "MaritalStatusBen" like '%Widowed%' THEN 'widowed' 
	WHEN "MaritalStatusBen" like '%REGISTERED SOCIETY%' THEN 'regSoc1966'
	WHEN "MaritalStatusBen" like '%In Trust For%' THEN 'guardian'
	WHEN "MaritalStatusBen" like '%Married' THEN 'marriedInCom'
	WHEN "MaritalStatusBen" like '%separated%' THEN 'Separated'
	ELSE 'unmarried' end
) as legal_type
from lesotho_etl.lease_transaction t
inner join lesotho_etl.lease l
on t."Plot_Number" = l."Plot_Number"
where length(t."DeedNumber") > 0
and length(trim(both from t."Plot_Number")) > 0 
and t."TransactionType" in ( 'VARIATION', 'SUBLEASE', 'TRANSFER','SURRENDER')
and length(t."BenOtherName") > 0
and length(t."BenFamilyName") > 0

union select
t."Ben2OtherName"|| t."Ben2FamilyName" || t."Plot_Number" as ext_id,
t."Ben2OtherName" as name, --name
t."Ben2FamilyName" as last_name, --last name
'naturalPerson' as type_code, -- type code
null as gender_code,
(select CASE 
	WHEN "MaritalStatusBen" like '%Divorced%' THEN 'divorced'	
	WHEN "MaritalStatusBen" like '%Married in community%' THEN 'marriedInCom'
	WHEN "MaritalStatusBen" like '%Married out of community%' THEN 'marriedOut' 
	WHEN "MaritalStatusBen" like '%single%' THEN 'single' 
	WHEN "MaritalStatusBen" like '%Widowed%' THEN 'widowed' 
	WHEN "MaritalStatusBen" like '%REGISTERED SOCIETY%' THEN 'regSoc1966'
	WHEN "MaritalStatusBen" like '%In Trust For%' THEN 'guardian'
	WHEN "MaritalStatusBen" like '%Married' THEN 'marriedInCom'
	WHEN "MaritalStatusBen" like '%separated%' THEN 'Separated'
	ELSE 'unmarried' end
) as legal_type
from lesotho_etl.lease_transaction t
inner join lesotho_etl.lease l
on t."Plot_Number" = l."Plot_Number"
where length(t."DeedNumber") > 0
and length(trim(both from t."Plot_Number")) > 0 
and t."TransactionType" in ( 'VARIATION', 'SUBLEASE', 'TRANSFER','SURRENDER')
and length(t."Ben2OtherName") > 0
and length(t."Ben2FamilyName") > 0
)

insert into lesotho_etl.party
(id,
ref_id,
name,
last_name,
type_code,
gender_code,
legal_type,
rowversion,
change_action,
change_user)
select
distinct
c.ext_id, 
c.ext_id,
c.name,
c.last_name,
type_code,
c.gender_code,
c.legal_type,
1,
'i',
'test-id'
from co_owners c
where c.ext_id is not null;



insert into party.party
(id,
ext_id,
name,
last_name,
type_code,
gender_code,
legal_type,
rowversion,
change_action,
change_user)
select
uuid_generate_v1(),
ref_id,
name,
last_name,
type_code,
gender_code,
legal_type,
rowversion,
change_action,
change_user
from lesotho_etl.party;
