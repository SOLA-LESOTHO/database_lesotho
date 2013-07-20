-- Show the application as on hold when it is in the requistioned state. 
UPDATE application.application_status_type
SET display_value = 'On hold'
WHERE code = 'requisitioned';

-- Disable / hide unused cadastre object types
UPDATE cadastre.cadastre_object_type
SET status = 'x'
WHERE code IN ('buildingUnit', 'utilityNetwork');

-- Reconfigure the service types for SOLA
INSERT INTO application.request_category_type (code, display_value, description, status)
SELECT 'surveyServices', 'Survey Services', NULL, 'c' WHERE 'surveyServices' NOT IN 
(SELECT code FROM application.request_category_type); 

INSERT INTO application.request_category_type (code, display_value, description, status)
SELECT 'leaseServices', 'Lease Services', NULL, 'c' WHERE 'leaseServices' NOT IN 
(SELECT code FROM application.request_category_type);

-- Disable / hide unsued request types
UPDATE application.request_type
SET status = 'x'
WHERE code in ('regnDeeds', 'surveyPlanCopy', 'cadastreImport');

UPDATE application.request_type
SET request_category_code = 'surveyServices'
WHERE code in ('cadastreChange', 'redefineCadastre');

UPDATE application.request_type
SET request_category_code = 'leaseServices'
WHERE code in ('registerLease', 'newOwnership', 'varyLease', 'removeRight', 'cancelProperty', 'regSublease', 
'consentApplication', 'varySublease', 'endorseRight', 'renewLease', 'groundRentExemp', 'nameChange');

-- Add services to support registration on leases and subleases
INSERT INTO application.request_type(code, request_category_code, display_value, 
            status, nr_days_to_complete, base_fee, area_base_fee, value_base_fee, 
            nr_properties_required, notation_template, rrr_type_code, type_action_code, 
            description)
    VALUES ('regOnLease','registrationServices','Registration on Lease','c',5,0,0.00,0.00,0,
	'','lease','vary', null);	
	
INSERT INTO application.request_type(code, request_category_code, display_value, 
            status, nr_days_to_complete, base_fee, area_base_fee, value_base_fee, 
            nr_properties_required, notation_template, rrr_type_code, type_action_code, 
            description)
    VALUES ('regOnSublease','registrationServices','Registration on Sublease','c',5,0,0.00,0.00,0,
	'','subLease','vary', null);

