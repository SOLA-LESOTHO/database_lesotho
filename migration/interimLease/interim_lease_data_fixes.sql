
--preprocessing: standardizing some of the fields

update lesotho_etl.lease
set "RegistrationDate" = '1950-01-01'
where "RegistrationDate" is null;

update lesotho_etl.lease_transaction
set "RegistrationDate" = '2013-03-01'
where "RegistrationDate" = '1900-01-01';

update lesotho_etl.lease
set "OwnerFamilyName" = '', "OwnerOtherNames" = 'CHARGE OFFICE'
where "OwnerOtherNames" = 'OFFICE' and "OwnerFamilyName" = 'CHARGE';

update lesotho_etl.lease
set "OwnerFamilyName" = ''
where "OwnerOtherNames" = 'OMEGA SERVICES LESOTHO PROPERTIES LIMITED';

update lesotho_etl.lease
set "OwnerFamilyName" = '', "OwnerOtherNames" = 'MALUTI MOUNTAIN BREWERY'
where "OwnerOtherNames" = 'MOUNT BREWERY';

update lesotho_etl.lease
set "OwnerFamilyName" = '', "OwnerOtherNames" = 'OFFICE SITES'
where  "OwnerFamilyName" = 'OFFICE';

update lesotho_etl.lease
set "OwnerFamilyName" = '', "OwnerOtherNames" = 'ECONET TELECOM LESOTHO (PROPRIETARY) LIMITED'
where "OwnerOtherNames" LIKE 'ECONET TELECOM%' 
or "OwnerOtherNames" LIKE '% ECONET%';

update lesotho_etl.lease
set "OwnerFamilyName" = ''
where "OwnerFamilyName" LIKE '%(A Statutory Corporation Established Under%' 
OR "OwnerFamilyName" LIKE '%Registered%' 
OR "OwnerFamilyName" LIKE '%REGISTERED%' 
OR "OwnerFamilyName" LIKE '%registered%'; 

update lesotho_etl.lease
set "OwnerFamilyName" = '', "OwnerOtherNames" = 'BIBLE HOLINESS CHURCH'
where "OwnerOtherNames" LIKE '%HOLINESS CHUR%'; 

update lesotho_etl.lease
set "OwnerFamilyName" = '', "OwnerOtherNames" = 'MARAKABEI LODGE'
where "OwnerOtherNames" LIKE '%LODGE%' and "OwnerFamilyName" = 'MARAKABEI';

update lesotho_etl.lease
set "OwnerFamilyName" = '', "OwnerOtherNames" = 'ORANGE RIVER DEVELOP'
where "OwnerOtherNames" LIKE '%RIVER DEVELOP%' and "OwnerFamilyName" = 'ORANGE';

update lesotho_etl.lease
set "OwnerFamilyName" = '', "OwnerOtherNames" = 'MATALA EXT SITES'
where "OwnerOtherNames" LIKE '%EXT%' and "OwnerFamilyName" LIKE 'MATALA%';

update lesotho_etl.lease
set "OwnerFamilyName" = '', "OwnerOtherNames" = 'MALUTI PROPERTY'
where "OwnerOtherNames" LIKE '%PROPERTY%' and "OwnerFamilyName" LIKE 'MALUTI%';

update lesotho_etl.lease
set "OwnerFamilyName" = '', "OwnerOtherNames" = 'MALUTI RETAILERS'
where "OwnerOtherNames" LIKE '%RETAILERS%' and "OwnerFamilyName" LIKE 'MALUTI%';

update lesotho_etl.lease
set "OwnerFamilyName" = '', "OwnerOtherNames" = 'MAPUTSOE BUS AND T STOP'
where "OwnerOtherNames" LIKE '%BUS%' and "OwnerFamilyName" LIKE 'MAPUTSOE%';

update lesotho_etl.lease
set "OwnerFamilyName" = '', "OwnerOtherNames" = 'MAPUTSOE HOTEL'
where "OwnerOtherNames" LIKE '%HOTEL%' and "OwnerFamilyName" LIKE 'MAPUTSOE%';

update lesotho_etl.lease
set "OwnerFamilyName" = '', "OwnerOtherNames" = 'MAPUTSOE PILOT PROJ'
where "OwnerOtherNames" LIKE '%PILOT%' and "OwnerFamilyName" LIKE 'MAPUTSOE%';



--lease transactions


UPDATE lesotho_etl.lease_transaction
SET "OwnerOtherNames" ='NEDBANK LESOTHO LIMITED'
                where "OwnerOtherNames" LIKE '%NED BANK%'
                OR "OwnerOtherNames" LIKE '%NEDBANK%'
                OR "OwnerOtherNames" LIKE  '%NEDSBANK%'
				OR "OwnerOtherNames" LIKE '%NEDBAK%'
				OR "OwnerOtherNames" LIKE 'NAEDBANK%';
				
