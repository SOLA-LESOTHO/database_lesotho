	-- Attach required document types per application service

	DELETE FROM application.request_type_requires_source_type WHERE application.request_type_requires_source_type.request_type_code LIKE 'leaseTransfer';

	--INSERT INTO application.request_type_requires_source_type(
	--			source_type_code, request_type_code)
	--	VALUES ('idVerification', 'leaseTransfer');
	--INSERT INTO application.request_type_requires_source_type(
	--			source_type_code, request_type_code)
	--	VALUES ('valuationReport', 'leaseTransfer');
	--INSERT INTO application.request_type_requires_source_type(
	--			source_type_code, request_type_code)
	--	VALUES ('offPaymentRecpt', 'leaseTransfer');
	--INSERT INTO application.request_type_requires_source_type(
	--			source_type_code, request_type_code)
	--	VALUES ('marriageCert', 'leaseTransfer');	
	--INSERT INTO application.request_type_requires_source_type(
	--			source_type_code, request_type_code)
	--	VALUES ('deathCert', 'leaseTransfer');
	--INSERT INTO application.request_type_requires_source_type(
	--			source_type_code, request_type_code)
	--	VALUES ('leaseCopy', 'leaseTransfer');	
	--INSERT INTO application.request_type_requires_source_type(
	--			source_type_code, request_type_code)
	--	VALUES ('contractForSale', 'leaseTransfer');	
		

	DELETE FROM application.request_type_requires_source_type WHERE application.request_type_requires_source_type.request_type_code LIKE 'registerLease';

	--INSERT INTO application.request_type_requires_source_type(
	--			source_type_code, request_type_code)
	--	VALUES ('declareLandHold', 'registerLease');
	--INSERT INTO application.request_type_requires_source_type(
	--			source_type_code, request_type_code)
	--	VALUES ('cadastralSurvey', 'registerLease');
	--INSERT INTO application.request_type_requires_source_type(
	--			source_type_code, request_type_code)
	--	VALUES ('deed', 'registerLease');
	--INSERT INTO application.request_type_requires_source_type(
	--			source_type_code, request_type_code)
	--	VALUES ('groundRentExemp', 'registerLease');
	--INSERT INTO application.request_type_requires_source_type(
	--			source_type_code, request_type_code)
	--	VALUES ('idVerification', 'registerLease');
	--INSERT INTO application.request_type_requires_source_type(
	--			source_type_code, request_type_code)
	--	VALUES ('marriageCert', 'registerLease');
	--INSERT INTO application.request_type_requires_source_type(
	--			source_type_code, request_type_code)
	--	VALUES ('landUseCert', 'registerLease');	
		
		
	DELETE FROM application.request_type_requires_source_type WHERE application.request_type_requires_source_type.request_type_code LIKE 'regSublease';

	--INSERT INTO application.request_type_requires_source_type(
	--			source_type_code, request_type_code)
	--	VALUES ('idVerification', 'regSublease');
	--INSERT INTO application.request_type_requires_source_type(
	--			source_type_code, request_type_code)
	--	VALUES ('sublease', 'regSublease');
	--INSERT INTO application.request_type_requires_source_type(
	--			source_type_code, request_type_code)
	--	VALUES ('leaseCopy', 'regSublease');
	--INSERT INTO application.request_type_requires_source_type(
	--			source_type_code, request_type_code)
	--	VALUES ('declareLandHold', 'regSublease');	
	--INSERT INTO application.request_type_requires_source_type(
	--			source_type_code, request_type_code)
	--	VALUES ('offPaymentRecpt', 'regSublease');	
	--INSERT INTO application.request_type_requires_source_type(
	--			source_type_code, request_type_code)
	--	VALUES ('groundRentExemp', 'regSublease');	


	--DELETE FROM application.request_type_requires_source_type WHERE application.request_type_requires_source_type.request_type_code LIKE 'varyLease';

	--INSERT INTO application.request_type_requires_source_type(
	--			source_type_code, request_type_code)
	--	VALUES ('letterCouncil', 'varyLease');
	--INSERT INTO application.request_type_requires_source_type(
	--			source_type_code, request_type_code)
	--	VALUES ('copyLease', 'varyLease');
	--INSERT INTO application.request_type_requires_source_type(
	--			source_type_code, request_type_code)
	--	VALUES ('lease', 'varyLease');	
	--INSERT INTO application.request_type_requires_source_type(
	--			source_type_code, request_type_code)
	--	VALUES ('idVerification', 'varyLease');	
	--INSERT INTO application.request_type_requires_source_type(
	--			source_type_code, request_type_code)
	--	VALUES ('groundRentExemp', 'varyLease');	
		
	DELETE FROM application.request_type_requires_source_type WHERE application.request_type_requires_source_type.request_type_code LIKE 'leaseTrans';

	--INSERT INTO application.request_type_requires_source_type(
	--			source_type_code, request_type_code)
	--	VALUES ('will', 'leaseTrans');
	--INSERT INTO application.request_type_requires_source_type(
	--			source_type_code, request_type_code)
	--	VALUES ('lease', 'leaseTrans');
	--INSERT INTO application.request_type_requires_source_type(
	--			source_type_code, request_type_code)
	--	VALUES ('idVerification', 'leaseTrans');	
	--INSERT INTO application.request_type_requires_source_type(
	--			source_type_code, request_type_code)
	--	VALUES ('deathCert', 'leaseTrans');	
	--INSERT INTO application.request_type_requires_source_type(
	--			source_type_code, request_type_code)
	--	VALUES ('groundRentExemp', 'leaseTrans');
	--INSERT INTO application.request_type_requires_source_type(
	--			source_type_code, request_type_code)
	--	VALUES ('declareLandHold', 'leaseTrans');	
	--INSERT INTO application.request_type_requires_source_type(
	--			source_type_code, request_type_code)
	--	VALUES ('trust', 'leaseTrans');	



	DELETE FROM application.request_type_requires_source_type WHERE application.request_type_requires_source_type.request_type_code LIKE 'leaseSubdiv';

	--INSERT INTO application.request_type_requires_source_type(
	--			source_type_code, request_type_code)
	--	VALUES ('landUseCert', 'leaseSubdiv');
	--INSERT INTO application.request_type_requires_source_type(
	--			source_type_code, request_type_code)
	--	VALUES ('cadastralMap', 'leaseSubdiv');
	--INSERT INTO application.request_type_requires_source_type(
	--			source_type_code, request_type_code)
	--	VALUES ('declareLandHold', 'leaseSubdiv');	
	--INSERT INTO application.request_type_requires_source_type(
	--			source_type_code, request_type_code)
	--	VALUES ('consentCert', 'leaseSubdiv');	
	--INSERT INTO application.request_type_requires_source_type(
	--			source_type_code, request_type_code)
	--	VALUES ('idVerification','leaseSubdiv');
	--INSERT INTO application.request_type_requires_source_type(
	--			source_type_code, request_type_code)
	--	VALUES ('lease', 'leaseSubdiv');
	--INSERT INTO application.request_type_requires_source_type(
	--			source_type_code, request_type_code)
	--	VALUES ('offPaymentRecpt', 'leaseSubdiv');
	--INSERT INTO application.request_type_requires_source_type(
	--			source_type_code, request_type_code)
	--	VALUES ('groundRentExemp', 'leaseSubdiv');

		
	DELETE FROM application.request_type_requires_source_type WHERE application.request_type_requires_source_type.request_type_code LIKE 'transmitJointLease';

	--INSERT INTO application.request_type_requires_source_type(
	--			source_type_code, request_type_code)
	--	VALUES ('deathCert', 'transmitJointLease');
	--INSERT INTO application.request_type_requires_source_type(
	--			source_type_code, request_type_code)
	--	VALUES ('marriageCert', 'transmitJointLease');
	--INSERT INTO application.request_type_requires_source_type(
	--			source_type_code, request_type_code)
	--	VALUES ('idVerification', 'transmitJointLease');	
	--INSERT INTO application.request_type_requires_source_type(
	--			source_type_code, request_type_code)
	--	VALUES ('lease', 'transmitJointLease');
		
		
	DELETE FROM application.request_type_requires_source_type WHERE application.request_type_requires_source_type.request_type_code LIKE 'mortgage';

	INSERT INTO application.request_type_requires_source_type(
				source_type_code, request_type_code)
		VALUES ('deed', 'mortgage');
	--INSERT INTO application.request_type_requires_source_type(
	--			source_type_code, request_type_code)
	--	VALUES ('consentCert', 'mortgage');
	--INSERT INTO application.request_type_requires_source_type(
	--			source_type_code, request_type_code)
	--	VALUES ('lease', 'mortgage');	
	--INSERT INTO application.request_type_requires_source_type(
	--			source_type_code, request_type_code)
	--	VALUES ('certIncorp', 'mortgage');
	--INSERT INTO application.request_type_requires_source_type(
	--			source_type_code, request_type_code)
	--	VALUES ('taxClrCert', 'mortgage');
	--INSERT INTO application.request_type_requires_source_type(
	--			source_type_code, request_type_code)
	--	VALUES ('appForm', 'mortgage');
		
	DELETE FROM application.request_type_requires_source_type WHERE application.request_type_requires_source_type.request_type_code LIKE 'cancelMortBonds';

	--INSERT INTO application.request_type_requires_source_type(
	--			source_type_code, request_type_code)
	--	VALUES ('deed', 'cancelMortBonds');
	--INSERT INTO application.request_type_requires_source_type(
	--			source_type_code, request_type_code)
	--	VALUES ('consentCert', 'cancelMortBonds');
	--INSERT INTO application.request_type_requires_source_type(
	--			source_type_code, request_type_code)
	--	VALUES ('lease', 'cancelMortBonds');	
	--INSERT INTO application.request_type_requires_source_type(
	--			source_type_code, request_type_code)
	--	VALUES ('certIncorp', 'cancelMortBonds');
	--INSERT INTO application.request_type_requires_source_type(
	--			source_type_code, request_type_code)
	--	VALUES ('taxClrCert', 'cancelMortBonds');
	--INSERT INTO application.request_type_requires_source_type(
	--			source_type_code, request_type_code)
	--	VALUES ('appForm', 'cancelMortBonds');	
		
	DELETE FROM application.request_type_requires_source_type WHERE application.request_type_requires_source_type.request_type_code LIKE 'cedeMortgage';

	--INSERT INTO application.request_type_requires_source_type(
	--			source_type_code, request_type_code)
	--	VALUES ('deed', 'cedeMortgage');
	--INSERT INTO application.request_type_requires_source_type(
	--			source_type_code, request_type_code)
	--	VALUES ('consentCert', 'cedeMortgage');
	--INSERT INTO application.request_type_requires_source_type(
	--			source_type_code, request_type_code)
	--	VALUES ('lease', 'cedeMortgage');	
	--INSERT INTO application.request_type_requires_source_type(
	--			source_type_code, request_type_code)
	--	VALUES ('certIncorp', 'cedeMortgage');
	--INSERT INTO application.request_type_requires_source_type(
	--			source_type_code, request_type_code)
	--	VALUES ('taxClrCert', 'cedeMortgage');
	--INSERT INTO application.request_type_requires_source_type(
	--			source_type_code, request_type_code)
	--	VALUES ('appForm', 'cedeMortgage');


	DELETE FROM application.request_type_requires_source_type WHERE application.request_type_requires_source_type.request_type_code LIKE 'lostLease';

	--INSERT INTO application.request_type_requires_source_type(
	--			source_type_code, request_type_code)
	--	VALUES ('will', 'lostLease');
	--INSERT INTO application.request_type_requires_source_type(
	--			source_type_code, request_type_code)
	--	VALUES ('idVerification', 'lostLease');
	--INSERT INTO application.request_type_requires_source_type(
	--			source_type_code, request_type_code)
	--	VALUES ('deathCert', 'lostLease');	
	--INSERT INTO application.request_type_requires_source_type(
	--			source_type_code, request_type_code)
	--	VALUES ('marriageCert', 'lostLease');
	--INSERT INTO application.request_type_requires_source_type(
	--			source_type_code, request_type_code)
	--	VALUES ('courtOrder', 'lostLease');
		
	DELETE FROM application.request_type_requires_source_type WHERE application.request_type_requires_source_type.request_type_code LIKE 'transferMortgage';

	--INSERT INTO application.request_type_requires_source_type(
	--			source_type_code, request_type_code)
	--	VALUES ('deed', 'transferMortgage');
	--INSERT INTO application.request_type_requires_source_type(
	--			source_type_code, request_type_code)
	--	VALUES ('consentCert', 'transferMortgage');
	--INSERT INTO application.request_type_requires_source_type(
	--			source_type_code, request_type_code)
	--	VALUES ('lease', 'transferMortgage');	
	--INSERT INTO application.request_type_requires_source_type(
	--			source_type_code, request_type_code)
	--	VALUES ('certIncorp', 'transferMortgage');
	--INSERT INTO application.request_type_requires_source_type(
	--			source_type_code, request_type_code)
	--	VALUES ('taxClrCert', 'transferMortgage');
	--INSERT INTO application.request_type_requires_source_type(
	--			source_type_code, request_type_code)
	--	VALUES ('appForm', 'transferMortgage');

		
		
	DELETE FROM application.request_type_requires_source_type WHERE application.request_type_requires_source_type.request_type_code LIKE 'ministrialConsent';

	--INSERT INTO application.request_type_requires_source_type(
				source_type_code, request_type_code)
	--	VALUES ('ministerialCons', 'ministrialConsent');
	--INSERT INTO application.request_type_requires_source_type(
	--			source_type_code, request_type_code)
	--	VALUES ('idVerification', 'ministrialConsent');
	--INSERT INTO application.request_type_requires_source_type(
	--			source_type_code, request_type_code)
	--	VALUES ('groundRentExemp', 'ministrialConsent');
	--INSERT INTO application.request_type_requires_source_type(
	--			source_type_code, request_type_code)
	--	VALUES ('offPaymentRecpt', 'ministrialConsent');
	--INSERT INTO application.request_type_requires_source_type(
	--			source_type_code, request_type_code)
	--	VALUES ('declareLandHold', 'ministrialConsent');	
	--INSERT INTO application.request_type_requires_source_type(
	--			source_type_code, request_type_code)
	--	VALUES ('memoAssoc', 'ministrialConsent');	
	--INSERT INTO application.request_type_requires_source_type(
	--			source_type_code, request_type_code)
	--	VALUES ('certIncorp', 'ministrialConsent');	

		
	--DELETE FROM application.request_type_requires_source_type WHERE application.request_type_requires_source_type.request_type_code LIKE 'exemptionApp';

	--INSERT INTO application.request_type_requires_source_type(
	--			source_type_code, request_type_code)
	--	VALUES ('idVerification', 'exemptionApp');
	--INSERT INTO application.request_type_requires_source_type(
	--			source_type_code, request_type_code)
	--	VALUES ('leaseCopy', 'exemptionApp');
	--INSERT INTO application.request_type_requires_source_type(
	--			source_type_code, request_type_code)
	--	VALUES ('appForm', 'exemptionApp');
		

	--Attach an Application form to every service provided by LAA
	DELETE FROM application.request_type_requires_source_type WHERE application.request_type_requires_source_type.source_type_code LIKE 'appForm';

	INSERT INTO application.request_type_requires_source_type(
				source_type_code, request_type_code)
		VALUES ('appForm', 'regnReducMortgage');
	INSERT INTO application.request_type_requires_source_type(
				source_type_code, request_type_code)
		VALUES ('appForm', 'cancServitude');
	INSERT INTO application.request_type_requires_source_type(
				source_type_code, request_type_code)
		VALUES ('appForm', 'regnDeeds');
	INSERT INTO application.request_type_requires_source_type(
				source_type_code, request_type_code)
		VALUES ('appForm', 'cnclPowerOfAttorney');
	INSERT INTO application.request_type_requires_source_type(
				source_type_code, request_type_code)
		VALUES ('appForm', 'cnclDocument');
	INSERT INTO application.request_type_requires_source_type(
				source_type_code, request_type_code)
		VALUES ('appForm', 'provideSpatialData');
	INSERT INTO application.request_type_requires_source_type(
				source_type_code, request_type_code)
		VALUES ('appForm', 'cadastreChange');
	INSERT INTO application.request_type_requires_source_type(
				source_type_code, request_type_code)
		VALUES ('appForm', 'caveat');
	INSERT INTO application.request_type_requires_source_type(
				source_type_code, request_type_code)
		VALUES ('appForm', 'documentSearch');
	INSERT INTO application.request_type_requires_source_type(
				source_type_code, request_type_code)
		VALUES ('appForm', 'servitude');
	INSERT INTO application.request_type_requires_source_type(
				source_type_code, request_type_code)
		VALUES ('appForm', 'cancelMortBonds');
	INSERT INTO application.request_type_requires_source_type(
				source_type_code, request_type_code)
		VALUES ('appForm', 'leaseTransfer');
	INSERT INTO application.request_type_requires_source_type(
				source_type_code, request_type_code)
		VALUES ('appForm', 'regRedMortBond');
	INSERT INTO application.request_type_requires_source_type(
				source_type_code, request_type_code)
		VALUES ('appForm', 'counterClaim');
	INSERT INTO application.request_type_requires_source_type(
				source_type_code, request_type_code)
		VALUES ('appForm', 'courtProcess');
	INSERT INTO application.request_type_requires_source_type(
				source_type_code, request_type_code)
		VALUES ('appForm', 'disputeReg');
	INSERT INTO application.request_type_requires_source_type(
				source_type_code, request_type_code)
		VALUES ('appForm', 'disputeSpdic');
	INSERT INTO application.request_type_requires_source_type(
				source_type_code, request_type_code)
		VALUES ('appForm', 'exemptionApp');
	INSERT INTO application.request_type_requires_source_type(
				source_type_code, request_type_code)
		VALUES ('appForm', 'documentCopy');
	INSERT INTO application.request_type_requires_source_type(
				source_type_code, request_type_code)
		VALUES ('appForm', 'copyLostDeed');
	INSERT INTO application.request_type_requires_source_type(
				source_type_code, request_type_code)
		VALUES ('appForm', 'serviceEnquiry');
	INSERT INTO application.request_type_requires_source_type(
				source_type_code, request_type_code)
		VALUES ('appForm', 'mortgage');
	INSERT INTO application.request_type_requires_source_type(
				source_type_code, request_type_code)
		VALUES ('appForm', 'regSpecNotBond');
	INSERT INTO application.request_type_requires_source_type(
				source_type_code, request_type_code)
		VALUES ('appForm', 'regNotcovBond');
	INSERT INTO application.request_type_requires_source_type(
				source_type_code, request_type_code)
		VALUES ('appForm', 'regCessionDeed');
	INSERT INTO application.request_type_requires_source_type(
				source_type_code, request_type_code)
		VALUES ('appForm', 'mapSale');
	INSERT INTO application.request_type_requires_source_type(
				source_type_code, request_type_code)
		VALUES ('appForm', 'jointUseLand');
	INSERT INTO application.request_type_requires_source_type(
				source_type_code, request_type_code)
		VALUES ('appForm', 'groundRentCalc');
	INSERT INTO application.request_type_requires_source_type(
				source_type_code, request_type_code)
		VALUES ('appForm', 'printSurveyApp');
	INSERT INTO application.request_type_requires_source_type(
				source_type_code, request_type_code)
		VALUES ('appForm', 'printSurveyDiag');
	INSERT INTO application.request_type_requires_source_type(
				source_type_code, request_type_code)
		VALUES ('appForm', 'regDeedTransfer');
	INSERT INTO application.request_type_requires_source_type(
				source_type_code, request_type_code)
		VALUES ('appForm', 'regNotGenBond');
	INSERT INTO application.request_type_requires_source_type(
				source_type_code, request_type_code)
		VALUES ('appForm', 'RegMiningLease');
	INSERT INTO application.request_type_requires_source_type(
				source_type_code, request_type_code)
		VALUES ('appForm', 'regNotDeedSer');
	INSERT INTO application.request_type_requires_source_type(
				source_type_code, request_type_code)
		VALUES ('appForm', 'examSurveyFiles');
	INSERT INTO application.request_type_requires_source_type(
				source_type_code, request_type_code)
		VALUES ('appForm', 'foreignEntHoldTitle');
	INSERT INTO application.request_type_requires_source_type(
				source_type_code, request_type_code)
		VALUES ('appForm', 'regSurrenderLease');
	INSERT INTO application.request_type_requires_source_type(
				source_type_code, request_type_code)
		VALUES ('appForm', 'printAllocMap');
	INSERT INTO application.request_type_requires_source_type(
				source_type_code, request_type_code)
		VALUES ('appForm', 'newOwnership');
	INSERT INTO application.request_type_requires_source_type(
				source_type_code, request_type_code)
		VALUES ('appForm', 'transmitJointLease');
	INSERT INTO application.request_type_requires_source_type(
				source_type_code, request_type_code)
		VALUES ('appForm', 'ministrialConsent');
	INSERT INTO application.request_type_requires_source_type(
				source_type_code, request_type_code)
		VALUES ('appForm', 'registerLease');
	INSERT INTO application.request_type_requires_source_type(
				source_type_code, request_type_code)
		VALUES ('appForm', 'varyLease');
	INSERT INTO application.request_type_requires_source_type(
				source_type_code, request_type_code)
		VALUES ('appForm', 'regSublease');
	INSERT INTO application.request_type_requires_source_type(
				source_type_code, request_type_code)
		VALUES ('appForm', 'leaseSubdiv');
	INSERT INTO application.request_type_requires_source_type(
				source_type_code, request_type_code)
		VALUES ('appForm', 'newDigitalTitle');
	INSERT INTO application.request_type_requires_source_type(
				source_type_code, request_type_code)
		VALUES ('appForm', 'regDeedhypo');
	INSERT INTO application.request_type_requires_source_type(
				source_type_code, request_type_code)
		VALUES ('appForm', 'leaseTrans');	
	INSERT INTO application.request_type_requires_source_type(
				source_type_code, request_type_code)
		VALUES ('appForm', 'surveyPlanCopy');		

		
