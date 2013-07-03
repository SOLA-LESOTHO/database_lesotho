--DEFINING GROUPS (appgroup)
insert into system.appgroup(id, name, description) values('cust-manager-id', 'Customer Services Manager group', 'This is a group of Customer Services Management that has right in all customer services activities.');
insert into system.appgroup(id, name, description) values('cust-reps-id', 'Customer Services Representatives group', 'This is a group of Customer Services Representatives.');
insert into system.appgroup(id, name, description) values('deeds-manager-id', 'Deeds Registrar Manager group', 'This is a group of Deeds Registrar Management that has right in all deeds services activities.');
insert into system.appgroup(id, name, description) values('deeds-reps-id', 'Deeds Assistant Registrar group', 'This is a group of Deeds Assistant Registrars');
insert into system.appgroup(id, name, description) values('lease-id', 'Lease Services group', 'This is a group of users who process leases.');
insert into system.appgroup(id, name, description) values('surveymapp-id', 'Survey and Mapping group', 'This is a group of Survey and Mapping.');
insert into system.appgroup(id, name, description) values('legal-id', 'Legal group', 'This is a group for Legal Representatives.');
insert into system.appgroup(id, name, description) values('administrator-id', 'System group', 'This is a group of system administrators that has right in all activities.');


--ADDING A LITS OF USERS
--Legal users
insert into system.appuser(id, username, first_name, last_name, passwd, active) values('mmolato-id', 'mmolato', 'Mangaka', 'Molato', '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08', true);
insert into system.appuser(id, username, first_name, last_name, passwd, active) values('mmolupe-id', 'mmolupe', 'Mpho', 'Molupe', '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08', true);
--Survey and Maping users
insert into system.appuser(id, username, first_name, last_name, passwd, active) values('mrammoko-id', 'mrammoko', 'Malefetsane', 'Rammoko', '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08', true);
insert into system.appuser(id, username, first_name, last_name, passwd, active) values('mmoleli-id', 'mmoleli', 'Mochoni', 'Moleli', '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08', true);
insert into system.appuser(id, username, first_name, last_name, passwd, active) values('smatela-id', 'smatela', 'Maloi', 'Matela', '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08', true);
insert into system.appuser(id, username, first_name, last_name, passwd, active) values('mramakau-id', 'mramakau', 'Moeketsi', 'Ramakau', '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08', true);
insert into system.appuser(id, username, first_name, last_name, passwd, active) values('nmokhethi-id', 'nmokhethi', 'Ntho', 'Mekhethi', '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08', true);
insert into system.appuser(id, username, first_name, last_name, passwd, active) values('lnovember-id', 'lnovember', 'Lehlohonolo', 'November', '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08', true);
insert into system.appuser(id, username, first_name, last_name, passwd, active) values('pkoloi-id', 'pkoloi', 'Pitso', 'Koloi', '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08', true);
insert into system.appuser(id, username, first_name, last_name, passwd, active) values('mboiketlo-id', 'mboiketlo', 'Boiketlo', 'Moloi', '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08', true);
insert into system.appuser(id, username, first_name, last_name, passwd, active) values('ksebothoane-id', 'ksebothoane', 'Sebothoane', 'Kabi', '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08', true);
--Lease users
insert into system.appuser(id, username, first_name, last_name, passwd, active) values('mmojakhomo-id', 'mmojakhomo', 'Motselisi', 'Mojakhomo', '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08', true);
insert into system.appuser(id, username, first_name, last_name, passwd, active) values('tmosaase-id', 'tmosaase', 'Thandi', 'Mosaase', '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08', true);
insert into system.appuser(id, username, first_name, last_name, passwd, active) values('lmatlatsa-id', 'lmatlatsa', 'Lebakeng', 'Matlatsa', '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08', true);
insert into system.appuser(id, username, first_name, last_name, passwd, active) values('omokone-id', 'omokone', 'Orpen', 'Mokone', '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08', true);
insert into system.appuser(id, username, first_name, last_name, passwd, active) values('mmabela-id', 'mmabela', 'Beatrice', 'Mabela', '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08', true);
insert into system.appuser(id, username, first_name, last_name, passwd, active) values('tmaketela-id', 'tmaketela', 'Thabang', 'Maketela', '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08', true);
--Deeds users
insert into system.appuser(id, username, first_name, last_name, passwd, active) values('mmoshoeshoe-id', 'mmoshoeshoe', 'Mankoebe', 'Moshoeshoe', '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08', true);
insert into system.appuser(id, username, first_name, last_name, passwd, active) values('mletsie-id', 'mletsie', 'Maseni', 'Letsie', '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08', true);
insert into system.appuser(id, username, first_name, last_name, passwd, active) values('tshale-id', 'tshale', 'Thabiso', 'Shale', '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08', true);
insert into system.appuser(id, username, first_name, last_name, passwd, active) values('mramakhula-id', 'mramakhula', 'Mathe', 'Ramakhula', '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08', true);
--Customer Service users
insert into system.appuser(id, username, first_name, last_name, passwd, active) values('mputsoa-id', 'mputsoa', 'Ntsebo', 'Putsoa', '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08', true);
insert into system.appuser(id, username, first_name, last_name, passwd, active) values('mmohajane-id', 'mmohajane', 'Molelekeng', 'Mohajane', '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08', true);
insert into system.appuser(id, username, first_name, last_name, passwd, active) values('mmphutlane-id', 'mmphutlane', 'Mampolelo', 'Mphutlane', '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08', true);
insert into system.appuser(id, username, first_name, last_name, passwd, active) values('ralotsi-id', 'ralotsi', 'Relebohile', 'Alotsi', '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08', true);
insert into system.appuser(id, username, first_name, last_name, passwd, active) values('lshabe-id', 'lshabe', 'Llang', 'Shabe', '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08', true);
insert into system.appuser(id, username, first_name, last_name, passwd, active) values('slerotholi-id', 'slerotholi', 'Seeng', 'Lerotholi', '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08', true);
insert into system.appuser(id, username, first_name, last_name, passwd, active) values('mtsabeng-id', 'mtsabeng', 'Malepekola', 'Tsabeng', '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08', true);
insert into system.appuser(id, username, first_name, last_name, passwd, active) values('ttau-id', 'ttau', 'Thakane', 'Tau', '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08', true);
--IT Users
insert into system.appuser(id, username, first_name, last_name, passwd, active) values('knkalai-id', 'knkalai', 'Khopotso', 'Nkalai', '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08', true);
insert into system.appuser(id, username, first_name, last_name, passwd, active) values('ilengoasa-id', 'ilengoasa', 'Itumeleng', 'Lengoasa', '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08', true);
insert into system.appuser(id, username, first_name, last_name, passwd, active) values('tphoofolo-id', 'phoofe', 'Tlali', 'Phoofolo', '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08', true);
insert into system.appuser(id, username, first_name, last_name, passwd, active) values('lsekonyela-id', 'lsekonyela', 'Lebaka', 'Sekonyela', '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08', true);

