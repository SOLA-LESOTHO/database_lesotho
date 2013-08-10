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
    VALUES ('regOnEndorseRight','registrationServices','Registration on Endorsement','c',5,0,0.00,0.00,0,
	'','lease','vary', null);
	
-- Services that allow correction of registry data
INSERT INTO application.request_type(code, request_category_code, display_value, 
            status, nr_days_to_complete, base_fee, area_base_fee, value_base_fee, 
            nr_properties_required, notation_template, rrr_type_code, type_action_code, 
            description)
    VALUES ('registrarCorrection','registrationServices','Correct Lease','c',5,0.00,0.00,0.00,1,
	'Lease correction <details>',NULL,NULL,'Correction of lease details');
INSERT INTO application.request_type(code, request_category_code, display_value, 
            status, nr_days_to_complete, base_fee, area_base_fee, value_base_fee, 
            nr_properties_required, notation_template, rrr_type_code, type_action_code, 
            description)
    VALUES ('registrarCancel','registrationServices','Correct Lease (Cancel Right)','c',5,0.00,0.00,0.00,1,
	'Lease correction <details>',NULL,'cancel','Cancel a right to correct lease details');
	
/*
INSERT INTO application.request_type(code, request_category_code, display_value, 
            status, nr_days_to_complete, base_fee, area_base_fee, value_base_fee, 
            nr_properties_required, notation_template, rrr_type_code, type_action_code, 
            description)
    VALUES ('regOnNameChange','registrationServices','Registration on Change of Lessee Names','c',5,0,0.00,0.00,0,
	'','lease','vary', null);
	
INSERT INTO application.request_type(code, request_category_code, display_value, 
            status, nr_days_to_complete, base_fee, area_base_fee, value_base_fee, 
            nr_properties_required, notation_template, rrr_type_code, type_action_code, 
            description)
    VALUES ('regOnVaryLease','registrationServices','Registration on Lease Variation','c',5,0,0.00,0.00,0,
	'','lease','vary', null);

INSERT INTO application.request_type(code, request_category_code, display_value, 
            status, nr_days_to_complete, base_fee, area_base_fee, value_base_fee, 
            nr_properties_required, notation_template, rrr_type_code, type_action_code, 
            description)
    VALUES ('regOnRenwalLease','registrationServices','Registration on Lease Renewal','c',5,0,0.00,0.00,0,
	'','lease','vary', null);
	
INSERT INTO application.request_type(code, request_category_code, display_value, 
            status, nr_days_to_complete, base_fee, area_base_fee, value_base_fee, 
            nr_properties_required, notation_template, rrr_type_code, type_action_code, 
            description)
    VALUES ('regOnSurrenderLease','registrationServices','Registration on Lease Surrender','c',5,0,0.00,0.00,0,
	'','lease','vary', null);
*/	
	

-- Configure roles for services - AM No longer required
/*
INSERT INTO system.approle (code, display_value, status) SELECT req.code, req.display_value, 'c'
FROM   application.request_type req
WHERE  req.status = 'c'
AND    NOT EXISTS (SELECT r.code FROM system.approle r WHERE req.code = r.code); 

UPDATE  system.approle SET display_value = req.display_value
FROM 	application.request_type req
WHERE   system.approle.code = req.code; 

-- Add any missing roles to the super-group-id 

INSERT INTO system.approle_appgroup (approle_code, appgroup_id) (SELECT r.code, 'super-group-id' 
 FROM   system.approle r
 WHERE NOT EXISTS (SELECT approle_code FROM system.approle_appgroup rg
                 WHERE  rg.approle_code = r.code
				 AND    rg.appgroup_id = 'super-group-id')); */