update lesotho_etl.lease_transaction
SET  "OwnerOtherNames" = 'STANDARD LESOTHO BANK'
where "OwnerOtherNames" LIKE '%STAANDARD%'
                OR "OwnerOtherNames" LIKE '%STAERNDARD%'
                OR "OwnerOtherNames" LIKE  '%STANADRD%' 
                OR "OwnerOtherNames" LIKE  '%STANARD%' 
                OR "OwnerOtherNames" LIKE  '%STANDARD%' 
                OR "OwnerOtherNames" LIKE  '%STANDARDLESOTHO%'
                OR "OwnerOtherNames" LIKE  '%STARNDRD%'
				OR "OwnerOtherNames" LIKE 'ATANDARD%'
				OR "OwnerOtherNames" LIKE 'STNDARD%'
				OR "OwnerOtherNames" LIKE 'STARNDARD%';
				
update lesotho_etl.lease_transaction
SET  "OwnerOtherNames" = 'LESOTHO BANK 1999 LIMITED'
where "OwnerOtherNames" LIKE 'LESOTHOBANK%'
                OR "OwnerOtherNames" LIKE 'LESOTHO BANK 1999%'
				OR "OwnerOtherNames" LIKE '%LESOTHO ANK (1999)%'
				OR "OwnerOtherNames" LIKE '%LESOTHO BANK (1990)LIMITED%'
				OR "OwnerOtherNames" LIKE '%LESOTHO BANK (1999)%'
				OR "OwnerOtherNames" LIKE 'LESOTHO BANK(1999)%';
                
				
update lesotho_etl.lease_transaction
SET  "OwnerOtherNames" = 'FIRST NATIONAL BANK LESOTHO'
where "OwnerOtherNames" LIKE '%FIRST N%';

UPDATE lesotho_etl.lease_transaction
SET  "OwnerOtherNames" ='LESOTHO NATIONAL DEVELOPMENT CORPORATION'
where "OwnerOtherNames" LIKE 'LESOTHO NATIONAL DEV%';

UPDATE lesotho_etl.lease_transaction
SET  "OwnerOtherNames" ='LESOTHO POSTBANK LIMITED'
where "OwnerOtherNames" LIKE 'LESOTHO POS%';


UPDATE lesotho_etl.lease_transaction
SET  "OwnerOtherNames" ='LINAKENG PROPERTIES(PTY)LTD'
where "OwnerOtherNames" LIKE 'LINAKENG%';

UPDATE lesotho_etl.lease_transaction
SET  "OwnerOtherNames" ='SIGMA CONSTRUCTION(PTY)LTD'
where "OwnerOtherNames" LIKE 'SIGMA CONSTRUCTION%';

UPDATE lesotho_etl.lease_transaction
SET  "OwnerOtherNames" ='TRADORETTE WHOLESALERS LESOTHO (PTY) LTD'
where "OwnerOtherNames" LIKE 'TRADORET%';

update lesotho_etl.lease_transaction
SET  "OwnerOtherNames" = 'CENTRAL BANK OF LESOTHO'
where "OwnerOtherNames" LIKE '%CENTRAL%';
                
update lesotho_etl.lease_transaction
SET  "OwnerOtherNames" = 'NATIONAL UNIVERSITY OF LESOTHO'
where "OwnerOtherNames" LIKE '%NATIONAL UNIVERSITY OF LESOTHO%'
OR "OwnerOtherNames" LIKE '%NATIONAL UNIVERSITY OF LRSOTHO%';

update lesotho_etl.lease_transaction
SET  "OwnerOtherNames" = 'FRASERS LESOTHO LIMITED'
where "OwnerOtherNames" LIKE '%FRASERS%';

update lesotho_etl.lease_transaction
SET  "OwnerOtherNames" = 'B.K. INVESTMENT PROPERTIES (PTY) LTD'
where "OwnerOtherNames" LIKE '%B.K. INVESTMENT%';

update lesotho_etl.lease_transaction
SET  "OwnerOtherNames" = 'BOLIBA MULTI-PURPOSE COOPERATIVE SOCIETY'
where "OwnerOtherNames" LIKE '%BOLIBA MULTI%';

update lesotho_etl.lease_transaction
SET  "OwnerOtherNames" = 'LESOTHO BANK IN LIQUIDATION'
where "OwnerOtherNames" LIKE '%LESOTHO BANK (LIQUIDATION)%'
OR "OwnerOtherNames" LIKE '%LESOTHO BANK IN%'
OR "OwnerOtherNames" LIKE 'LESOTHO BANK(IN LIQUIDATION)%';


update lesotho_etl.lease_transaction
SET  "OwnerOtherNames" = 'ORANGE RIVER DEVELOPMENT (PTY) LTD'
where "OwnerOtherNames" LIKE 'ORANGE RIVER DEVELOPMENT%'
OR "OwnerOtherNames" LIKE '%ORANGE RIVER DEVELOPMENTS%';


update lesotho_etl.lease_transaction
SET  "OwnerOtherNames" = 'ECONET TELECOM LESOTHO'
where "OwnerOtherNames" LIKE '%TELCOM LESOTHO%';

update lesotho_etl.lease_transaction
SET  "TransactionType" = 'MORTGAGE'
where "TransactionType" LIKE 'MOTRTGAGE%';


update lesotho_etl.lease_transaction
SET  "TransactionType" = 'GENERAL POWER OF ATTORNEY'
where "TransactionType" LIKE '%GENERAL POWER%';

