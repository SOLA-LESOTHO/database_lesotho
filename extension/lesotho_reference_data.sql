﻿
	DELETE FROM source.administrative_source_type;

	INSERT INTO source.administrative_source_type(code,display_value,status,description,is_for_registration) VALUES ('deed', 'Deed', 'c', NULL, false);
	INSERT INTO source.administrative_source_type(code,display_value,status,description,is_for_registration) VALUES ('agreement', 'Agreement', 'c', 'Extension to LADM', false);
	INSERT INTO source.administrative_source_type(code,display_value,status,description,is_for_registration) VALUES ('agriConsent', 'Agricultural Consent', 'x', NULL, false);
	INSERT INTO source.administrative_source_type(code,display_value,status,description,is_for_registration) VALUES ('agriLease', 'Agricultural Lease', 'x', NULL, false);
	INSERT INTO source.administrative_source_type(code,display_value,status,description,is_for_registration) VALUES ('agriNotaryStatement', 'Agricultural Notary', 'x', NULL, false);
	INSERT INTO source.administrative_source_type(code,display_value,status,description,is_for_registration) VALUES ('cadastralMap', 'Cadastral Map::::Mapa oa Cadastral', 'c', 'Extension to LADM', false);
	INSERT INTO source.administrative_source_type(code,display_value,status,description,is_for_registration) VALUES ('cadastralSurvey', 'Plan of Survey (S10)::::Cadastral Survey', 'c', 'Extension to LADM', false);
	INSERT INTO source.administrative_source_type(code,display_value,status,description,is_for_registration) VALUES ('declareLandHold', 'Declaration of Land Holdings', 'c', NULL, false);
	INSERT INTO source.administrative_source_type(code,display_value,status,description,is_for_registration) VALUES ('legalNotice', 'Legal Notice', 'c', NULL, false);
	INSERT INTO source.administrative_source_type(code,display_value,status,description,is_for_registration) VALUES ('contractForSale', 'Contract For Sale::::Tumellano ea Thekisetsano', 'c', 'Extension to LADM', false);
	INSERT INTO source.administrative_source_type(code,display_value,status,description,is_for_registration) VALUES ('mortgage', 'Mortgage Bond::::Mortgage', 'c', NULL, false);
	INSERT INTO source.administrative_source_type(code,display_value,status,description,is_for_registration) VALUES ('powerOfAttorney', 'Power of Attorney', 'c', 'Extension to LADM', false);
	INSERT INTO source.administrative_source_type(code,display_value,status,description,is_for_registration) VALUES ('proclamation', 'Proclamation', 'x', 'Extension to LADM', false);
	INSERT INTO source.administrative_source_type(code,display_value,status,description,is_for_registration) VALUES ('otherDocument', 'Other Documents', 'c', NULL, false);
	INSERT INTO source.administrative_source_type(code,display_value,status,description,is_for_registration) VALUES ('groundRentExemp', 'Ground Rent Exemption Application', 'c', NULL, false);
	INSERT INTO source.administrative_source_type(code,display_value,status,description,is_for_registration) VALUES ('title', 'Allocation Title::::Lengolo le pakang', 'c', NULL, false);
	INSERT INTO source.administrative_source_type(code,display_value,status,description,is_for_registration) VALUES ('waiver', 'Waiver', 'x', 'Extension to LADM', false);
	INSERT INTO source.administrative_source_type(code,display_value,status,description,is_for_registration) VALUES ('will', 'Last Will and Testament::::Thato ea Mofu', 'c', 'Extension to LADM', false);
	INSERT INTO source.administrative_source_type(code,display_value,status,description,is_for_registration) VALUES ('cessionDeed', 'Cession of Deed', 'c', NULL, false);
	INSERT INTO source.administrative_source_type(code,display_value,status,description,is_for_registration) VALUES ('cessionLease', 'Cession of Lease', 'c', NULL, false);
	INSERT INTO source.administrative_source_type(code,display_value,status,description,is_for_registration) VALUES ('letterCouncil', 'Letter from Council', 'c', NULL, false);
	INSERT INTO source.administrative_source_type(code,display_value,status,description,is_for_registration) VALUES ('memoArticles', 'Memorandum of Articles', 'c', NULL, false);
	INSERT INTO source.administrative_source_type(code,display_value,status,description,is_for_registration) VALUES ('mineLease', 'Mining Lease::::Lisi ea Mine', 'c', NULL, false);
	INSERT INTO source.administrative_source_type(code,display_value,status,description,is_for_registration) VALUES ('sublease', 'Sub-Lease Contract::::Sublease', 'c', NULL, false);
	INSERT INTO source.administrative_source_type(code,display_value,status,description,is_for_registration) VALUES ('surrLease', 'Surrender of Lease', 'c', NULL, false);
	INSERT INTO source.administrative_source_type(code,display_value,status,description,is_for_registration) VALUES ('surveyReport', 'Complete Survey Report', 'c', NULL, false);
	INSERT INTO source.administrative_source_type(code,display_value,status,description,is_for_registration) VALUES ('titleDeed', 'Title Deed', 'c', NULL, true);
	INSERT INTO source.administrative_source_type(code,display_value,status,description,is_for_registration) VALUES ('lease', 'Lease::::Lisi', 'c', NULL, false);
	INSERT INTO source.administrative_source_type(code,display_value,status,description,is_for_registration) VALUES ('notarialSuretyBond', 'Notarial Surety Bond', 'c', NULL, false);
	INSERT INTO source.administrative_source_type(code,display_value,status,description,is_for_registration) VALUES ('notarialCoveringBond', 'Notarial Covering Bond', 'c', NULL, false);
	INSERT INTO source.administrative_source_type(code,display_value,status,description,is_for_registration) VALUES ('notarialDeedServitud', 'Notarial Deed of Servitude', 'c', NULL, false);
	INSERT INTO source.administrative_source_type(code,display_value,status,description,is_for_registration) VALUES ('notarialGeneralBond', 'Notarial General Bond', 'c', NULL, false);
	INSERT INTO source.administrative_source_type(code,display_value,status,description,is_for_registration) VALUES ('reducblMortgageBond', 'Reducible Mortgage Bond', 'c', NULL, false);
	INSERT INTO source.administrative_source_type(code,display_value,status,description,is_for_registration) VALUES ('specialNotarialBond', 'Special Notarial Bond', 'c', NULL, false);
	INSERT INTO source.administrative_source_type(code,display_value,status,description,is_for_registration) VALUES ('addendumSublease', 'Addendum to Sublease', 'c', NULL, false);
	INSERT INTO source.administrative_source_type(code,display_value,status,description,is_for_registration) VALUES ('courtPaper', 'Court Paper', 'c', 'Extension to LADM', false);
	INSERT INTO source.administrative_source_type VALUES ('idVerification', 'Identification Document::::Boitsebiso', 'c', 'Extension to LADM', false);
	INSERT INTO source.administrative_source_type(code,display_value,status,description,is_for_registration) VALUES ('marriageCert', 'Marriage Certificate::::Lengolo la Lenyalo', 'c', NULL, false);
	INSERT INTO source.administrative_source_type(code,display_value,status,description,is_for_registration) VALUES ('landUseCert', 'Land Use Certificate', 'c', NULL, false);
	INSERT INTO source.administrative_source_type(code,display_value,status,description,is_for_registration) VALUES ('valuationReport', 'Property Valuation Report', 'c', NULL, false);
	INSERT INTO source.administrative_source_type(code,display_value,status,description,is_for_registration) VALUES ('offPaymentRecpt', 'Official Payment Receipt', 'c', NULL, false);
	INSERT INTO source.administrative_source_type(code,display_value,status,description,is_for_registration) VALUES ('swornAffdt', 'Sworn Affidavit', 'c', NULL, false);
	INSERT INTO source.administrative_source_type(code,display_value,status,description,is_for_registration) VALUES ('propertyMarktRep', 'Property Market Value Report', 'c', NULL, false);
	INSERT INTO source.administrative_source_type(code,display_value,status,description,is_for_registration) VALUES ('changeUseApp', 'Change of Use Approval', 'c', NULL, false);
	INSERT INTO source.administrative_source_type(code,display_value,status,description,is_for_registration) VALUES ('consentCert', 'Consent Certificate', 'c', NULL, false);
	INSERT INTO source.administrative_source_type(code,display_value,status,description,is_for_registration) VALUES ('deathCert', 'Death Certificate', 'c', NULL, false);
	INSERT INTO source.administrative_source_type(code,display_value,status,description,is_for_registration) VALUES ('ministerialCons', 'Ministerial Consent', 'c', NULL, false);
	INSERT INTO source.administrative_source_type(code,display_value,status,description,is_for_registration) VALUES ('leaseCopy', 'Copy of lease', 'c', NULL, false);
	INSERT INTO source.administrative_source_type(code,display_value,status,description,is_for_registration) VALUES ('subDivideLease', 'Subdivide a Lease', 'c', NULL, false);
	INSERT INTO source.administrative_source_type(code,display_value,status,description,is_for_registration) VALUES ('leaseTransfer', 'Transfer of Lease', 'c', NULL, false);
	INSERT INTO source.administrative_source_type(code,display_value,status,description,is_for_registration) VALUES ('appForm', 'Application Form', 'c', NULL, false);
	INSERT INTO source.administrative_source_type(code,display_value,status,description,is_for_registration) VALUES ('mortgageTransfer', 'Mortgage Transfer', 'c', NULL, false);
	INSERT INTO source.administrative_source_type(code,display_value,status,description,is_for_registration) VALUES ('trust', 'Trust', 'c', NULL, false);
	INSERT INTO source.administrative_source_type(code,display_value,status,description,is_for_registration) VALUES ('memoAssoc', 'Memorandum of Association', 'c', NULL, false);
	INSERT INTO source.administrative_source_type(code,display_value,status,description,is_for_registration) VALUES ('certIncorp', 'Certificate of Incorporation', 'c', NULL, false);
	INSERT INTO source.administrative_source_type(code,display_value,status,description,is_for_registration) VALUES ('taxClrCert', 'Tax Clearance Certificate', 'c', NULL, false);
	INSERT INTO source.administrative_source_type(code,display_value,status,description,is_for_registration) VALUES ('copyLease', 'Copy of Lease', 'c', NULL, false);

	-- Used to ensure the sublessee has consent for a mortgage from the lessee. 
	INSERT INTO source.administrative_source_type(code,display_value,status,description,is_for_registration) VALUES ('lesseeConsent', 'Lessee Consent', 'c', NULL, false);

	INSERT INTO source.administrative_source_type(code,display_value,status,description,is_for_registration) VALUES ('disputedoc', 'Dispute Document', 'c', NULL, false);


	-- RRR Type
	INSERT INTO administrative.rrr_type(code, rrr_group_type_code, display_value, is_primary, share_check, party_required, status, description)
    VALUES ('subLease', 'rights', 'Sublease', FALSE, FALSE, TRUE, 'c', 'Indicates the property is subject to a sublease agreement.');
	INSERT INTO administrative.rrr_type(code, rrr_group_type_code, display_value, is_primary, share_check, party_required, status, description)
    VALUES ('subLeaseMortgage', 'restrictions', 'Sublease Mortgage', FALSE, FALSE, FALSE, 'c', 'Indicates the property is subject to a sublease mortgage.');

	--A Section with status 'c'
	INSERT INTO application.request_type(code,request_category_code,display_value,description,status,nr_days_to_complete,base_fee,area_base_fee,value_base_fee,nr_properties_required,notation_template,rrr_type_code,type_action_code) VALUES ('regnReducMortgage', 'registrationServices', 'Register Reducible Mortgage', NULL, 'x', 5, 5.00, 1.00, 0.00, 1, NULL, NULL, 'vary');
	INSERT INTO application.request_type(code,request_category_code,display_value,description,status,nr_days_to_complete,base_fee,area_base_fee,value_base_fee,nr_properties_required,notation_template,rrr_type_code,type_action_code) VALUES ('cancServitude', 'registrationServices', 'Cancel Servitude', NULL, 'x', 5, 5.00, 1.00, 0.00, 1, NULL, NULL, 'cancel');
	INSERT INTO application.request_type(code,request_category_code,display_value,description,status,nr_days_to_complete,base_fee,area_base_fee,value_base_fee,nr_properties_required,notation_template,rrr_type_code,type_action_code) VALUES ('cnclDocument', 'registrationServices', 'Withdraw Document', 'To withdraw from use any standard document (such as standard mortgage or standard lease)', 'c', 1, 5.00, 0.00, 0.00, 0, NULL, NULL, NULL);
	INSERT INTO application.request_type(code,request_category_code,display_value,description,status,nr_days_to_complete,base_fee,area_base_fee,value_base_fee,nr_properties_required,notation_template,rrr_type_code,type_action_code) VALUES ('provideSpatialData', 'informationServices', 'Provide Spatial Data::::Fana ka  boitsebiso ba spatial Data', 'Provide Spatial Data', 'c', 1, 0.00, 0.00, 0.00, 1, 'Provide Spatial Data', NULL, NULL);
	INSERT INTO application.request_type(code,request_category_code,display_value,description,status,nr_days_to_complete,base_fee,area_base_fee,value_base_fee,nr_properties_required,notation_template,rrr_type_code,type_action_code) VALUES ('documentSearch', 'informationServices', 'Document Search', NULL, 'x', 1, 5.00, 0.00, 0.00, 1, NULL, NULL, NULL);
	--INSERT INTO application.request_type(code,request_category_code,display_value,description,status,nr_days_to_complete,base_fee,area_base_fee,value_base_fee,nr_properties_required,notation_template,rrr_type_code,type_action_code) VALUES ('cancelMortBonds', 'registrationServices', 'Cancel Mortgage', NULL, 'c', 0, 0.00, 0.00, 0.00, 0, NULL, 'mortgage', 'cancel');
	INSERT INTO application.request_type(code,request_category_code,display_value,description,status,nr_days_to_complete,base_fee,area_base_fee,value_base_fee,nr_properties_required,notation_template,rrr_type_code,type_action_code) VALUES ('regRedMortBond', 'registrationServices', 'Register Reducible Mortgage Bond', NULL, 'x', 0, 5.00, 0.00, 0.00, 0, NULL, NULL, NULL);
	INSERT INTO application.request_type(code,request_category_code,display_value,description,status,nr_days_to_complete,base_fee,area_base_fee,value_base_fee,nr_properties_required,notation_template,rrr_type_code,type_action_code) VALUES ('cedeMortgage', 'registrationServices', 'Cession of a Mortgage bond::::kopo ea tahlo ea Mortgage bond', NULL, 'x', 1, 5.00, 0.00, 0.00, 1, 'Cede on the mortgage bond', 'mortgage', 'vary');
	--INSERT INTO application.request_type(code,request_category_code,display_value,description,status,nr_days_to_complete,base_fee,area_base_fee,value_base_fee,nr_properties_required,notation_template,rrr_type_code,type_action_code) VALUES ('counterClaim', 'legalServices', 'Lodge Counter Claim', NULL, 'c', 0, 5.00, 0.00, 0.00, 0, NULL, NULL, NULL);
	--INSERT INTO application.request_type(code,request_category_code,display_value,description,status,nr_days_to_complete,base_fee,area_base_fee,value_base_fee,nr_properties_required,notation_template,rrr_type_code,type_action_code) VALUES ('courtProcess', 'legalServices', 'Lodge Court Process', NULL, 'c', 0, 5.00, 0.00, 0.00, 0, NULL, NULL, NULL);
	--INSERT INTO application.request_type(code,request_category_code,display_value,description,status,nr_days_to_complete,base_fee,area_base_fee,value_base_fee,nr_properties_required,notation_template,rrr_type_code,type_action_code) VALUES ('disputeReg', 'legalServices', 'Lodge Regularization Dispute', NULL, 'c', 0, 5.00, 0.00, 0.00, 0, NULL, NULL, NULL);
	--INSERT INTO application.request_type(code,request_category_code,display_value,description,status,nr_days_to_complete,base_fee,area_base_fee,value_base_fee,nr_properties_required,notation_template,rrr_type_code,type_action_code) VALUES ('disputeSpdic', 'legalServices', 'Lodge Sporadic Dispute', NULL, 'c', 0, 5.00, 0.00, 0.00, 0, NULL, NULL, NULL);
	--INSERT INTO application.request_type(code,request_category_code,display_value,description,status,nr_days_to_complete,base_fee,area_base_fee,value_base_fee,nr_properties_required,notation_template,rrr_type_code,type_action_code) VALUES ('dispute', 'legalServices', 'Lodge Dispute', NULL, 'c', 0, 5.00, 0.00, 0.00, 0, NULL, NULL, NULL);
	INSERT INTO application.request_type(code,request_category_code,display_value,description,status,nr_days_to_complete,base_fee,area_base_fee,value_base_fee,nr_properties_required,notation_template,rrr_type_code,type_action_code) VALUES ('exemptionApp', 'registrationServices', 'Ground Rent Exemption Application', NULL, 'c', 0, 0.00, 0.00, 0.00, 0, NULL, NULL, NULL);
	INSERT INTO application.request_type(code,request_category_code,display_value,description,status,nr_days_to_complete,base_fee,area_base_fee,value_base_fee,nr_properties_required,notation_template,rrr_type_code,type_action_code) VALUES ('copyLostDeed', 'registrationServices', 'Copy of Lost Deed::::kopi ea deed', NULL, 'x', 0, 0.00, 0.00, 0.00, 0, NULL, NULL, NULL);
	--INSERT INTO application.request_type(code,request_category_code,display_value,description,status,nr_days_to_complete,base_fee,area_base_fee,value_base_fee,nr_properties_required,notation_template,rrr_type_code,type_action_code) VALUES ('regVarLease', 'registrationServices', 'Register Variation of Lease', NULL, 'c', 0, 5.00, 0.00, 0.00, 1, NULL, NULL, NULL);
	INSERT INTO application.request_type(code,request_category_code,display_value,description,status,nr_days_to_complete,base_fee,area_base_fee,value_base_fee,nr_properties_required,notation_template,rrr_type_code,type_action_code) VALUES ('regSpecNotBond', 'registrationServices', 'Register Special Notarial Bond', NULL, 'x', 0, 5.00, 0.00, 0.00, 0, NULL, NULL, NULL);
	INSERT INTO application.request_type(code,request_category_code,display_value,description,status,nr_days_to_complete,base_fee,area_base_fee,value_base_fee,nr_properties_required,notation_template,rrr_type_code,type_action_code) VALUES ('regNotcovBond', 'registrationServices', 'Register Notarial Covering Bond', NULL, 'x', 0, 5.00, 0.00, 0.00, 0, NULL, NULL, NULL);
	INSERT INTO application.request_type(code,request_category_code,display_value,description,status,nr_days_to_complete,base_fee,area_base_fee,value_base_fee,nr_properties_required,notation_template,rrr_type_code,type_action_code) VALUES ('regNotarSuretyBond', 'registrationServices', 'Register Notarial Surety Bond', NULL, 'x', 0, 5.00, 0.00, 0.00, 0, NULL, NULL, NULL);
	INSERT INTO application.request_type(code,request_category_code,display_value,description,status,nr_days_to_complete,base_fee,area_base_fee,value_base_fee,nr_properties_required,notation_template,rrr_type_code,type_action_code) VALUES ('regCessionDeed', 'registrationServices', 'Register Cession of Deed', NULL, 'x', 0, 0.00, 0.00, 0.00, 0, NULL, NULL, NULL);
	INSERT INTO application.request_type(code,request_category_code,display_value,description,status,nr_days_to_complete,base_fee,area_base_fee,value_base_fee,nr_properties_required,notation_template,rrr_type_code,type_action_code) VALUES ('mapSale', 'informationServices', 'Map Sales', NULL, 'c', 0, 0.00, 0.00, 0.00, 0, NULL, NULL, NULL);
	INSERT INTO application.request_type(code,request_category_code,display_value,description,status,nr_days_to_complete,base_fee,area_base_fee,value_base_fee,nr_properties_required,notation_template,rrr_type_code,type_action_code) VALUES ('jointUseLand', 'registrationServices', 'Joint Use of Land Application', NULL, 'x', 0, 0.00, 0.00, 0.00, 1, NULL, NULL, NULL);
	INSERT INTO application.request_type(code,request_category_code,display_value,description,status,nr_days_to_complete,base_fee,area_base_fee,value_base_fee,nr_properties_required,notation_template,rrr_type_code,type_action_code) VALUES ('groundRentCalc', 'informationServices', 'Ground Rent Calculation', NULL, 'c', 0, 0.00, 0.00, 0.00, 0, NULL, NULL, NULL);
	--INSERT INTO application.request_type(code,request_category_code,display_value,description,status,nr_days_to_complete,base_fee,area_base_fee,value_base_fee,nr_properties_required,notation_template,rrr_type_code,type_action_code) VALUES ('printSurveyApp', 'informationServices', 'Print Survey Approval (S10)::::Hatisa S10', NULL, 'c', 0, 0.00, 0.00, 0.00, 0, NULL, NULL, NULL);
	INSERT INTO application.request_type(code,request_category_code,display_value,description,status,nr_days_to_complete,base_fee,area_base_fee,value_base_fee,nr_properties_required,notation_template,rrr_type_code,type_action_code) VALUES ('printSurveyDiag', 'informationServices', 'Print Survey Diagram::::Ngolisa Mapa oa Mapotiele', NULL, 'c', 0, 0.00, 0.00, 0.00, 0, NULL, NULL, NULL);
	INSERT INTO application.request_type(code,request_category_code,display_value,description,status,nr_days_to_complete,base_fee,area_base_fee,value_base_fee,nr_properties_required,notation_template,rrr_type_code,type_action_code) VALUES ('regNotGenBond', 'registrationServices', 'Register Notarial General Bond', NULL, 'x', 0, 5.00, 0.00, 0.00, 0, NULL, NULL, NULL);
	INSERT INTO application.request_type(code,request_category_code,display_value,description,status,nr_days_to_complete,base_fee,area_base_fee,value_base_fee,nr_properties_required,notation_template,rrr_type_code,type_action_code) VALUES ('RegMiningLease', 'registrationServices', 'Register Mining Lease::::Ngolisa Lease ea Mine', NULL, 'x', 0, 0.00, 0.00, 0.00, 0, NULL, NULL, NULL);
	--insert into application.request_type(code, request_category_code, display_value, status, nr_days_to_complete, base_fee, area_base_fee, value_base_fee, nr_properties_required, notation_template, rrr_type_code, type_action_code) values('servitude', 'registrationServices', 'Register Servitude::::registrazione servitu', 'c', 5, 5.00, 0.00, 0, 1, 'Servitude over <parcel1> in favour of <parcel2>', 'servitude', 'new');
	INSERT INTO application.request_type(code,request_category_code,display_value,description,status,nr_days_to_complete,base_fee,area_base_fee,value_base_fee,nr_properties_required,notation_template,rrr_type_code,type_action_code) VALUES ('regSublease', 'registrationServices', 'Register Sublease::::Ngolisa sublease', NULL, 'c', 0, 5.00, 0.00, 0.00, 0, NULL, 'subLease', 'new');
	INSERT INTO application.request_type(code,request_category_code,display_value,description,status,nr_days_to_complete,base_fee,area_base_fee,value_base_fee,nr_properties_required,notation_template,rrr_type_code,type_action_code) VALUES ('varySublease', 'registrationServices', 'Vary Sublease', NULL, 'c', 0, 5.00, 0.00, 0.00, 0, NULL, 'subLease', 'vary');
	INSERT INTO application.request_type(code,request_category_code,display_value,description,status,nr_days_to_complete,base_fee,area_base_fee,value_base_fee,nr_properties_required,notation_template,rrr_type_code,type_action_code) VALUES ('canSublease', 'registrationServices', 'Cancel Sublease', NULL, 'c', 0, 5.00, 0.00, 0.00, 0, NULL, 'subLease', 'cancel');
	INSERT INTO application.request_type(code,request_category_code,display_value,description,status,nr_days_to_complete,base_fee,area_base_fee,value_base_fee,nr_properties_required,notation_template,rrr_type_code,type_action_code) VALUES ('foreignEntHoldTitle', 'registrationServices', 'Foreign Enterprise to Hold Title to Land', NULL, 'x', 0, 0.00, 0.00, 0.00, 0, NULL, NULL, NULL);
	--INSERT INTO application.request_type(code,request_category_code,display_value,description,status,nr_days_to_complete,base_fee,area_base_fee,value_base_fee,nr_properties_required,notation_template,rrr_type_code,type_action_code) VALUES ('regSurrenderLease', 'registrationServices', 'Register Surrender of a Lease', NULL, 'c', 0, 0.00, 0.00, 0.00, 0, NULL, NULL, NULL);
	INSERT INTO application.request_type(code,request_category_code,display_value,description,status,nr_days_to_complete,base_fee,area_base_fee,value_base_fee,nr_properties_required,notation_template,rrr_type_code,type_action_code) VALUES ('printAllocMap', 'informationServices', 'Print Allocation Maps::::Hatisa Mapa', NULL, 'x', 0, 0.00, 0.00, 0.00, 0, NULL, NULL, NULL);
	INSERT INTO application.request_type(code,request_category_code,display_value,description,status,nr_days_to_complete,base_fee,area_base_fee,value_base_fee,nr_properties_required,notation_template,rrr_type_code,type_action_code) VALUES ('leaseTrans', 'legalServices', 'Application for Lease Transmission', NULL, 'x', 0, 0.00, 0.00, 0.00, 0, NULL, NULL, NULL);
	INSERT INTO application.request_type(code,request_category_code,display_value,description,status,nr_days_to_complete,base_fee,area_base_fee,value_base_fee,nr_properties_required,notation_template,rrr_type_code,type_action_code) VALUES ('leaseSubdiv', 'legalServices', 'Register Lease Subdivision', NULL, 'x', 0, 0.00, 0.00, 0.00, 0, NULL, NULL, NULL);
	INSERT INTO application.request_type(code,request_category_code,display_value,description,status,nr_days_to_complete,base_fee,area_base_fee,value_base_fee,nr_properties_required,notation_template,rrr_type_code,type_action_code) VALUES ('transmitJointLease', 'legalServices', 'Application for transmission of a Lease held Jointly', NULL, 'x', 0, 0.00, 0.00, 0.00, 0, NULL, NULL, NULL);
	INSERT INTO application.request_type(code,request_category_code,display_value,description,status,nr_days_to_complete,base_fee,area_base_fee,value_base_fee,nr_properties_required,notation_template,rrr_type_code,type_action_code) VALUES ('ministrialConsent', 'registrationServices', 'Ministerial consent for foreign enterprise to hold title to land', NULL, 'x', 0, 0.00, 0.00, 0.00, 0, NULL, NULL, NULL);
	INSERT INTO application.request_type(code,request_category_code,display_value,description,status,nr_days_to_complete,base_fee,area_base_fee,value_base_fee,nr_properties_required,notation_template,rrr_type_code,type_action_code) VALUES ('transferMortgage', 'legalServices', 'Transfer of a Mortgage Bond', NULL, 'x', 0, 0.00, 0.00, 0.00, 0, NULL, NULL, NULL);
	INSERT INTO application.request_type(code,request_category_code,display_value,description,status,nr_days_to_complete,base_fee,area_base_fee,value_base_fee,nr_properties_required,notation_template,rrr_type_code,type_action_code) VALUES ('lostLease', 'legalServices', 'Application for a lost Lease', NULL, 'x', 0, 0.00, 0.00, 0.00, 0, NULL, NULL, NULL);
	INSERT INTO application.request_type(code,request_category_code,display_value,description,status,nr_days_to_complete,base_fee,area_base_fee,value_base_fee,nr_properties_required,notation_template,rrr_type_code,type_action_code) VALUES ('regDeedTransfer', 'registrationServices', 'Register Deed of Transfer', NULL, 'x', 0, 0.00, 0.00, 0.00, 0, NULL, NULL, NULL);
	INSERT INTO application.request_type(code,request_category_code,display_value,description,status,nr_days_to_complete,base_fee,area_base_fee,value_base_fee,nr_properties_required,notation_template,rrr_type_code,type_action_code) VALUES ('surveyApprv', 'registrationServices', 'Application for Approval of Land Survey', NULL, 'c', 1, 0.00, 0.00, 0.00, 0, NULL, NULL, NULL);

	--A Section with status 'x'
	INSERT INTO application.request_type(code,request_category_code,display_value,description,status,nr_days_to_complete,base_fee,area_base_fee,value_base_fee,nr_properties_required,notation_template,rrr_type_code,type_action_code) VALUES ('TraceLeaseTransf', 'registrationServices', 'Trace Lease Transfers and Owners::::Tsoma phetisetso', NULL, 'x', 0, 0.00, 0.00, 0.00, 0, NULL, NULL, NULL);
	INSERT INTO application.request_type(code,request_category_code,display_value,description,status,nr_days_to_complete,base_fee,area_base_fee,value_base_fee,nr_properties_required,notation_template,rrr_type_code,type_action_code) VALUES ('regDeedhypo', 'registrationServices', 'Register Deed of Hypothetication', NULL, 'x', 0, 5.00, 0.00, 0.00, 0, NULL, NULL, NULL);
	INSERT INTO application.request_type(code,request_category_code,display_value,description,status,nr_days_to_complete,base_fee,area_base_fee,value_base_fee,nr_properties_required,notation_template,rrr_type_code,type_action_code) VALUES ('regAddendSublease', 'registrationServices', 'Register Addendum to the Sublease', NULL, 'x', 0, 5.00, 0.00, 0.00, 0, NULL, NULL, NULL);
	--INSERT INTO application.request_type(code,request_category_code,display_value,description,status,nr_days_to_complete,base_fee,area_base_fee,value_base_fee,nr_properties_required,notation_template,rrr_type_code,type_action_code) VALUES ('regnDeeds', 'registrationServices', 'Register a Non Land Deed::::Ngolisa deed', NULL, 'c', 0, 0.00, 0.00, 0.00, 0, NULL, NULL, NULL);
	INSERT INTO application.request_type(code,request_category_code,display_value,description,status,nr_days_to_complete,base_fee,area_base_fee,value_base_fee,nr_properties_required,notation_template,rrr_type_code,type_action_code) VALUES ('endorsement', 'registrationServices', 'Apply and Register Endorsement', NULL, 'x', 0, 0.00, 0.00, 0.00, 0, NULL, NULL, NULL);
	INSERT INTO application.request_type(code,request_category_code,display_value,description,status,nr_days_to_complete,base_fee,area_base_fee,value_base_fee,nr_properties_required,notation_template,rrr_type_code,type_action_code) VALUES ('LeaseEndoInherit', 'registrationServices', 'Register Lease Endorsement ', NULL, 'x', 0, 0.00, 0.00, 0.00, 0, NULL, NULL, NULL);
	INSERT INTO application.request_type(code,request_category_code,display_value,description,status,nr_days_to_complete,base_fee,area_base_fee,value_base_fee,nr_properties_required,notation_template,rrr_type_code,type_action_code) VALUES ('variationMortgage', 'registrationServices', 'Change Mortgage::::Phetoho ea Mortgage', 'Variation of Mortgage', 'x', 20, 100.00, 0.00, 0.00, 1, 'Variation of mortgage <reference>', 'mortgage', 'vary');
	INSERT INTO application.request_type(code,request_category_code,display_value,description,status,nr_days_to_complete,base_fee,area_base_fee,value_base_fee,nr_properties_required,notation_template,rrr_type_code,type_action_code) VALUES ('regCessionLease', 'registrationServices', 'Register Cession of Lease', NULL, 'x', 0, 0.00, 0.00, 0.00, 0, NULL, NULL, NULL);

	insert into application.request_type(code, request_category_code, display_value, status, nr_days_to_complete, base_fee, area_base_fee, value_base_fee, nr_properties_required) 
    values('servitudeConsent', 'registrationServices', 'Consent to Private Servitude', 'c', 0, 25.00, 0.10, 0, 1);
    insert into application.request_type(code, request_category_code, display_value, status, nr_days_to_complete, base_fee, area_base_fee, value_base_fee, nr_properties_required) 
    values('transferConsent', 'registrationServices', 'Consent to Transfer', 'c', 0, 25.00, 0.10, 0, 1);
    insert into application.request_type(code, request_category_code, display_value, status, nr_days_to_complete, base_fee, area_base_fee, value_base_fee, nr_properties_required) 
    values('subleaseConsent', 'registrationServices', 'Consent to Sublease', 'c', 0, 25.00, 0.10, 0, 1);
	
	

