INSERT INTO approle (code, display_value, status, description) VALUES ('viewAssignAll', 'Dashboard - View all assigned applications', 'c', 'Allows users to view all assigned applications');
INSERT INTO approle (code, display_value, status, description) VALUES ('viewUnassignAll', 'Dashboard - View all unassigned applications', 'c', 'Allows users to view all unassigned applications');

INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('viewAssignAll', 'manager-id');
INSERT INTO approle_appgroup (approle_code, appgroup_id) VALUES ('viewUnassignAll', 'manager-id');

INSERT INTO system.br(id, technical_type_code, feedback) 
VALUES('check-lease-reg-for-new-lease', 'sql', 'Lease registration service must exist on the application.');

INSERT INTO system.br_definition(br_id, active_from, active_until, body) 
VALUES('check-lease-reg-for-new-lease', now(), 'infinity', 
'SELECT (CASE WHEN (SELECT COUNT(1) FROM application.service WHERE application_id = #{id} AND request_type_code = ''registerLease'') > 0 
THEN (SELECT COUNT(1)>0 FROM application.service WHERE application_id = #{id} AND request_type_code = ''regOnLease'') ELSE ''t'' END) AS vl');

INSERT INTO system.br_validation(br_id, target_code, target_application_moment, severity_code, order_of_execution)
VALUES ('check-lease-reg-for-new-lease', 'application', 'validate', 'critical', 20);