-- MAPPING USERS WITH GROUPS (system.appuser_appgroup) 
--legal
insert into system.appuser_appgroup(appuser_id, appgroup_id) values('mmolato-id', 'legal-id');
insert into system.appuser_appgroup(appuser_id, appgroup_id) values('mmolupe-id', 'legal-id');
--Survey and Mapping
insert into system.appuser_appgroup(appuser_id, appgroup_id) values('mrammoko-id', 'surveymapp-id');
insert into system.appuser_appgroup(appuser_id, appgroup_id) values('mmoleli-id', 'surveymapp-id');
insert into system.appuser_appgroup(appuser_id, appgroup_id) values('smatela-id', 'surveymapp-id');
insert into system.appuser_appgroup(appuser_id, appgroup_id) values('mramakau-id', 'surveymapp-id');
insert into system.appuser_appgroup(appuser_id, appgroup_id) values('nmokhethi-id', 'surveymapp-id');
insert into system.appuser_appgroup(appuser_id, appgroup_id) values('lnovember-id', 'surveymapp-id');
insert into system.appuser_appgroup(appuser_id, appgroup_id) values('pkoloi-id', 'surveymapp-id');
insert into system.appuser_appgroup(appuser_id, appgroup_id) values('mboiketlo-id', 'surveymapp-id');
insert into system.appuser_appgroup(appuser_id, appgroup_id) values('ksebothoane-id', 'surveymapp-id');
--Lease
insert into system.appuser_appgroup(appuser_id, appgroup_id) values('mmojakhomo-id', 'lease-id');
insert into system.appuser_appgroup(appuser_id, appgroup_id) values('tmosaase-id', 'lease-id');
insert into system.appuser_appgroup(appuser_id, appgroup_id) values('lmatlatsa-id', 'lease-id');
insert into system.appuser_appgroup(appuser_id, appgroup_id) values('omokone-id', 'lease-id');
insert into system.appuser_appgroup(appuser_id, appgroup_id) values('mmabela-id', 'lease-id');
insert into system.appuser_appgroup(appuser_id, appgroup_id) values('tmaketela-id', 'lease-id');
--Deeds
insert into system.appuser_appgroup(appuser_id, appgroup_id) values('mmoshoeshoe-id', 'deeds-manager-id');
insert into system.appuser_appgroup(appuser_id, appgroup_id) values('mletsie-id', 'deeds-reps-id');
insert into system.appuser_appgroup(appuser_id, appgroup_id) values('tshale-id', 'deeds-reps-id');
insert into system.appuser_appgroup(appuser_id, appgroup_id) values('mramakhula-id', 'deeds-reps-id');
--Customer Services
insert into system.appuser_appgroup(appuser_id, appgroup_id) values('mputsoa-id', 'cust-manager-id');
insert into system.appuser_appgroup(appuser_id, appgroup_id) values('mmohajane-id', 'cust-reps-id');
insert into system.appuser_appgroup(appuser_id, appgroup_id) values('mmphutlane-id', 'cust-reps-id');
insert into system.appuser_appgroup(appuser_id, appgroup_id) values('ralotsi-id', 'cust-reps-id');
insert into system.appuser_appgroup(appuser_id, appgroup_id) values('lshabe-id', 'cust-reps-id');
insert into system.appuser_appgroup(appuser_id, appgroup_id) values('slerotholi-id', 'cust-reps-id');
insert into system.appuser_appgroup(appuser_id, appgroup_id) values('mtsabeng-id', 'cust-reps-id');
insert into system.appuser_appgroup(appuser_id, appgroup_id) values('ttau-id', 'cust-reps-id');
--IT
insert into system.appuser_appgroup(appuser_id, appgroup_id) values('knkalai-id', 'administrator-id');
insert into system.appuser_appgroup(appuser_id, appgroup_id) values('ilengoasa-id', 'administrator-id');
insert into system.appuser_appgroup(appuser_id, appgroup_id) values('tphoofolo-id', 'administrator-id');
insert into system.appuser_appgroup(appuser_id, appgroup_id) values('lsekonyela-id', 'administrator-id');

