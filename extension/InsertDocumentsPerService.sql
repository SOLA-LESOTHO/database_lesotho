-- Attach required document types per application service

DELETE FROM application.request_type_requires_source_type WHERE application.request_type_requires_source_type.request_type_code LIKE 'consentApp';

INSERT INTO application.request_type_requires_source_type(
            source_type_code, request_type_code)
    VALUES ('idVerification', 'consentApp');
INSERT INTO application.request_type_requires_source_type(
            source_type_code, request_type_code)
    VALUES ('valuationRep', 'consentApp');
INSERT INTO application.request_type_requires_source_type(
            source_type_code, request_type_code)
    VALUES ('propertyMarktRep', 'consentApp');
INSERT INTO application.request_type_requires_source_type(
            source_type_code, request_type_code)
    VALUES ('offPaymentRecpt', 'consentApp');
INSERT INTO application.request_type_requires_source_type(
            source_type_code, request_type_code)
    VALUES ('swornAffdt', 'consentApp');
INSERT INTO application.request_type_requires_source_type(
            source_type_code, request_type_code)
    VALUES ('contractForSale', 'consentApp');	
	

DELETE FROM application.request_type_requires_source_type WHERE application.request_type_requires_source_type.request_type_code LIKE 'leaseApp';

INSERT INTO application.request_type_requires_source_type(
            source_type_code, request_type_code)
    VALUES ('declareLandHold', 'leaseApp');
INSERT INTO application.request_type_requires_source_type(
            source_type_code, request_type_code)
    VALUES ('cadastralSurvey', 'leaseApp');
INSERT INTO application.request_type_requires_source_type(
            source_type_code, request_type_code)
    VALUES ('idVerification', 'leaseApp');

DELETE FROM application.request_type_requires_source_type WHERE application.request_type_requires_source_type.request_type_code LIKE 'regSublease';

INSERT INTO application.request_type_requires_source_type(
            source_type_code, request_type_code)
    VALUES ('idVerification', 'regSublease');
INSERT INTO application.request_type_requires_source_type(
            source_type_code, request_type_code)
    VALUES ('sublease', 'regSublease');
	


DELETE FROM application.request_type_requires_source_type WHERE application.request_type_requires_source_type.request_type_code LIKE 'regVarLease';

INSERT INTO application.request_type_requires_source_type(
            source_type_code, request_type_code)
    VALUES ('changeUseApp', 'regVarLease');
INSERT INTO application.request_type_requires_source_type(
            source_type_code, request_type_code)
    VALUES ('surveyReport', 'regVarLease');

	
DELETE FROM application.request_type_requires_source_type WHERE application.request_type_requires_source_type.request_type_code LIKE 'leaseTrans';

INSERT INTO application.request_type_requires_source_type(
            source_type_code, request_type_code)
    VALUES ('will', 'leaseTrans');
INSERT INTO application.request_type_requires_source_type(
            source_type_code, request_type_code)
    VALUES ('leaseCopy', 'leaseTrans');
INSERT INTO application.request_type_requires_source_type(
            source_type_code, request_type_code)
    VALUES ('idVerification', 'leaseTrans');	


DELETE FROM application.request_type_requires_source_type WHERE application.request_type_requires_source_type.request_type_code LIKE 'leaseSubdiv';

INSERT INTO application.request_type_requires_source_type(
            source_type_code, request_type_code)
    VALUES ('landUseCert', 'leaseSubdiv');
INSERT INTO application.request_type_requires_source_type(
            source_type_code, request_type_code)
    VALUES ('surveyPlan', 'leaseSubdiv');
INSERT INTO application.request_type_requires_source_type(
            source_type_code, request_type_code)
    VALUES ('declareLandHold', 'leaseSubdiv');	
	
	
	
DELETE FROM application.request_type_requires_source_type WHERE application.request_type_requires_source_type.request_type_code LIKE 'transmitJointLease';

INSERT INTO application.request_type_requires_source_type(
            source_type_code, request_type_code)
    VALUES ('deathCert', 'transmitJointLease');
INSERT INTO application.request_type_requires_source_type(
            source_type_code, request_type_code)
    VALUES ('marriageCert', 'transmitJointLease');
INSERT INTO application.request_type_requires_source_type(
            source_type_code, request_type_code)
    VALUES ('idVerification', 'transmitJointLease');	

	
--Attach an Application form to every service provided by LAA

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
    VALUES ('appForm', 'consentApp');
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
    VALUES ('appForm', 'exempApp');
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
    VALUES ('appForm', 'transmitJointLease');

INSERT INTO application.request_type_requires_source_type(
            source_type_code, request_type_code)
    VALUES ('appForm', 'leaseApp');
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
    VALUES ('appForm', 'regDeedhypo');
INSERT INTO application.request_type_requires_source_type(
            source_type_code, request_type_code)
    VALUES ('appForm', 'regTitleDeed');
	
	

	
