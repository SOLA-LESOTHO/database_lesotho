--
-- PostgreSQL database dump
--

-- Dumped from database version 9.2.3
-- Dumped by pg_dump version 9.2.3
-- Started on 2013-08-09 10:08:40

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = system, pg_catalog;

DELETE FROM system.appgroup;
DELETE FROM system.approle;
DELETE FROM system.appuser;

SET SESSION AUTHORIZATION DEFAULT;

ALTER TABLE appgroup DISABLE TRIGGER ALL;

INSERT INTO appgroup (id, name, description) VALUES ('dg-id', 'Director General', 'This is Director General.');
INSERT INTO appgroup (id, name, description) VALUES ('administrator-id', 'System Administrators', 'System Administrators can manage users and system settings. They also have read-only access to the SOLA Desktop. ');
INSERT INTO appgroup (id, name, description) VALUES ('lease-id', 'Lease Services', 'This is a group of users who process leases.');
INSERT INTO appgroup (id, name, description) VALUES ('cust-reps-id', 'Customer Services', 'This is a group of Customer Service Representatives.');
INSERT INTO appgroup (id, name, description) VALUES ('surveymapp-id', 'Survey and Mapping', 'This is a group of Survey and Mapping.');
INSERT INTO appgroup (id, name, description) VALUES ('deeds-reps-id', 'Deeds Assistant Registrar', 'This is a group of Deeds Assistant Registrars');
INSERT INTO appgroup (id, name, description) VALUES ('manager-id', 'Managers', 'This group provides additional roles common to managers such as reporting, application assignment and application approval. This group can be combined with the appropriate section group to provide the necessary manager functions for that section.  ');
INSERT INTO appgroup (id, name, description) VALUES ('audit-id', 'Audit', 'This is a group of Auditors.');
INSERT INTO appgroup (id, name, description) VALUES ('legal-id', 'Legal', 'This is a group for Legal Representatives.');
INSERT INTO appgroup (id, name, description) VALUES ('lease-correct-id', 'Lease Correction', 'This group can process the lease correction services to fix invalid details on a lease');


ALTER TABLE appgroup ENABLE TRIGGER ALL;

--
-- TOC entry 4072 (class 0 OID 246925)
-- Dependencies: 317
-- Data for Name: approle; Type: TABLE DATA; Schema: system; Owner: postgres
--

ALTER TABLE approle DISABLE TRIGGER ALL;