--MAPPING ROLES TO GROUPS

--First load all services into roles
INSERT INTO system.approle (code, display_value, status)
SELECT req.code, req.display_value, 'c'
 FROM   application.request_type req
 WHERE  NOT EXISTS (SELECT r.code FROM system.approle r WHERE req.code = r.code);

--Legal
Delete From system.approle_appgroup
where appgroup_id = 'legal-id';

--system.approle_appgroup
--this is the basic lot of an application processing department
DELETE FROM system.approle_appgroup WHERE approle_code='regSublease' and appgroup_id='super-group-id';
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('regSublease', 'super-group-id');  
DELETE FROM system.approle_appgroup WHERE approle_code='regnDeeds' and appgroup_id='super-group-id';
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('regnDeeds', 'super-group-id'); 


INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('ApplnAssignSelf', 'legal-id');  
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('ApplnStatus', 'legal-id'); 
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('DashbrdViewAssign', 'legal-id');
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('DashbrdViewOwn', 'legal-id');  
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('DashbrdViewUnassign','legal-id');
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('ApplnUnassignSelf', 'legal-id'); 
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('ApplnDispatch', 'legal-id');  
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('ApplnView', 'legal-id');  

INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('BaunitParcelSave', 'legal-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('BauunitrrrSave', 'legal-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('BaunitNotatSave', 'legal-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('CompleteService', 'legal-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('BaunitSave', 'legal-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('ParcelSave', 'legal-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('TransactionCommit', 'legal-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('BaunitSearch', 'legal-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('CancelService', 'legal-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('historicOrder', 'legal-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('ReportGenerate', 'legal-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('SourcePrint', 'legal-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('SourceSave', 'legal-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('SourceSearch', 'legal-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('StartService', 'legal-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('titleSearch', 'legal-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('varyRight', 'legal-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('PartySave', 'legal-id');

--Bundle Specific to Legal
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('courtProcess', 'legal-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('lodgeObjection', 'legal-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('dispute', 'legal-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('serviceEnquiry', 'legal-id');
insert into system.approle_appgroup(approle_code, appgroup_id) values('DisputeSave', 'legal-id');
insert into system.approle_appgroup(approle_code, appgroup_id) values('DisputeCommentsSave', 'legal-id');
insert into system.approle_appgroup(approle_code, appgroup_id) values('DisputeSearch', 'legal-id');
insert into system.approle_appgroup(approle_code, appgroup_id) values('DisputePartySave', 'legal-id');


--Survery and Mapping
Delete From system.approle_appgroup
where appgroup_id = 'surveymapp-id';

INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('ApplnAssignSelf', 'surveymapp-id');  
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('ApplnStatus', 'surveymapp-id'); 
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('DashbrdViewAssign', 'surveymapp-id');
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('DashbrdViewOwn', 'surveymapp-id');  
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('DashbrdViewUnassign','surveymapp-id');
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('ApplnUnassignSelf', 'surveymapp-id'); 
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('ApplnRequisition', 'surveymapp-id');
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('ApplnResubmit','surveymapp-id');
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('ApplnDispatch', 'surveymapp-id');  
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('ApplnView', 'surveymapp-id');  

INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('BaunitParcelSave', 'surveymapp-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('BauunitrrrSave', 'surveymapp-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('BaunitNotatSave', 'surveymapp-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('CompleteService', 'surveymapp-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('BaunitSave', 'surveymapp-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('ParcelSave', 'surveymapp-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('TransactionCommit', 'surveymapp-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('ArchiveApps', 'surveymapp-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('BaunitCertificate', 'surveymapp-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('BaunitSearch', 'surveymapp-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('cancelProperty', 'surveymapp-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('CancelService', 'surveymapp-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('cnclStandardDocument', 'surveymapp-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('historicOrder', 'surveymapp-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('limitedRoadAccess', 'surveymapp-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('newApartment', 'surveymapp-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('newFreehold', 'surveymapp-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('newOwnership', 'surveymapp-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('regnStandardDocument', 'surveymapp-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('removeRight', 'surveymapp-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('ReportGenerate', 'surveymapp-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('RevertService', 'surveymapp-id');

INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('SourcePrint', 'surveymapp-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('SourceSave', 'surveymapp-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('SourceSearch', 'surveymapp-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('StartService', 'surveymapp-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('sysRegnReports', 'surveymapp-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('systematicRegn', 'surveymapp-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('titleSearch', 'surveymapp-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('varyRight', 'surveymapp-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('ViewMap', 'surveymapp-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('PartySave', 'surveymapp-id');

--Bundle Specific to Survey and Mapping
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('cadastrePrint', 'surveymapp-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('BulkApplication', 'surveymapp-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('cadastreChange', 'surveymapp-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('PrintMap', 'surveymapp-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('printAllocMap', 'surveymapp-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('surveyPlanCopy', 'surveymapp-id');
--INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('printSurveyApp', 'surveymapp-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('printSurveyDiag', 'surveymapp-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('provideSpatialData', 'surveymapp-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('mapSale', 'surveymapp-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('serviceEnquiry', 'surveymapp-id');


--Lease
Delete From system.approle_appgroup
where appgroup_id = 'lease-id';

 
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('ApplnAssignSelf', 'lease-id');  
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('ApplnStatus', 'lease-id'); 
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('DashbrdViewAssign', 'lease-id');
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('DashbrdViewOwn', 'lease-id');  
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('DashbrdViewUnassign','lease-id');
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('ApplnUnassignSelf', 'lease-id'); 
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('ApplnRequisition', 'lease-id');
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('ApplnResubmit','lease-id');
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('ApplnDispatch', 'lease-id');  
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('ApplnView', 'lease-id');  

INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('BaunitParcelSave', 'lease-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('BauunitrrrSave', 'lease-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('BaunitNotatSave', 'lease-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('CompleteService', 'lease-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('newDigitalTitle', 'lease-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('BaunitSave', 'lease-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('ParcelSave', 'lease-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('TransactionCommit', 'lease-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('ArchiveApps', 'lease-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('BaunitCertificate', 'lease-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('BaunitSearch', 'lease-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('buildingRestriction', 'lease-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('cancelProperty', 'lease-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('CancelService', 'lease-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('caveat', 'lease-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('cnclPowerOfAttorney', 'lease-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('cnclStandardDocument', 'lease-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('historicOrder', 'lease-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('limitedRoadAccess', 'lease-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('newApartment', 'lease-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('newFreehold', 'lease-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('newOwnership', 'lease-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('regnPowerOfAttorney', 'lease-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('regnStandardDocument', 'lease-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('removeCaveat', 'lease-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('removeRestriction', 'lease-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('removeRight', 'lease-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('ReportGenerate', 'lease-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('RevertService', 'lease-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('serviceEnquiry', 'lease-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('SourcePrint', 'lease-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('SourceSave', 'lease-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('SourceSearch', 'lease-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('StartService', 'lease-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('surveyPlanCopy', 'lease-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('sysRegnReports', 'lease-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('systematicRegn', 'lease-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('titleSearch', 'lease-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('varyCaveat', 'lease-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('varyLease', 'lease-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('varyMortgage', 'lease-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('varyRight', 'lease-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('ViewMap', 'lease-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('PartySave', 'lease-id');

--Bundle Specific to Lease
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('BulkApplication', 'lease-id');
--INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('regSurrenderLease', 'lease-id');
--INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('applyRegTrans', 'lease-id');
--INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('regVarLease', 'lease-id');
--INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('consentApp', 'lease-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('foreignEntHoldTitle', 'lease-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('groundRentCalc', 'lease-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('regSublease', 'lease-id');

--Deeds
Delete From system.approle_appgroup
where appgroup_id in ('deeds-manager-id','deeds-reps-id');

INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('ApplnAssignSelf', 'deeds-reps-id');  
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('ApplnStatus', 'deeds-reps-id'); 
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('DashbrdViewAssign', 'deeds-reps-id');
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('DashbrdViewOwn', 'deeds-reps-id');  
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('DashbrdViewUnassign','deeds-reps-id');
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('ApplnUnassignSelf', 'deeds-reps-id'); 
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('ApplnRequisition', 'deeds-reps-id');
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('ApplnResubmit','deeds-reps-id');
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('ApplnDispatch', 'deeds-reps-id');  
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('ApplnView', 'deeds-reps-id');  

INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('BaunitParcelSave', 'deeds-reps-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('BauunitrrrSave', 'deeds-reps-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('BaunitNotatSave', 'deeds-reps-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('CompleteService', 'deeds-reps-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('newDigitalTitle', 'deeds-reps-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('BaunitSave', 'deeds-reps-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('cadastreChange', 'deeds-reps-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('ParcelSave', 'deeds-reps-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('TransactionCommit', 'deeds-reps-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('ArchiveApps', 'deeds-reps-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('BaunitCertificate', 'deeds-reps-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('BaunitSearch', 'deeds-reps-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('buildingRestriction', 'deeds-reps-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('cadastrePrint', 'deeds-reps-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('cancelProperty', 'deeds-reps-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('CancelService', 'deeds-reps-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('caveat', 'deeds-reps-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('cnclPowerOfAttorney', 'deeds-reps-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('cnclStandardDocument', 'deeds-reps-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('historicOrder', 'deeds-reps-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('limitedRoadAccess', 'deeds-reps-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('newApartment', 'deeds-reps-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('newFreehold', 'deeds-reps-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('newOwnership', 'deeds-reps-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('PrintMap', 'deeds-reps-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('redefineCadastre', 'deeds-reps-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('regnPowerOfAttorney', 'deeds-reps-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('regnStandardDocument', 'deeds-reps-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('removeCaveat', 'deeds-reps-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('removeRestriction', 'deeds-reps-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('removeRight', 'deeds-reps-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('ReportGenerate', 'deeds-reps-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('RevertService', 'deeds-reps-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('serviceEnquiry', 'deeds-reps-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('SourcePrint', 'deeds-reps-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('SourceSave', 'deeds-reps-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('SourceSearch', 'deeds-reps-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('StartService', 'deeds-reps-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('surveyPlanCopy', 'deeds-reps-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('sysRegnReports', 'deeds-reps-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('systematicRegn', 'deeds-reps-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('titleSearch', 'deeds-reps-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('varyCaveat', 'deeds-reps-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('varyLease', 'deeds-reps-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('varyMortgage', 'deeds-reps-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('varyRight', 'deeds-reps-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('ViewMap', 'deeds-reps-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('PartySave', 'deeds-reps-id');

--Bundle Specific to Deeds
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('BulkApplication', 'deeds-reps-id');
--INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('regSurrenderLease', 'deeds-reps-id');
--INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('regVarLease', 'deeds-reps-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('cancelMortBonds', 'deeds-reps-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('copyLostDeed', 'deeds-reps-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('documentSearch', 'deeds-reps-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('regDeedTransfer', 'deeds-reps-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('RegMiningLease', 'deeds-reps-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('mortgage', 'deeds-reps-id');
--INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('regNotDeedSer', 'deeds-reps-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('regNotGenBond', 'deeds-reps-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('regRedMortBond', 'deeds-reps-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('servitude', 'deeds-reps-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('regSpecNotBond', 'deeds-reps-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('regSublease', 'deeds-reps-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('regnOnTitle', 'deeds-reps-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('regnDeeds', 'deeds-reps-id');
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) VALUES('regNotarSuretyBond', 'deeds-reps-id');

-- Insert similar roles for Deeds management
INSERT INTO system.approle_appgroup(approle_code, appgroup_id) 
  (SELECT system.approle_appgroup.approle_code,'deeds-manager-id' 
	FROM system.approle_appgroup
	WHERE system.approle_appgroup.appgroup_id = 'deeds-reps-id');


--Customer Service
Delete From system.approle_appgroup
where appgroup_id in ('cust-manager-id','cust-reps-id');

--Setting for Customer Services Managers
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) Values('ApplnEdit', 'cust-manager-id');  
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('TransactionCommit', 'cust-manager-id');   
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('ApplnArchive', 'cust-manager-id');  
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('ArchiveApps', 'cust-manager-id');    
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('ApplnAssignSelf', 'cust-manager-id');  
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('CancelService', 'cust-manager-id');  
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('CompleteService', 'cust-manager-id');  
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('ApplnDispatch', 'cust-manager-id');    
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('ApplnStatus', 'cust-manager-id');  
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('ApplnCreate', 'cust-manager-id');  
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('PrintMap', 'cust-manager-id');  
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('SourcePrint', 'cust-manager-id');  
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('ApplnRequisition', 'cust-manager-id');
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('ApplnResubmit', 'cust-manager-id');
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('ApplnView', 'cust-manager-id');
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('SourceSearch', 'cust-manager-id');
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('ApplnValidate', 'cust-manager-id');
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('DashbrdViewAssign', 'cust-manager-id');
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('ViewMap', 'cust-manager-id');
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('DashbrdViewOwn', 'cust-manager-id');
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('DashbrdViewUnassign', 'cust-manager-id');
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('StartService', 'cust-manager-id');
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('PartySave', 'cust-manager-id');
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('ApplnUnassignSelf', 'cust-manager-id');  
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('BaunitCertificate', 'cust-manager-id');  
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('BaunitNotatSave', 'cust-manager-id');   
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('BaunitParcelSave', 'cust-manager-id');   
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('BaunitSave', 'cust-manager-id');   
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('BaunitSearch', 'cust-manager-id');   
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('BauunitrrrSave', 'cust-manager-id');   
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('RevertService', 'cust-manager-id');    
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('SourceSave', 'cust-manager-id');  
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('ParcelSave', 'cust-manager-id'); 
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('ApplnApprove', 'cust-manager-id');

--Setting for Customer Services Representatives
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) Values('ApplnEdit', 'cust-reps-id');  
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('TransactionCommit', 'cust-reps-id');   
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('ApplnArchive', 'cust-reps-id');  
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('ArchiveApps', 'cust-reps-id');    
--INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('ApplnAssignSelf', 'cust-reps-id');  
--INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('CancelService', 'cust-reps-id');  
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('CompleteService', 'cust-reps-id');  
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('ApplnDispatch', 'cust-reps-id');    
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('ApplnStatus', 'cust-reps-id');  
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('ApplnCreate', 'cust-reps-id');  
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('PrintMap', 'cust-reps-id');  
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('SourcePrint', 'cust-reps-id');  
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('ApplnRequisition', 'cust-reps-id');
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('ApplnResubmit', 'cust-reps-id');
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('ApplnView', 'cust-reps-id');
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('SourceSearch', 'cust-reps-id');
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('ApplnValidate', 'cust-reps-id');
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('DashbrdViewAssign', 'cust-reps-id');
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('ViewMap', 'cust-reps-id');
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('DashbrdViewOwn', 'cust-reps-id');
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('DashbrdViewUnassign', 'cust-reps-id');
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('StartService', 'cust-reps-id');
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('PartySave', 'cust-reps-id');
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('ApplnUnassignSelf', 'cust-reps-id');  
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('BaunitCertificate', 'cust-reps-id');  
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('BaunitNotatSave', 'cust-reps-id');   
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('BaunitParcelSave', 'cust-reps-id');   
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('BaunitSave', 'cust-reps-id');   
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('BaunitSearch', 'cust-reps-id');   
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('BauunitrrrSave', 'cust-reps-id');   
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('RevertService', 'cust-reps-id');    
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('SourceSave', 'cust-reps-id');  
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('ParcelSave', 'cust-reps-id'); 
INSERT INTO system.approle_appgroup (approle_code, appgroup_id) VALUES('ApplnApprove', 'cust-reps-id');

--legal



--IT
Delete From system.approle_appgroup
where appgroup_id = 'administrator-id';

insert into system.approle_appgroup(approle_code, appgroup_id) values('DashbrdViewAssign', 'administrator-id');
insert into system.approle_appgroup(approle_code, appgroup_id) values('DashbrdViewUnassign', 'administrator-id');
insert into system.approle_appgroup(approle_code, appgroup_id) values('DashbrdViewOwn', 'administrator-id');
insert into system.approle_appgroup(approle_code, appgroup_id) values('ApplnView', 'administrator-id');
insert into system.approle_appgroup(approle_code, appgroup_id) values('ApplnCreate', 'administrator-id');
insert into system.approle_appgroup(approle_code, appgroup_id) values('ApplnStatus', 'administrator-id');
insert into system.approle_appgroup(approle_code, appgroup_id) values('ApplnAssignSelf', 'administrator-id');
insert into system.approle_appgroup(approle_code, appgroup_id) values('ApplnUnassignSelf', 'administrator-id');
insert into system.approle_appgroup(approle_code, appgroup_id) values('ApplnAssignOthers', 'administrator-id');
insert into system.approle_appgroup(approle_code, appgroup_id) values('ApplnUnassignOthers', 'administrator-id');
insert into system.approle_appgroup(approle_code, appgroup_id) values('BulkApplication', 'administrator-id');
insert into system.approle_appgroup(approle_code, appgroup_id) values('systematicRegn', 'administrator-id');
insert into system.approle_appgroup(approle_code, appgroup_id) values('lodgeObjection', 'administrator-id'); 

--system.approle_appgroup
INSERT INTO system.approle_appgroup(approle_code, appgroup_id)
	SELECT r.code, 'administrator-id' FROM system.approle r
	where r.code not in (select approle_code from system.approle_appgroup g where appgroup_id = 'administrator-id');
	

	--system.user_roles
 DROP VIEW IF EXISTS system.user_roles CASCADE;
 CREATE VIEW system.user_roles AS SELECT u.username, rg.approle_code as rolename
   FROM system.appuser u
   JOIN system.appuser_appgroup ug ON (u.id = ug.appuser_id and u.active)
   JOIN system.approle_appgroup rg ON ug.appgroup_id = rg.appgroup_id;
