update lesotho_etl.lease_transaction
SET  "TransactionType" = 'MINING LEASE'
where "TransactionType" LIKE 'MINING LEASE'
OR "TransactionType" LIKE 'MINNING%';




update lesotho_etl.lease_transaction
SET  "BenOtherName" = 'CENTURY 21 (PTY) LTD'
WHERE "BenOtherName" LIKE 'CENTURY 21%';

update lesotho_etl.lease_transaction
SET  "BenOtherName" = 'CHRISTIAN CONGREGATION OF JEHOVAHS WITNESS LESOTHO'
WHERE "BenOtherName" LIKE 'CHRISTIAN CONGREGATION OF JEHOVA%';

update lesotho_etl.lease_transaction
SET  "BenOtherName" = 'COMPUTER BUSINESS SOLUTIONS(PTY)LTD'
WHERE "BenOtherName" LIKE 'COMPUTER BUSINESS SOLUTIO%';


update lesotho_etl.lease_transaction
SET  "BenOtherName" = 'ENGEN LESOTHO (PTY)LTD'
WHERE "BenOtherName" LIKE 'ENGEN LESOTHO%';

update lesotho_etl.lease_transaction
SET  "BenOtherName" = 'HARDWARE CENTER (PTY) LTD'
WHERE "BenOtherName" LIKE 'HARDWARE CENTER (PTY) LTD%'
OR "BenOtherName" LIKE 'HARDWARE CENTRE (PTY) LTD%';

update lesotho_etl.lease_transaction
SET  "BenOtherName" = 'LERIBE INVESTMENT ( PTY) LTD'
WHERE "BenOtherName" LIKE 'LERIBE INVESTMENT%';

update lesotho_etl.lease_transaction
SET  "BenOtherName" = 'MOUNTAIN ESTATES DEVELOPMENT (PTY) LTD'
WHERE "BenOtherName" LIKE 'MOUNTAIN ESTATE DEV%'
OR "BenOtherName" LIKE 'MOUNTAINS ESTATES DEV%'
OR "BenOtherName" LIKE 'MOUTAINS ESTATES DEV%';

update lesotho_etl.lease_transaction
SET  "BenOtherName" = ''
WHERE "BenOtherName" LIKE 'SALMAN WHOLESALER AND RETAILERS%'
OR "BenOtherName" LIKE 'SALMAN WHOLESALERS AND RETAILERS%';

update lesotho_etl.lease_transaction
SET  "BenOtherName" = 'SELKOL (PTY) LTD'
WHERE "BenOtherName" LIKE 'SELKOL%';

update lesotho_etl.lease_transaction
SET  "BenOtherName" = 'SIGMA CONSTRUCTION (PTY) LTD'
WHERE "BenOtherName" LIKE 'SIGMA CONSTRUCTION%';

update lesotho_etl.lease_transaction
SET  "BenOtherName" = 'STERLING AGENCIES (PTY) LTD'
WHERE "BenOtherName" LIKE 'STELING AGENCIES (PTY) LTD%'
OR "BenOtherName" LIKE 'STERLING AGENCIES%';

update lesotho_etl.lease_transaction
SET  "BenOtherName" = 'THABA BOSIU ACADEMY OF TECHNOLOGY (PTY) LTD'
WHERE "BenOtherName" LIKE 'THABA-BOSIU ACADEMY%';

update lesotho_etl.lease_transaction
SET  "BenOtherName" = 'TRADORETTE WHOLESALERS LESOTHO(PTY) LTD'
WHERE "BenOtherName" LIKE 'TRADORETT%';

update lesotho_etl.lease_transaction
SET  "BenOtherName" = 'WOOLWORTHS (LESOTHO) (PTY) LTD'
WHERE "BenOtherName" LIKE 'WOOLWORTHS%';

update lesotho_etl.lease_transaction
SET  "BenOtherName" = 'ZAKHURA BROTHERS (PTY) LTD'
WHERE "BenOtherName" LIKE 'ZAKHURA BROTHERS%';


update lesotho_etl.lease_transaction
set "ConsentConsiderationAmount" = replace("ConsentConsiderationAmount",'DEEDCANCELLED','0');

update lesotho_etl.lease_transaction
set "ConsentConsiderationAmount" = replace("ConsentConsiderationAmount",'NORENTALAMOUNT','0');

update lesotho_etl.lease_transaction
set "ConsentConsiderationAmount" = replace("ConsentConsiderationAmount",'M','');


update lesotho_etl.lease_transaction
set "ConsentConsiderationAmount" = replace("ConsentConsiderationAmount",' ','');

update lesotho_etl.lease_transaction 
set "ConsentConsiderationAmount" = trim("ConsentConsiderationAmount");

update lesotho_etl.lease_transaction 
set "ConsentConsiderationAmount" = substring("ConsentConsiderationAmount", 
											position('(' in "ConsentConsiderationAmount") + 1, 
											length("ConsentConsiderationAmount"));

update lesotho_etl.lease_transaction
set "ConsentConsiderationAmount" = replace("ConsentConsiderationAmount", ')','');

---end of lease transaction