INSERT INTO approle (code, display_value, status, description) VALUES ('StartService', 'Service Action - Start', 'c', 'Allows any user to click the Start action. Note that the user must also have the appropraite Service role as well before they can successfully start the service. ');
INSERT INTO approle (code, display_value, status, description) VALUES ('ApplnUnassignOthers', 'Application - Unassign from Others', 'c', 'Allows the user to unassign an application from any user. ');
INSERT INTO approle (code, display_value, status, description) VALUES ('ApplnUnassignSelf', 'Application - Unassign from Self', 'c', 'Allows a user to unassign an application from themselves. ');
INSERT INTO approle (code, display_value, status, description) VALUES ('BaunitCertificate', 'Service - Print Property Certificate', 'x', 'NOT USED BY SOLA LESOTHO.');
INSERT INTO approle (code, display_value, status, description) VALUES ('ApplnValidate', 'Appln Action - Validate', 'c', 'Required to perform the Validate applicaiton action. Allows the user to manually run the validation rules against the application. ');
INSERT INTO approle (code, display_value, status, description) VALUES ('ViewMap', 'Map - View', 'c', 'Allows the user to view the map. ');
INSERT INTO approle (code, display_value, status, description) VALUES ('ApplnCreate', 'Application - Lodge', 'c', 'Allows new application details to be created (lodged). ');
INSERT INTO approle (code, display_value, status, description) VALUES ('DashbrdViewAssign', 'Dashboard - View Assigned', 'c', 'Allows the user to view applications assigned to them in the Dashboard. To hide the Dashboard from the user, remove both this role and the Dashboard - View Unassigned role. ');
INSERT INTO approle (code, display_value, status, description) VALUES ('ApplnEdit', 'Application - Edit & Save', 'c', 'Allows application details to be edited and saved. ');
INSERT INTO approle (code, display_value, status, description) VALUES ('DashbrdViewUnassign', 'Dashboard - View Unassigned', 'c', 'Allows the user to view all unassigned applications in the Dashboard. To hide the Dashboard from the user, remove both this role and the Dashboard - View Assigned role. ');
INSERT INTO approle (code, display_value, status, description) VALUES ('ApplnWithdraw', 'Appln Action - Withdraw', 'c', 'Required to perform the Withdraw applicaiton action. The Withdraw action transitions the application into the Annulled state.  ');
INSERT INTO approle (code, display_value, status, description) VALUES ('ApplnResubmit', 'Appln Action - Resubmit', 'c', 'Required to perform the Resubmit applicaiton action. The Resubmit action transitions the application into the Lodged state if it is currently On Hold. ');
INSERT INTO approle (code, display_value, status, description) VALUES ('AppFormView', 'Appln Form - View', 'c', 'Allows the user to view and open the Application Form templates');
INSERT INTO approle (code, display_value, status, description) VALUES ('PrintMap', 'Map - Print', 'c', 'Allows the user to create printouts from the Map');
INSERT INTO approle (code, display_value, status, description) VALUES ('ChangePassword', 'Admin - Change Password', 'c', 'Allows a user to change their password and edit thier user name. This role should be included in every security group. ');
INSERT INTO approle (code, display_value, status, description) VALUES ('SourceSearch', 'Document - Search & View', 'c', 'Allows users to search for documents.');
INSERT INTO approle (code, display_value, status, description) VALUES ('ExportMap', 'Map - KML Export', 'c', 'Allows the user to export selected features from the map as KML. ');
INSERT INTO approle (code, display_value, status, description) VALUES ('ApplnView', 'Application - Search & View', 'c', 'Allows users to search and view application details.');
INSERT INTO approle (code, display_value, status, description) VALUES ('ApplnStatus', 'Application - Status Report', 'c', 'Allows the user to print a status report for the application.');
INSERT INTO approle (code, display_value, status, description) VALUES ('ParcelSave', 'Parcel - Edit & Save', 'c', 'Allows parcel details to be edited and saved.');
INSERT INTO approle (code, display_value, status, description) VALUES ('SourcePrint', 'Document - Print', 'x', 'NOT USED BY SOLA LESOTHO. ');
INSERT INTO approle (code, display_value, status, description) VALUES ('PartySave', 'Party - Edit & Save', 'c', 'Allows party details to be edited and saved unless the party is a rightholder. ');
INSERT INTO approle (code, display_value, status, description) VALUES ('BaunitSave', 'Property - Edit & Save', 'c', 'Allows property details to be edited and saved.');
INSERT INTO approle (code, display_value, status, description) VALUES ('regOnSublease', 'Service - Registration On Sublease', 'c', 'Registration Service. Allows the Registration On Sublease service to be started. ');
INSERT INTO approle (code, display_value, status, description) VALUES ('ApplnApprove', 'Appln Action - Approval', 'c', 'Required to perform the Approve applicaiton action. The Approve action transitions the application into the Approved state. 
All services on the application must be completed before this action is available. ');
INSERT INTO approle (code, display_value, status, description) VALUES ('ApplnArchive', 'Appln Action - Archive', 'c', 'Required to perform the Archive applicaiton action. The Archive action transitions the application into the Completed state.  ');
INSERT INTO approle (code, display_value, status, description) VALUES ('ApplnDispatch', 'Appln Action - Dispatch', 'c', 'Required to perform the Dispatch application action. Used to indicate that documents have been dispatched to applicant along with any certificates/reports/map prints requested by applicant');
INSERT INTO approle (code, display_value, status, description) VALUES ('ApplnReject', 'Appln Action - Cancel', 'c', 'Required to perform the Cancel applicaiton action. The Cancel action transitions the application into the Annulled state.  ');
INSERT INTO approle (code, display_value, status, description) VALUES ('ReportGenerate', 'Reporting - Management Reports', 'c', 'Allows users to generate and view management reports (e.g. Lodgement Report)');
INSERT INTO approle (code, display_value, status, description) VALUES ('ApplnRequisition', 'Appln Action - Hold', 'c', 'Required to perform the Hold applicaiton action. The Hold action transitions the application into the On Hold state. ');
INSERT INTO approle (code, display_value, status, description) VALUES ('RevertService', 'Service Action - Revert', 'c', 'Allows any completed service to be reverted to a Pending status for further action. ');
INSERT INTO approle (code, display_value, status, description) VALUES ('TransactionCommit', 'Doc Registration - Save', 'c', 'Allows documents for registration such as Power of Attorney and Notarial Bond to be saved on the Document Registration screen. ');
INSERT INTO approle (code, display_value, status, description) VALUES ('cadastreChange', 'Service - Change to Cadastre', 'c', 'Survey Service. Allows the Change to Cadastre service to be started');
INSERT INTO approle (code, display_value, status, description) VALUES ('BaunitSearch', 'Property - Search', 'c', 'Allows users to search for properties. ');
INSERT INTO approle (code, display_value, status, description) VALUES ('ManageBR', 'Admin - Business Rules', 'c', 'Allows system administrators to manage (edit and save) business rules.');
INSERT INTO approle (code, display_value, status, description) VALUES ('ManageRefdata', 'Admin - Reference Data', 'c', 'Allows system administrators to manage (edit and save) reference data details.  Users with this role will be able to login to the SOLA Lesotho Admin application. ');
INSERT INTO approle (code, display_value, status, description) VALUES ('CancelService', 'Service Action - Cancel', 'c', 'Allows any service to be cancelled.');
INSERT INTO approle (code, display_value, status, description) VALUES ('ApplnAssignOthers', 'Application - Assign to Other Users', 'c', 'Allows a user to assign an application to any other user.');
INSERT INTO approle (code, display_value, status, description) VALUES ('ManageSettings', 'Admin - System Settings', 'c', 'Allows system administrators to manage (edit and save) system setting details. Users with this role will be able to login to the SOLA Lesotho Admin application. ');
INSERT INTO approle (code, display_value, status, description) VALUES ('ManageSecurity', 'Admin - Users and Security', 'c', 'Allows system administrators to manage (edit and save) users, groups and roles. Users with this role will be able to login to the SOLA Lesotho Admin application. ');
INSERT INTO approle (code, display_value, status, description) VALUES ('ApplnAssignSelf', 'Application - Assign to Self', 'c', 'Allows a user to assign an application to themselves.');
INSERT INTO approle (code, display_value, status, description) VALUES ('CompleteService', 'Service Action - Complete', 'c', 'Allows any service to be completed');
INSERT INTO approle (code, display_value, status, description) VALUES ('SourceSave', 'Document - Save', 'c', 'Allows document details to be edited and saved');
INSERT INTO approle (code, display_value, status, description) VALUES ('RightsExport', 'Finance Export', 'c', 'Allows user to export lease financial details to CSV format. ');
INSERT INTO approle (code, display_value, status, description) VALUES ('registerLease', 'Service - Grant of New Lease', 'c', 'Lease Service. Allows the Grant of New Lease service to be started. ');
INSERT INTO approle (code, display_value, status, description) VALUES ('cancelProperty', 'Service - Surrender of a lease', 'c', 'Lease Service. Allows the Surrender of a lease to be started. ');
INSERT INTO approle (code, display_value, status, description) VALUES ('systematicRegn', 'Systematic Registration', 'x', 'NOT USED BY SOLA LESOTHO');
INSERT INTO approle (code, display_value, status, description) VALUES ('sysRegnReports', 'Systematic Registration - Reports', 'x', 'NOT USED BY SOLA LESOTHO');
INSERT INTO approle (code, display_value, status, description) VALUES ('manageLease', 'Lease - Edit General Details', 'c', 'Allows users to prepare and edit all lease details except for the lease registration details.  ');
INSERT INTO approle (code, display_value, status, description) VALUES ('cadastrePrint', 'Service - Print Location Map', 'c', 'Supporting Service. Allows the Print Location Map service to be started. ');
INSERT INTO approle (code, display_value, status, description) VALUES ('redefineCadastre', 'Service - Redefine Cadastre', 'c', 'Survey Service. Allows the Redefine Cadastre service to be started. ');
INSERT INTO approle (code, display_value, status, description) VALUES ('regLease', 'Lease - Edit Registration Details', 'c', 'Allows users to edit the lease registration details. ');
INSERT INTO approle (code, display_value, status, description) VALUES ('removeRight', 'Service - Termination of a lease', 'c', 'Lease Service. - Allows the Termination of a lease service to be started. ');
INSERT INTO approle (code, display_value, status, description) VALUES ('newOwnership', 'Service - Transfer Lease', 'c', 'Lease Service. Allows the Transfer Lease service to be started. ');
INSERT INTO approle (code, display_value, status, description) VALUES ('mortgage', 'Service - Register Mortgage', 'c', 'Registration Service. Allows the Register Mortgage service to be started. ');
INSERT INTO approle (code, display_value, status, description) VALUES ('servitude', 'Service - Register Servitude', 'c', 'Registration Service. Allows the Register Servitude service to be started. ');
INSERT INTO approle (code, display_value, status, description) VALUES ('regnPowerOfAttorney', 'Service - Registration of Power of Attorney', 'c', 'Registration Service. Allows the Registration of Power of Attorney service to be started. ');
INSERT INTO approle (code, display_value, status, description) VALUES ('BulkApplication', 'Bulk Operations - Login ', 'c', 'Allows the user to login and use the Bulk Operations application. ');
INSERT INTO approle (code, display_value, status, description) VALUES ('RHSave', 'Party - Save Rightholder', 'c', 'Allows parties that are rightholders to be edited and saved. ');
INSERT INTO approle (code, display_value, status, description) VALUES ('PartySearch', 'Party - Search & View', 'c', 'Allows user to search and view party details.');
INSERT INTO approle (code, display_value, status, description) VALUES ('DisputeSave', 'Dispute - Edit & Save', 'c', 'Allows dispute details to be edited and saved.');
INSERT INTO approle (code, display_value, status, description) VALUES ('cnclNotBond', 'Service - Cancel Notarial Bond', 'c', 'Registration Service. Allows the Cancel Notarial Bond service to be started');
INSERT INTO approle (code, display_value, status, description) VALUES ('cnclPowerOfAttorney', 'Service - Cancel Power of Attorney', 'c', 'Registration Service. Allows the Cancel Power of Attorney service to be started');
INSERT INTO approle (code, display_value, status, description) VALUES ('documentCopy', 'Service - Copy of Lost Deed', 'c', 'Registration Service. Allows the Copy of Lost Deed service to be started.');
INSERT INTO approle (code, display_value, status, description) VALUES ('DisputeCommentsSave', 'Dispute - Save Comments', 'c', 'Allows dispute comments to be edited and saved.');
INSERT INTO approle (code, display_value, status, description) VALUES ('DisputePartySave', 'Dispute - Save Party', 'c', 'Allows the parties associated with a dispute to be edited or saved. ');
INSERT INTO approle (code, display_value, status, description) VALUES ('DisputeSearch', 'Dispute - Search', 'c', 'Allows the user to search for dispute details.');
INSERT INTO approle (code, display_value, status, description) VALUES ('varyLease', 'Service - Vary Lease', 'c', 'Lease Service - Allows the Vary Lease service to be started. ');
INSERT INTO approle (code, display_value, status, description) VALUES ('endorseRight', 'Service - Endorsement', 'c', 'Lease Service. Allows the Endorsement service to be started. ');
INSERT INTO approle (code, display_value, status, description) VALUES ('varySublease', 'Service - Vary Sublease', 'c', 'Lease Service. Allows the Vary Sublease service to be started. ');
INSERT INTO approle (code, display_value, status, description) VALUES ('groundRentExemp', 'Service - Ground Rent Exemption Application', 'c', 'Lease Service. Allows the Ground Rent Exemption Application service to be started. ');
INSERT INTO approle (code, display_value, status, description) VALUES ('mapSale', 'Service - Map Sale', 'c', 'Supporting Service. Allows the Map Sale service to be started.');
INSERT INTO approle (code, display_value, status, description) VALUES ('regSublease', 'Service - New Sub-lease', 'c', 'Lease Service. Allows the New Sub-lease service to be started. ');
INSERT INTO approle (code, display_value, status, description) VALUES ('regNotBond', 'Service - Register Notarial Bond', 'c', 'Registration Service. Allows the Register Notarial Bond service to be started.');
INSERT INTO approle (code, display_value, status, description) VALUES ('regOnLease', 'Service - Registration on Lease', 'c', 'Registration Service - Allows the Registration on Lease service to be started. ');
INSERT INTO approle (code, display_value, status, description) VALUES ('renewLease', 'Service - Renewal of Lease', 'c', 'Lease Serivce. Allows the Renew of Lease service to be started');
INSERT INTO approle (code, display_value, status, description) VALUES ('cancelMortBonds', 'Service - Cancel Mortgage', 'c', 'Registration Service. Allows the Cancel Mortgage service to be started');
INSERT INTO approle (code, display_value, status, description) VALUES ('cnclSublease', 'Service - Cancel Sub-Lease', 'c', 'Registration Service. Allows the Cancel Sublease service to be started');
INSERT INTO approle (code, display_value, status, description) VALUES ('varyMortgage', 'Service - Cession of Mortgage', 'c', 'Registration Service. Allows the Cession of Mortgage service to be started.');
INSERT INTO approle (code, display_value, status, description) VALUES ('nameChange', 'Service - Change of Lessee name(s)', 'c', 'Lease Service. Allows the Change of Lessee name(s) service to be started');
INSERT INTO approle (code, display_value, status, description) VALUES ('consentApplication', 'Serivce - Consent Application', 'c', 'Lease Service. Allows the Consent Application service to be started. ');
INSERT INTO approle (code, display_value, status, description) VALUES ('DisputeView', 'Dispute - View', 'c', 'Allows the user to open the Disputes and Court Cases form');
INSERT INTO approle (code, display_value, status, description) VALUES ('registrarCorrection', 'Serivce - Correct Lease', 'c', 'Lease Service. Allows the Correct Lease service to be started. ');
INSERT INTO approle (code, display_value, status, description) VALUES ('registrarCancel', 'Serivce - Correct Lease (Cancel Right)', 'c', 'Lease Service. Allows the Correct Lease (Cancel Right). ');

ALTER TABLE approle ENABLE TRIGGER ALL;

--
-- TOC entry 4073 (class 0 OID 246935)
-- Dependencies: 318
-- Data for Name: approle_appgroup; Type: TABLE DATA; Schema: system; Owner: postgres
--

ALTER TABLE approle_appgroup DISABLE TRIGGER ALL;

INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('registrarCorrection', 'lease-correct-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('registrarCancel', 'lease-correct-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('BulkApplication', 'administrator-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ManageBR', 'administrator-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ApplnStatus', 'audit-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ApplnView', 'administrator-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ViewMap', 'administrator-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ReportGenerate', 'administrator-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ChangePassword', 'lease-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ApplnAssignSelf', 'lease-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ApplnAssignOthers', 'lease-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ApplnEdit', 'lease-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ApplnCreate', 'lease-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ApplnUnassignSelf', 'lease-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ApplnArchive', 'lease-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ApplnReject', 'lease-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ApplnDispatch', 'lease-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ApplnRequisition', 'lease-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ApplnResubmit', 'lease-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ApplnWithdraw', 'lease-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('AppFormView', 'lease-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('DashbrdViewAssign', 'lease-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('DashbrdViewUnassign', 'lease-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('regSublease', 'lease-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('newOwnership', 'lease-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('varySublease', 'lease-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('RevertService', 'lease-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('CancelService', 'lease-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ChangePassword', 'cust-reps-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ApplnAssignSelf', 'cust-reps-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ApplnAssignOthers', 'cust-reps-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ApplnUnassignSelf', 'cust-reps-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('AppFormView', 'cust-reps-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('DashbrdViewAssign', 'cust-reps-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('DashbrdViewUnassign', 'cust-reps-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ApplnAssignOthers', 'surveymapp-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ApplnStatus', 'surveymapp-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ChangePassword', 'deeds-reps-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ApplnAssignSelf', 'deeds-reps-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ApplnEdit', 'deeds-reps-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ApplnCreate', 'deeds-reps-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ApplnUnassignSelf', 'deeds-reps-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ApplnArchive', 'deeds-reps-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ApplnReject', 'deeds-reps-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ApplnDispatch', 'deeds-reps-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ApplnRequisition', 'deeds-reps-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ApplnResubmit', 'deeds-reps-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ApplnWithdraw', 'deeds-reps-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('AppFormView', 'deeds-reps-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('DashbrdViewAssign', 'deeds-reps-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('DashbrdViewUnassign', 'deeds-reps-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('TransactionCommit', 'deeds-reps-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('regLease', 'deeds-reps-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('PartySearch', 'deeds-reps-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('regNotBond', 'deeds-reps-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('servitude', 'deeds-reps-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('regOnSublease', 'deeds-reps-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('CancelService', 'deeds-reps-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('RevertService', 'deeds-reps-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('DisputeSearch', 'audit-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('RightsExport', 'audit-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ChangePassword', 'dg-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ManageSecurity', 'administrator-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ManageRefdata', 'administrator-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ManageSettings', 'administrator-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('SourceSearch', 'audit-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('PartySearch', 'audit-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ChangePassword', 'surveymapp-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ApplnAssignSelf', 'surveymapp-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ApplnEdit', 'surveymapp-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ApplnCreate', 'surveymapp-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ApplnUnassignSelf', 'surveymapp-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ApplnReject', 'surveymapp-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ApplnDispatch', 'surveymapp-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ApplnRequisition', 'surveymapp-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ApplnResubmit', 'surveymapp-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ApplnWithdraw', 'surveymapp-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('AppFormView', 'surveymapp-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('DashbrdViewAssign', 'surveymapp-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('DashbrdViewUnassign', 'surveymapp-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ApplnArchive', 'surveymapp-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ExportMap', 'surveymapp-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ParcelSave', 'surveymapp-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('RevertService', 'surveymapp-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('CancelService', 'surveymapp-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('AppFormView', 'dg-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('DashbrdViewAssign', 'dg-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('DashbrdViewUnassign', 'dg-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('DisputeSearch', 'dg-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('DisputeView', 'dg-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('RightsExport', 'dg-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('PartySearch', 'dg-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ChangePassword', 'legal-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ApplnView', 'legal-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ApplnStatus', 'legal-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ApplnValidate', 'legal-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ChangePassword', 'manager-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ApplnAssignOthers', 'manager-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ApplnAssignSelf', 'manager-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ApplnApprove', 'manager-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ApplnArchive', 'manager-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ApplnReject', 'manager-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ApplnDispatch', 'manager-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ApplnRequisition', 'manager-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ApplnResubmit', 'manager-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ApplnValidate', 'manager-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ApplnWithdraw', 'manager-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('DashbrdViewAssign', 'manager-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('DashbrdViewUnassign', 'manager-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('SourceSave', 'manager-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('SourceSearch', 'manager-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ReportGenerate', 'manager-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('CancelService', 'manager-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('CompleteService', 'manager-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('RevertService', 'manager-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('StartService', 'manager-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('AppFormView', 'legal-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('PartySearch', 'legal-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ApplnValidate', 'audit-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ApplnAssignOthers', 'dg-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ApplnUnassignOthers', 'dg-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('DashbrdViewUnassign', 'administrator-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('AppFormView', 'administrator-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('DisputeView', 'administrator-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('SourceSearch', 'administrator-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('RightsExport', 'administrator-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('PartySearch', 'administrator-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('BaunitSearch', 'administrator-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ChangePassword', 'administrator-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('PartySave', 'lease-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('DashbrdViewAssign', 'audit-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('DashbrdViewUnassign', 'audit-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('SourceSave', 'cust-reps-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ChangePassword', 'audit-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('BaunitSearch', 'audit-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('DisputeView', 'audit-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ViewMap', 'audit-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('AppFormView', 'audit-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ApplnView', 'audit-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('DisputeView', 'legal-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('DisputeSave', 'legal-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('DisputeCommentsSave', 'legal-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('DisputeSearch', 'legal-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('DisputePartySave', 'legal-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('SourceSearch', 'legal-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('SourceSave', 'legal-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ViewMap', 'legal-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('BaunitSearch', 'legal-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ApplnView', 'surveymapp-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ApplnValidate', 'surveymapp-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('StartService', 'surveymapp-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('CompleteService', 'surveymapp-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('SourceSearch', 'surveymapp-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('SourceSave', 'surveymapp-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ViewMap', 'surveymapp-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('BaunitSearch', 'surveymapp-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('cadastrePrint', 'surveymapp-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('cadastreChange', 'surveymapp-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('PrintMap', 'surveymapp-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('mapSale', 'surveymapp-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('redefineCadastre', 'surveymapp-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ApplnView', 'lease-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ApplnValidate', 'lease-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('StartService', 'lease-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('CompleteService', 'lease-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('BaunitSave', 'lease-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('BaunitSearch', 'lease-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('removeRight', 'lease-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('SourceSave', 'lease-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('SourceSearch', 'lease-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ViewMap', 'lease-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('registerLease', 'lease-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('endorseRight', 'lease-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('nameChange', 'lease-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('varyLease', 'lease-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('renewLease', 'lease-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('cancelProperty', 'lease-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('manageLease', 'lease-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('consentApplication', 'lease-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('groundRentExemp', 'lease-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ApplnStatus', 'deeds-reps-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ApplnView', 'deeds-reps-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ApplnValidate', 'deeds-reps-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('StartService', 'deeds-reps-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('CompleteService', 'deeds-reps-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('SourceSearch', 'deeds-reps-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('SourceSave', 'deeds-reps-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ViewMap', 'deeds-reps-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('PartySave', 'deeds-reps-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('BaunitSave', 'deeds-reps-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('BaunitSearch', 'deeds-reps-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('regOnLease', 'deeds-reps-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('cnclNotBond', 'deeds-reps-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('cancelMortBonds', 'deeds-reps-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('cnclPowerOfAttorney', 'deeds-reps-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('cnclSublease', 'deeds-reps-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('documentCopy', 'deeds-reps-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('mortgage', 'deeds-reps-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('newOwnership', 'deeds-reps-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('regnPowerOfAttorney', 'deeds-reps-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('varyMortgage', 'deeds-reps-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('varySublease', 'deeds-reps-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ApplnView', 'cust-reps-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ApplnEdit', 'cust-reps-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ApplnCreate', 'cust-reps-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('SourceSearch', 'cust-reps-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ViewMap', 'cust-reps-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('BaunitSearch', 'cust-reps-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ReportGenerate', 'audit-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ApplnStatus', 'dg-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ApplnView', 'dg-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ApplnValidate', 'dg-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ReportGenerate', 'dg-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('SourceSearch', 'dg-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('ViewMap', 'dg-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('BaunitSearch', 'dg-id');


ALTER TABLE approle_appgroup ENABLE TRIGGER ALL;

--
-- TOC entry 4074 (class 0 OID 246940)
-- Dependencies: 319
-- Data for Name: appuser; Type: TABLE DATA; Schema: system; Owner: postgres
--

ALTER TABLE appuser DISABLE TRIGGER ALL;

INSERT INTO appuser (id, username, first_name, last_name, passwd, active, description, rowidentifier, rowversion, change_action, change_user, change_time) VALUES ('andrew', 'andrew', 'Andrew', 'McDowell', 'aacce929e862c92a2af7ee8cc24f9e555e2070b7b21c9e7d699e97c5426e14e0', true, 'FAO SOLA Team member', '4bfa0a14-ff76-11e2-839e-2be4294d5335', 4, 'u', 'andrew', '2013-08-09 19:45:05.488');
INSERT INTO appuser (id, username, first_name, last_name, passwd, active, description, rowidentifier, rowversion, change_action, change_user, change_time) VALUES ('alex', 'alex', 'Alexander', 'Solovov', '7e19e31ae82d749034fc921f777f717ba5b57c6add9add889eb536ac6effcde0', true, 'FAO SOLA Team member', '8da7a336-1e0e-4fd3-9143-3150b375f768', 2, 'u', 'andrew', '2013-08-09 19:48:54.996');
INSERT INTO appuser (id, username, first_name, last_name, passwd, active, description, rowidentifier, rowversion, change_action, change_user, change_time) VALUES ('mmolato-id', 'mmolato', 'Mangaka', 'Molato', '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08', true, NULL, 'e4ad32aa-ff75-11e2-a141-9ffde821c97b', 1, 'i', 'db:postgres', '2013-08-08 03:27:38.688');
INSERT INTO appuser (id, username, first_name, last_name, passwd, active, description, rowidentifier, rowversion, change_action, change_user, change_time) VALUES ('mmolupe-id', 'mmolupe', 'Mpho', 'Molupe', '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08', true, NULL, 'e4ad80ca-ff75-11e2-b518-630452660461', 1, 'i', 'db:postgres', '2013-08-08 03:27:38.688');
INSERT INTO appuser (id, username, first_name, last_name, passwd, active, description, rowidentifier, rowversion, change_action, change_user, change_time) VALUES ('mrammoko-id', 'mrammoko', 'Malefetsane', 'Rammoko', '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08', true, NULL, 'e4adceea-ff75-11e2-8e5a-47c38659fd7e', 1, 'i', 'db:postgres', '2013-08-08 03:27:38.688');
INSERT INTO appuser (id, username, first_name, last_name, passwd, active, description, rowidentifier, rowversion, change_action, change_user, change_time) VALUES ('mmoleli-id', 'mmoleli', 'Mochoni', 'Moleli', '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08', true, NULL, 'e4ae4424-ff75-11e2-8451-c3c209d3079a', 1, 'i', 'db:postgres', '2013-08-08 03:27:38.688');
INSERT INTO appuser (id, username, first_name, last_name, passwd, active, description, rowidentifier, rowversion, change_action, change_user, change_time) VALUES ('smatela-id', 'smatela', 'Maloi', 'Matela', '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08', true, NULL, 'e4ae9244-ff75-11e2-8991-871ba0dcc214', 1, 'i', 'db:postgres', '2013-08-08 03:27:38.688');
INSERT INTO appuser (id, username, first_name, last_name, passwd, active, description, rowidentifier, rowversion, change_action, change_user, change_time) VALUES ('mramakau-id', 'mramakau', 'Moeketsi', 'Ramakau', '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08', true, NULL, 'e4aee064-ff75-11e2-9b1b-afe2759536fb', 1, 'i', 'db:postgres', '2013-08-08 03:27:38.688');
INSERT INTO appuser (id, username, first_name, last_name, passwd, active, description, rowidentifier, rowversion, change_action, change_user, change_time) VALUES ('nmokhethi-id', 'nmokhethi', 'Ntho', 'Mekhethi', '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08', true, NULL, 'e4af2e84-ff75-11e2-b7d5-3fb9111da5ed', 1, 'i', 'db:postgres', '2013-08-08 03:27:38.688');
INSERT INTO appuser (id, username, first_name, last_name, passwd, active, description, rowidentifier, rowversion, change_action, change_user, change_time) VALUES ('lnovember-id', 'lnovember', 'Lehlohonolo', 'November', '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08', true, NULL, 'e4af7ca4-ff75-11e2-bd56-d75ba9c85564', 1, 'i', 'db:postgres', '2013-08-08 03:27:38.688');
INSERT INTO appuser (id, username, first_name, last_name, passwd, active, description, rowidentifier, rowversion, change_action, change_user, change_time) VALUES ('pkoloi-id', 'pkoloi', 'Pitso', 'Koloi', '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08', true, NULL, 'e4afa3b4-ff75-11e2-815e-ff72dda28293', 1, 'i', 'db:postgres', '2013-08-08 03:27:38.688');
INSERT INTO appuser (id, username, first_name, last_name, passwd, active, description, rowidentifier, rowversion, change_action, change_user, change_time) VALUES ('mboiketlo-id', 'mboiketlo', 'Boiketlo', 'Moloi', '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08', true, NULL, 'e4aff1d4-ff75-11e2-809c-f760f093afd4', 1, 'i', 'db:postgres', '2013-08-08 03:27:38.688');
INSERT INTO appuser (id, username, first_name, last_name, passwd, active, description, rowidentifier, rowversion, change_action, change_user, change_time) VALUES ('ksebothoane-id', 'ksebothoane', 'Sebothoane', 'Kabi', '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08', true, NULL, 'e4b03ff4-ff75-11e2-b562-934758b168b1', 1, 'i', 'db:postgres', '2013-08-08 03:27:38.688');
INSERT INTO appuser (id, username, first_name, last_name, passwd, active, description, rowidentifier, rowversion, change_action, change_user, change_time) VALUES ('lmosae-id', 'lmosae', 'Letele', 'Mosae', '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08', true, NULL, 'e4b08e1e-ff75-11e2-966c-4f78d126d0c6', 1, 'i', 'db:postgres', '2013-08-08 03:27:38.688');
INSERT INTO appuser (id, username, first_name, last_name, passwd, active, description, rowidentifier, rowversion, change_action, change_user, change_time) VALUES ('mmojakhomo-id', 'mmojakhomo', 'Motselisi', 'Mojakhomo', '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08', true, NULL, 'e4b0dc3e-ff75-11e2-b9cf-bf20c4bb69a1', 1, 'i', 'db:postgres', '2013-08-08 03:27:38.688');
INSERT INTO appuser (id, username, first_name, last_name, passwd, active, description, rowidentifier, rowversion, change_action, change_user, change_time) VALUES ('tmosaase-id', 'tmosaase', 'Thandi', 'Mosaase', '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08', true, NULL, 'e4b1034e-ff75-11e2-8d4b-dba87c6f4874', 1, 'i', 'db:postgres', '2013-08-08 03:27:38.688');
INSERT INTO appuser (id, username, first_name, last_name, passwd, active, description, rowidentifier, rowversion, change_action, change_user, change_time) VALUES ('lmatlatsa-id', 'lmatlatsa', 'Lebakeng', 'Matlatsa', '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08', true, NULL, 'e4b1516e-ff75-11e2-853d-7b440d4c300c', 1, 'i', 'db:postgres', '2013-08-08 03:27:38.688');
INSERT INTO appuser (id, username, first_name, last_name, passwd, active, description, rowidentifier, rowversion, change_action, change_user, change_time) VALUES ('omokone-id', 'omokone', 'Orpen', 'Mokone', '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08', true, NULL, 'e4b19f8e-ff75-11e2-ab78-4b89f9e5a8b4', 1, 'i', 'db:postgres', '2013-08-08 03:27:38.688');
INSERT INTO appuser (id, username, first_name, last_name, passwd, active, description, rowidentifier, rowversion, change_action, change_user, change_time) VALUES ('mmabela-id', 'mmabela', 'Beatrice', 'Mabela', '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08', true, NULL, 'e4b1c69e-ff75-11e2-9739-73ea3ee2c93b', 1, 'i', 'db:postgres', '2013-08-08 03:27:38.688');
INSERT INTO appuser (id, username, first_name, last_name, passwd, active, description, rowidentifier, rowversion, change_action, change_user, change_time) VALUES ('tmaketela-id', 'tmaketela', 'Thabang', 'Maketela', '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08', true, NULL, 'e4b214be-ff75-11e2-a1d7-232ccae37607', 1, 'i', 'db:postgres', '2013-08-08 03:27:38.688');
INSERT INTO appuser (id, username, first_name, last_name, passwd, active, description, rowidentifier, rowversion, change_action, change_user, change_time) VALUES ('mmoshoeshoe-id', 'mmoshoeshoe', 'Mankoebe', 'Moshoeshoe', '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08', true, NULL, 'e4b262de-ff75-11e2-8626-77e8df7aa898', 1, 'i', 'db:postgres', '2013-08-08 03:27:38.688');
INSERT INTO appuser (id, username, first_name, last_name, passwd, active, description, rowidentifier, rowversion, change_action, change_user, change_time) VALUES ('mletsie-id', 'mletsie', 'Maseni', 'Letsie', '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08', true, NULL, 'e4b289ee-ff75-11e2-a2ff-5f5e7d2667c3', 1, 'i', 'db:postgres', '2013-08-08 03:27:38.688');
INSERT INTO appuser (id, username, first_name, last_name, passwd, active, description, rowidentifier, rowversion, change_action, change_user, change_time) VALUES ('tshale-id', 'tshale', 'Thabiso', 'Shale', '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08', true, NULL, 'e4b2d80e-ff75-11e2-a0b3-9f7417813b27', 1, 'i', 'db:postgres', '2013-08-08 03:27:38.688');
INSERT INTO appuser (id, username, first_name, last_name, passwd, active, description, rowidentifier, rowversion, change_action, change_user, change_time) VALUES ('mramakhula-id', 'mramakhula', 'Mathe', 'Ramakhula', '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08', true, NULL, 'e4b2ff1e-ff75-11e2-b9a6-1381b42616bc', 1, 'i', 'db:postgres', '2013-08-08 03:27:38.688');
INSERT INTO appuser (id, username, first_name, last_name, passwd, active, description, rowidentifier, rowversion, change_action, change_user, change_time) VALUES ('mmohajane-id', 'mmohajane', 'Molelekeng', 'Mohajane', '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08', true, NULL, 'e4b34d48-ff75-11e2-ba49-f3011d78c469', 1, 'i', 'db:postgres', '2013-08-08 03:27:38.688');
INSERT INTO appuser (id, username, first_name, last_name, passwd, active, description, rowidentifier, rowversion, change_action, change_user, change_time) VALUES ('mmphutlane-id', 'mmphutlane', 'Mampolelo', 'Mphutlane', '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08', true, NULL, 'e4b39b68-ff75-11e2-abc7-73b22453e979', 1, 'i', 'db:postgres', '2013-08-08 03:27:38.688');
INSERT INTO appuser (id, username, first_name, last_name, passwd, active, description, rowidentifier, rowversion, change_action, change_user, change_time) VALUES ('ralotsi-id', 'ralotsi', 'Relebohile', 'Alotsi', '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08', true, NULL, 'e4b3e988-ff75-11e2-89bd-578327676377', 1, 'i', 'db:postgres', '2013-08-08 03:27:38.688');
INSERT INTO appuser (id, username, first_name, last_name, passwd, active, description, rowidentifier, rowversion, change_action, change_user, change_time) VALUES ('lshabe-id', 'lshabe', 'Llang', 'Shabe', '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08', true, NULL, 'e4b41098-ff75-11e2-a6f4-13db83ab9456', 1, 'i', 'db:postgres', '2013-08-08 03:27:38.688');
INSERT INTO appuser (id, username, first_name, last_name, passwd, active, description, rowidentifier, rowversion, change_action, change_user, change_time) VALUES ('slerotholi-id', 'slerotholi', 'Seeng', 'Lerotholi', '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08', true, NULL, 'e4b45eb8-ff75-11e2-b184-73bf23b09ed8', 1, 'i', 'db:postgres', '2013-08-08 03:27:38.688');
INSERT INTO appuser (id, username, first_name, last_name, passwd, active, description, rowidentifier, rowversion, change_action, change_user, change_time) VALUES ('mtsabeng-id', 'mtsabeng', 'Malepekola', 'Tsabeng', '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08', true, NULL, 'e4b4acd8-ff75-11e2-b392-0bab5a61238c', 1, 'i', 'db:postgres', '2013-08-08 03:27:38.688');
INSERT INTO appuser (id, username, first_name, last_name, passwd, active, description, rowidentifier, rowversion, change_action, change_user, change_time) VALUES ('ttau-id', 'ttau', 'Thakane', 'Tau', '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08', true, NULL, 'e4b4faf8-ff75-11e2-a39a-a78faf8aa1ec', 1, 'i', 'db:postgres', '2013-08-08 03:27:38.688');
INSERT INTO appuser (id, username, first_name, last_name, passwd, active, description, rowidentifier, rowversion, change_action, change_user, change_time) VALUES ('ilengoasa-id', 'ilengoasa', 'Itumeleng', 'Lengoasa', '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08', true, NULL, 'e4b57028-ff75-11e2-80ae-07be0478f27c', 1, 'i', 'db:postgres', '2013-08-08 03:27:38.688');
INSERT INTO appuser (id, username, first_name, last_name, passwd, active, description, rowidentifier, rowversion, change_action, change_user, change_time) VALUES ('tphoofolo-id', 'phoofe', 'Tlali', 'Phoofolo', '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08', true, NULL, 'e4b59738-ff75-11e2-9953-6b9457ca4e57', 1, 'i', 'db:postgres', '2013-08-08 03:27:38.688');
INSERT INTO appuser (id, username, first_name, last_name, passwd, active, description, rowidentifier, rowversion, change_action, change_user, change_time) VALUES ('lsekonyela-id', 'lsekonyela', 'Lebaka', 'Sekonyela', '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08', true, NULL, 'e4b5e562-ff75-11e2-b5a4-7f5213bd62e2', 1, 'i', 'db:postgres', '2013-08-08 03:27:38.688');
INSERT INTO appuser (id, username, first_name, last_name, passwd, active, description, rowidentifier, rowversion, change_action, change_user, change_time) VALUES ('nmafereka-id', 'nmafereka', 'Ntsane', 'Mafereka', '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08', true, NULL, 'e4b63382-ff75-11e2-83bd-ffc919cbe06c', 1, 'i', 'db:postgres', '2013-08-08 03:27:38.688');
INSERT INTO appuser (id, username, first_name, last_name, passwd, active, description, rowidentifier, rowversion, change_action, change_user, change_time) VALUES ('nputsoa-id', 'nputsoa', 'Ntsebo', 'Putsoa', '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08', true, NULL, 'e4b65a92-ff75-11e2-83f1-7fc5f9887c17', 1, 'i', 'db:postgres', '2013-08-08 03:27:38.688');
INSERT INTO appuser (id, username, first_name, last_name, passwd, active, description, rowidentifier, rowversion, change_action, change_user, change_time) VALUES ('mchaka-id', 'mchaka', 'Mahashe', 'Chaka', '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08', true, NULL, 'e4b6a8b2-ff75-11e2-84cd-4369fa6603b1', 1, 'i', 'db:postgres', '2013-08-08 03:27:38.688');
INSERT INTO appuser (id, username, first_name, last_name, passwd, active, description, rowidentifier, rowversion, change_action, change_user, change_time) VALUES ('knkalai-id', 'knkalai', 'Khopotso', 'Nkalai', '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08', true, NULL, 'e4b52208-ff75-11e2-9b61-3f662cf79ad9', 13, 'u', 'knkalai', '2013-08-09 19:43:44.73');


ALTER TABLE appuser ENABLE TRIGGER ALL;

--
-- TOC entry 4075 (class 0 OID 246967)
-- Dependencies: 321
-- Data for Name: appuser_appgroup; Type: TABLE DATA; Schema: system; Owner: postgres
--

ALTER TABLE appuser_appgroup DISABLE TRIGGER ALL;

INSERT INTO appuser_appgroup (appuser_id, appgroup_id) VALUES ('andrew', 'lease-id');
INSERT INTO appuser_appgroup (appuser_id, appgroup_id) VALUES ('andrew', 'cust-reps-id');
INSERT INTO appuser_appgroup (appuser_id, appgroup_id) VALUES ('andrew', 'administrator-id');
INSERT INTO appuser_appgroup (appuser_id, appgroup_id) VALUES ('andrew', 'deeds-reps-id');
INSERT INTO appuser_appgroup (appuser_id, appgroup_id) VALUES ('andrew', 'surveymapp-id');
INSERT INTO appuser_appgroup (appuser_id, appgroup_id) VALUES ('andrew', 'audit-id');
INSERT INTO appuser_appgroup (appuser_id, appgroup_id) VALUES ('andrew', 'dg-id');
INSERT INTO appuser_appgroup (appuser_id, appgroup_id) VALUES ('andrew', 'legal-id');
INSERT INTO appuser_appgroup (appuser_id, appgroup_id) VALUES ('andrew', 'manager-id');
INSERT INTO appuser_appgroup (appuser_id, appgroup_id) VALUES ('andrew', 'lease-correct-id');
INSERT INTO appuser_appgroup (appuser_id, appgroup_id) VALUES ('knkalai-id', 'administrator-id');
INSERT INTO appuser_appgroup (appuser_id, appgroup_id) VALUES ('alex', 'dg-id');
INSERT INTO appuser_appgroup (appuser_id, appgroup_id) VALUES ('alex', 'administrator-id');
INSERT INTO appuser_appgroup (appuser_id, appgroup_id) VALUES ('alex', 'lease-id');
INSERT INTO appuser_appgroup (appuser_id, appgroup_id) VALUES ('alex', 'cust-reps-id');
INSERT INTO appuser_appgroup (appuser_id, appgroup_id) VALUES ('alex', 'surveymapp-id');
INSERT INTO appuser_appgroup (appuser_id, appgroup_id) VALUES ('alex', 'deeds-reps-id');
INSERT INTO appuser_appgroup (appuser_id, appgroup_id) VALUES ('alex', 'manager-id');
INSERT INTO appuser_appgroup (appuser_id, appgroup_id) VALUES ('alex', 'audit-id');
INSERT INTO appuser_appgroup (appuser_id, appgroup_id) VALUES ('alex', 'legal-id');
INSERT INTO appuser_appgroup (appuser_id, appgroup_id) VALUES ('alex', 'lease-correct-id');
INSERT INTO appuser_appgroup (appuser_id, appgroup_id) VALUES ('smatela-id', 'surveymapp-id');
INSERT INTO appuser_appgroup (appuser_id, appgroup_id) VALUES ('smatela-id', 'manager-id');
INSERT INTO appuser_appgroup (appuser_id, appgroup_id) VALUES ('mrammoko-id', 'manager-id');
INSERT INTO appuser_appgroup (appuser_id, appgroup_id) VALUES ('mrammoko-id', 'surveymapp-id');
INSERT INTO appuser_appgroup (appuser_id, appgroup_id) VALUES ('lmosae-id', 'lease-id');
INSERT INTO appuser_appgroup (appuser_id, appgroup_id) VALUES ('lmosae-id', 'manager-id');
INSERT INTO appuser_appgroup (appuser_id, appgroup_id) VALUES ('mmojakhomo-id', 'lease-id');
INSERT INTO appuser_appgroup (appuser_id, appgroup_id) VALUES ('mmojakhomo-id', 'manager-id');
INSERT INTO appuser_appgroup (appuser_id, appgroup_id) VALUES ('mmoshoeshoe-id', 'deeds-reps-id');
INSERT INTO appuser_appgroup (appuser_id, appgroup_id) VALUES ('mmoshoeshoe-id', 'manager-id');
INSERT INTO appuser_appgroup (appuser_id, appgroup_id) VALUES ('mmojakhomo-id', 'cust-reps-id');
INSERT INTO appuser_appgroup (appuser_id, appgroup_id) VALUES ('nputsoa-id', 'audit-id');
INSERT INTO appuser_appgroup (appuser_id, appgroup_id) VALUES ('mchaka-id', 'dg-id');
INSERT INTO appuser_appgroup (appuser_id, appgroup_id) VALUES ('mmolato-id', 'legal-id');
INSERT INTO appuser_appgroup (appuser_id, appgroup_id) VALUES ('mmolupe-id', 'legal-id');
INSERT INTO appuser_appgroup (appuser_id, appgroup_id) VALUES ('mmoleli-id', 'surveymapp-id');
INSERT INTO appuser_appgroup (appuser_id, appgroup_id) VALUES ('mramakau-id', 'surveymapp-id');
INSERT INTO appuser_appgroup (appuser_id, appgroup_id) VALUES ('nmokhethi-id', 'surveymapp-id');
INSERT INTO appuser_appgroup (appuser_id, appgroup_id) VALUES ('lnovember-id', 'surveymapp-id');
INSERT INTO appuser_appgroup (appuser_id, appgroup_id) VALUES ('pkoloi-id', 'surveymapp-id');
INSERT INTO appuser_appgroup (appuser_id, appgroup_id) VALUES ('mboiketlo-id', 'surveymapp-id');
INSERT INTO appuser_appgroup (appuser_id, appgroup_id) VALUES ('ksebothoane-id', 'surveymapp-id');
INSERT INTO appuser_appgroup (appuser_id, appgroup_id) VALUES ('tmosaase-id', 'lease-id');
INSERT INTO appuser_appgroup (appuser_id, appgroup_id) VALUES ('lmatlatsa-id', 'lease-id');
INSERT INTO appuser_appgroup (appuser_id, appgroup_id) VALUES ('omokone-id', 'lease-id');
INSERT INTO appuser_appgroup (appuser_id, appgroup_id) VALUES ('mmabela-id', 'lease-id');
INSERT INTO appuser_appgroup (appuser_id, appgroup_id) VALUES ('tmaketela-id', 'lease-id');
INSERT INTO appuser_appgroup (appuser_id, appgroup_id) VALUES ('mletsie-id', 'deeds-reps-id');
INSERT INTO appuser_appgroup (appuser_id, appgroup_id) VALUES ('tshale-id', 'deeds-reps-id');
INSERT INTO appuser_appgroup (appuser_id, appgroup_id) VALUES ('mramakhula-id', 'deeds-reps-id');
INSERT INTO appuser_appgroup (appuser_id, appgroup_id) VALUES ('mmohajane-id', 'cust-reps-id');
INSERT INTO appuser_appgroup (appuser_id, appgroup_id) VALUES ('mmphutlane-id', 'cust-reps-id');
INSERT INTO appuser_appgroup (appuser_id, appgroup_id) VALUES ('ralotsi-id', 'cust-reps-id');
INSERT INTO appuser_appgroup (appuser_id, appgroup_id) VALUES ('lshabe-id', 'cust-reps-id');
INSERT INTO appuser_appgroup (appuser_id, appgroup_id) VALUES ('slerotholi-id', 'cust-reps-id');
INSERT INTO appuser_appgroup (appuser_id, appgroup_id) VALUES ('mtsabeng-id', 'cust-reps-id');
INSERT INTO appuser_appgroup (appuser_id, appgroup_id) VALUES ('ttau-id', 'cust-reps-id');
INSERT INTO appuser_appgroup (appuser_id, appgroup_id) VALUES ('ilengoasa-id', 'administrator-id');
INSERT INTO appuser_appgroup (appuser_id, appgroup_id) VALUES ('tphoofolo-id', 'administrator-id');
INSERT INTO appuser_appgroup (appuser_id, appgroup_id) VALUES ('lsekonyela-id', 'administrator-id');
INSERT INTO appuser_appgroup (appuser_id, appgroup_id) VALUES ('nmafereka-id', 'administrator-id');


ALTER TABLE appuser_appgroup ENABLE TRIGGER ALL;

-- Completed on 2013-08-09 10:08:40

--
-- PostgreSQL database dump complete
--

