﻿
----------------------------------------------------------------------------------------------------

insert into system.br(id, technical_type_code, feedback, technical_description) 
values('application-baunit-has-parcels', 'sql', 'Title must have parcel::::Titolo deve avere particelle',
 '#{id}(application.service.id) is requested');

insert into system.br_definition(br_id, active_from, active_until, body) 
values('application-baunit-has-parcels', now(), 'infinity', 
'select count(*)>0 as vl
from application.service s 
	inner join application.application_property ap on s.application_id= ap.application_id
	INNER JOIN (administrative.ba_unit ba 
	INNER JOIN cadastre.cadastre_object co on ba.cadastre_object_id = co.id) 
	ON ap.ba_unit_id = ba.id
where s.id = #{id} and co.status_code = ''current'' and co.geom_polygon is not null
order by 1
limit 1');

INSERT INTO system.br_validation(br_id, target_code, target_service_moment, target_request_type_code, severity_code, order_of_execution)
VALUES ('application-baunit-has-parcels', 'service', 'complete', 'cadastreChange', 'warning', 130);

INSERT INTO system.br_validation(br_id, target_code, target_service_moment, target_request_type_code, severity_code, order_of_execution)
VALUES ('application-baunit-has-parcels', 'service', 'complete', 'redefineCadastre', 'warning', 140);

---------------------------------------------------------------------------------------------------------------------
insert into system.br(id, technical_type_code, feedback) 
values('service-on-complete-without-transaction', 'sql', 'Service ''req_type'' must have been started and some changes made in the system::::Service must have been started and some changes made in the system');

insert into system.br_definition(br_id, active_from, active_until, body) 
values('service-on-complete-without-transaction', now(), 'infinity', 
'select id in (select from_service_id from transaction.transaction where from_service_id is not null) as vl, 
  get_translation(r.display_value, #{lng}) as req_type
from application.service s inner join application.request_type r on s.request_type_code = r.code and request_category_code=''registrationServices''
and s.id= #{id}');

insert into system.br_validation(br_id, severity_code, target_service_moment, target_code, order_of_execution) 
values('service-on-complete-without-transaction', 'critical', 'complete', 'service', 360);
----------------------------------------------------------------------------------------------------
insert into system.br(id, technical_type_code, feedback, technical_description) 
values('service-check-no-previous-digital-title-service', 'sql', 
'For the Convert Title service there must be no existing digital title record (including the recording of a primary (ownership) right) for the identified title::::Un titolo digitale non dovrebbe esistere per la proprieta richiesta (non avere diritti primari significa anche che non esiste)',
 '#{id}(application.service.id) is requested where service is for newDigitalTitle or newDigitalProperty');

insert into system.br_definition(br_id, active_from, active_until, body) 
values('service-check-no-previous-digital-title-service', now(), 'infinity', 
'SELECT coalesce(not rrr.is_primary, true) as vl
FROM application.service s inner join application.application_property ap on s.application_id = ap.application_id
  INNER JOIN administrative.ba_unit ba ON ap.ba_unit_id = ba.id
  LEFT JOIN administrative.rrr ON rrr.ba_unit_id = ba.id
WHERE s.id = #{id} 
order by 1 desc
limit 1');

--insert into system.br_validation(br_id, severity_code, target_service_moment, target_code, target_request_type_code, order_of_execution) 
--values('service-check-no-previous-digital-title-service', 'warning', 'complete', 'service', 'newDigitalTitle', 720);

----------------------------------------------------------------------------------------------------
INSERT INTO system.br(id, technical_type_code, feedback, technical_description) 
VALUES('baunit-has-multiple-mortgages', 'sql', 'For the Register Mortgage service the identified title has no existing mortgages::::Il titolo ha una ipoteca corrente',
 '#{id}(administrative.ba_unit.id) is requested');
--delete from system.br_definition where br_id = 'baunit-has-multiple-mortgages'
INSERT INTO system.br_definition(br_id, active_from, active_until, body) 
VALUES('baunit-has-multiple-mortgages', now(), 'infinity', 
'SELECT	(SELECT (COUNT(*) = 0) FROM application.service sv2
		 INNER JOIN transaction.transaction tn ON (sv2.id = tn.from_service_id)
		 INNER JOIN administrative.rrr rr ON (tn.id = rr.transaction_id)
		 INNER JOIN administrative.rrr rr2 ON ((rr.ba_unit_id = rr2.ba_unit_id) AND (rr2.type_code = ''mortgage'') AND (rr2.status_code =''current'') ) 
	WHERE sv.id = #{id}) AS vl FROM application.service sv
WHERE sv.id = #{id}
AND sv.request_type_code = ''mortgage''
ORDER BY 1
LIMIT 1');

INSERT INTO system.br_validation(br_id, target_code, target_service_moment, target_request_type_code, severity_code, order_of_execution)
VALUES ('baunit-has-multiple-mortgages', 'service', 'complete', 'mortgage', 'warning', 670);

----------------------------------------------------------------------------------------------------
INSERT INTO system.br(id, technical_type_code, feedback, technical_description) 
VALUES('current-rrr-for-variation-or-cancellation-check', 'sql', 'For cancellation or variation of rights (or restrictions), there must be existing rights or restriction (in addition to the primary (ownership) right)::::Il titolo non include diritti o restrizioni correnti (oltre al diritto primario). Confermare la richiesta di variazione o cancellazione e verificare il titolo identificativo',
 '#{id}(application.service.id)');


INSERT INTO system.br_definition(br_id, active_from, active_until, body) 
VALUES('current-rrr-for-variation-or-cancellation-check', now(), 'infinity', 
'SELECT (SUM(1) > 0) AS vl FROM application.service sv 
			INNER JOIN application.application_property ap ON (sv.application_id = ap.application_id )
			  INNER JOIN administrative.ba_unit ba ON ap.ba_unit_id = ba.id
			  INNER JOIN administrative.rrr rr ON rr.ba_unit_id = ba.id
			  WHERE sv.id = #{id}
			  AND sv.request_type_code IN (SELECT code FROM application.request_type WHERE ((status = ''c'') AND (type_action_code IN (''vary'', ''cancel''))))
			  AND NOT(rr.is_primary)
			  AND rr.status_code = ''current''
LIMIT 1');

INSERT INTO system.br_validation(br_id, severity_code, target_service_moment, target_code, order_of_execution) 
VALUES('current-rrr-for-variation-or-cancellation-check', 'medium', 'complete', 'service', 11);

INSERT INTO system.br_validation(br_id, target_code, target_service_moment, severity_code, order_of_execution)
VALUES ('current-rrr-for-variation-or-cancellation-check', 'service', 'complete', 'medium', 650);

----------------------------------------------------------------------------------------------------

INSERT INTO system.br(id, technical_type_code, feedback, technical_description) 
VALUES('power-of-attorney-service-has-document', 'sql', 'Service ''req_type'' must have must have one associated Power of Attorney document::::''req_type'' del Servizio deve avere un documento di procura legale allegato',
  '#{id}(application.service.id)');
 
INSERT INTO system.br_definition(br_id, active_from, active_until, body) 
VALUES('power-of-attorney-service-has-document', now(), 'infinity', 
'SELECT (SUM(1) = 1) AS vl, get_translation(rt.display_value, #{lng}) as req_type FROM application.service sv
	 INNER JOIN transaction.transaction tn ON (sv.id = tn.from_service_id)
	 INNER JOIN source.source sc ON (tn.id = sc.transaction_id)
	 INNER JOIN application.request_type rt ON (sv.request_type_code = rt.code AND request_category_code = ''registrationServices'')
WHERE sv.id =#{id}
AND sc.type_code = ''powerOfAttorney''
GROUP BY rt.code
ORDER BY 1
LIMIT 1');

INSERT INTO system.br_validation(br_id, severity_code, target_service_moment, target_code, target_request_type_code, order_of_execution) 
VALUES('power-of-attorney-service-has-document', 'critical', 'complete', 'service', 'regnPowerOfAttorney', 340);

--------------------------------------------------------------------------------------------------
INSERT INTO system.br(id, technical_type_code, feedback, technical_description) 
	VALUES('document-supporting-rrr-is-current', 'sql', 'Documents supporting rights (or restrictions) must have current status::::I documenti che supportano diritti (o restrizioni) devono avere stato corrente',
		'#{id}(application.service.id)');
INSERT INTO system.br_definition(br_id, active_from, active_until, body) 
	VALUES('document-supporting-rrr-is-current', now(), 'infinity', 
	'WITH serviceDocs AS	(SELECT DISTINCT ON (sc.id) sv.id AS sv_id, sc.id AS sc_id, sc.status_code, sc.type_code FROM application.service sv
				INNER JOIN transaction.transaction tn ON (sv.id = tn.from_service_id)
				INNER JOIN administrative.rrr rr ON (tn.id = rr.transaction_id)
				INNER JOIN administrative.source_describes_rrr sr ON (rr.id = sr.rrr_id)
				INNER JOIN source.source sc ON (sr.source_id = sc.id)
				WHERE sv.id = #{id}),
    nullDocs AS		(SELECT sc_id, type_code FROM serviceDocs WHERE status_code IS NULL),
    transDocs AS	(SELECT sc_id, type_code FROM serviceDocs WHERE status_code = ''current'' AND ((type_code = ''powerOfAttorney'') OR (type_code = ''standardDocument'')))
SELECT ((SELECT COUNT(*) FROM serviceDocs) - (SELECT COUNT(*) FROM nullDocs) - (SELECT COUNT(*) FROM transDocs) = 0) AS vl
ORDER BY 1
LIMIT 1');

INSERT INTO system.br_validation(br_id, severity_code, target_service_moment, target_code, order_of_execution) 
VALUES('document-supporting-rrr-is-current', 'critical', 'complete', 'service',  240);
----------------------------------------------------------------------------------------------------

INSERT INTO system.br(id, technical_type_code, feedback, technical_description) 
VALUES('documents-present', 'sql', 'Documents associated with a service must have a scanned image file (or other source file) attached::::Vi sono documenti allegati',
 '#{id}(service_id) is requested');

INSERT INTO system.br_definition(br_id, active_from, active_until, body) 
VALUES('documents-present', now(), 'infinity', 
 'WITH cadastreDocs AS 	(SELECT DISTINCT ON (id) ss.id, ext_archive_id FROM source.source ss
				INNER JOIN transaction.transaction_source ts ON (ss.id = ts.source_id)
				INNER JOIN transaction.transaction tn ON(ts.transaction_id = tn.id)
				WHERE tn.from_service_id = #{id}
				ORDER BY 1),
	rrrDocs AS	(SELECT DISTINCT ON (id) ss.id, ext_archive_id FROM source.source ss
				INNER JOIN administrative.source_describes_rrr sr ON (ss.id = sr.source_id)
				INNER JOIN administrative.rrr rr ON (sr.rrr_id = rr.id)
				INNER JOIN transaction.transaction tn ON(rr.transaction_id = tn.id)
				WHERE tn.from_service_id = #{id}
				ORDER BY 1),
     titleDocs AS	(SELECT DISTINCT ON (id) ss.id, ext_archive_id FROM source.source ss
				INNER JOIN administrative.source_describes_ba_unit su ON (ss.id = su.source_id)
				WHERE su.ba_unit_id IN (SELECT  ba_unit_id FROM rrrDocs)
				ORDER BY 1),
     regDocs AS		(SELECT DISTINCT ON (id) ss.id, ext_archive_id FROM source.source ss
				INNER JOIN transaction.transaction tn ON (ss.transaction_id = tn.id)
				INNER JOIN application.service sv ON (tn.from_service_id = sv.id)
				WHERE sv.id = #{id}
				AND sv.request_type_code IN (''regnPowerOfAttorney'', ''regnStandardDocument'', ''cnclPowerOfAttorney'', ''cnclStandardDocument'')
				ORDER BY 1),
     serviceDocs AS	((SELECT * FROM rrrDocs) UNION (SELECT * FROM cadastreDocs) UNION (SELECT * FROM titleDocs) UNION (SELECT * FROM regDocs))
     
     
 SELECT (((SELECT COUNT(*) FROM serviceDocs) - (SELECT COUNT(*) FROM serviceDocs WHERE ext_archive_id IS NOT NULL)) = 0) AS vl');

INSERT INTO system.br_validation(br_id, severity_code, target_service_moment, target_code, order_of_execution) 
VALUES('documents-present', 'warning', 'complete', 'service', 200);
--------------------------------------------------------------------------------------------------

INSERT INTO system.br(id, technical_type_code, feedback, technical_description) 
VALUES('power-of-attorney-owner-check', 'sql', 'Name of person identified in Power of Attorney should match a (one of the) current owner(s)::::Il nome della persona identificato nella procura legale deve corrispondere ad uno dei proprietari correnti',
  '#{id}(application.service.id)');
--delete from system.br_definition where br_id =  'power-of-attorney-owner-check'
INSERT INTO system.br_definition(br_id, active_from, active_until, body) 
VALUES('power-of-attorney-owner-check', NOW(), 'infinity', 
'WITH poaQuery AS (SELECT person_name, py.name AS firstName, py.last_name AS lastName FROM transaction.transaction tn
			INNER JOIN administrative.rrr rr ON (tn.id = rr.transaction_id) 
			INNER JOIN administrative.ba_unit ba ON (rr.ba_unit_id = ba.id)
			INNER JOIN administrative.rrr r2 ON ((ba.id = r2.ba_unit_id) AND (r2.status_code = ''current'') AND r2.is_primary)
			INNER JOIN administrative.rrr_share rs ON (r2.id = rs.rrr_id)
			INNER JOIN administrative.party_for_rrr pr ON (rs.rrr_id = pr.rrr_id)
			INNER JOIN party.party py ON (pr.party_id = py.id)
			INNER JOIN administrative.source_describes_rrr sr ON (rr.id = sr.rrr_id)
			INNER JOIN source.power_of_attorney pa ON (sr.source_id = pa.id)
		WHERE tn.from_service_id = #{id})
SELECT CASE WHEN (COUNT(*) > 0) THEN TRUE
		ELSE NULL
	END AS vl FROM poaQuery
WHERE compare_strings(person_name, COALESCE(firstName, '''') || '' '' || COALESCE(lastName, ''''))
ORDER BY vl
LIMIT 1');

INSERT INTO system.br_validation(br_id, severity_code, target_service_moment, target_code, order_of_execution) 
VALUES('power-of-attorney-owner-check', 'warning', 'complete', 'service', 580);

----------------------------------------------------------------------------------------------------

INSERT INTO system.br(id, technical_type_code, feedback, technical_description) 
VALUES('required-sources-are-present', 'sql', 
'All documents required for the service ''req_type'' are present.::::Sono presenti tutti i documenti richiesti per il servizio',
'Checks that all required documents for any of the services in an application are recorded. Null value is returned if there are no required documents' );

INSERT INTO system.br_definition(br_id, active_from, active_until, body) 
VALUES('required-sources-are-present', now(), 'infinity', 
'WITH reqForSv AS 	(SELECT r_s.source_type_code AS typeCode
			FROM application.request_type_requires_source_type r_s 
				INNER JOIN application.service sv ON((r_s.request_type_code = sv.request_type_code) AND (sv.status_code != ''cancelled''))
			WHERE sv.id = #{id}),
     inclInSv AS	(SELECT DISTINCT ON (sc.id) get_translation(rt.display_value, #{lng}) AS req_type FROM reqForSv req
				INNER JOIN source.source sc ON (req.typeCode = sc.type_code)
				INNER JOIN application.application_uses_source a_s ON (sc.id = a_s.source_id)
				INNER JOIN application.service sv ON ((a_s.application_id = sv.application_id) AND (sv.id = #{id}))
				INNER JOIN application.request_type rt ON (sv.request_type_code = rt.code))

SELECT 	CASE 	WHEN (SELECT (SUM(1) IS NULL) FROM reqForSv) THEN NULL
		WHEN ((SELECT COUNT(*) FROM inclInSv) - (SELECT COUNT(*) FROM reqForSv) >= 0) THEN TRUE
		ELSE FALSE
	END AS vl, req_type FROM inclInSv
ORDER BY vl
LIMIT 1');


INSERT INTO system.br_validation(br_id, severity_code, target_service_moment, target_code, order_of_execution) 
VALUES('required-sources-are-present', 'critical', 'complete', 'service', 230);

------------------------------------------------------------------------------------------------

INSERT INTO system.br(id, technical_type_code, feedback, technical_description) 
VALUES('service-has-person-verification', 'sql', 'Within the application for the service a personal identification verification should be attached.::::Non esistono dettagli identificativi registrati per la pratica',
 '#{id}(application.service.id) is requested');

INSERT INTO system.br_definition(br_id, active_from, active_until, body) 
VALUES('service-has-person-verification', now(), 'infinity', 
'SELECT (CASE 	WHEN sv.application_id is  NULL THEN NULL
		ELSE COUNT(1) > 0
	 END) as vl
FROM application.service sv
  LEFT JOIN application.application_uses_source aus ON (aus.application_id = sv.application_id)
  LEFT JOIN source.source sc ON ((sc.id = aus.source_id) AND (sc.type_code = ''idVerification''))
WHERE sv.id= #{id}
GROUP BY sv.id, sv.application_id
LIMIT 1');

INSERT INTO system.br_validation(br_id, severity_code, target_service_moment, target_code, order_of_execution) 
VALUES('service-has-person-verification', 'critical', 'complete', 'service', 350);

----------------------------------------------------------------------------------------------------


insert into system.br(id, technical_type_code, feedback, technical_description) 
values('application-baunit-check-area', 'sql', 'Title has the same area as the combined area of its associated parcels::::La Area della BA Unit (Unita Amministrativa di Base) non ha la stessa estensione di quella delle sue particelle',
 '#{id}(ba_unit_id) is requested');

insert into system.br_definition(br_id, active_from, active_until, body) 
values('application-baunit-check-area', now(), 'infinity', 
'select
       ( 
         select coalesce(cast(sum(a.size)as float),0)
	 from administrative.ba_unit_area a
         inner join administrative.ba_unit ba
         on a.ba_unit_id = ba.id
         where ba.transaction_id = #{id}
         and a.type_code =  ''officialArea''
       ) 
   = 

       (
         select coalesce(cast(sum(a.size)as float),0)
	 from cadastre.spatial_value_area a
	 where  a.type_code = ''officialArea''
	 and a.spatial_unit_id in
           (  select b.spatial_unit_id
              from administrative.ba_unit_contains_spatial_unit b
              inner join administrative.ba_unit ba
	      on b.ba_unit_id = ba.id
	      where ba.transaction_id = #{id}
           )

        ) as vl');

INSERT INTO system.br_validation(br_id, target_code, target_request_type_code, severity_code, order_of_execution)
VALUES ('application-baunit-check-area', 'service', 'cadastreChange', 'warning', 520);
----------------------------------------------------------------------------------------------------

insert into system.br(id, technical_type_code) values('generate-dispute-nr', 'sql');

insert into system.br_definition(br_id, active_from, active_until, body) 
values('generate-dispute-nr', now(), 'infinity', 
'SELECT to_char(now(), ''yymm'') || trim(to_char(nextval(''administrative.dispute_nr_seq''), ''0000'')) AS vl');

update system.br set display_name = id where display_name is null;

----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------
INSERT INTO system.br(id, display_name, technical_type_code, feedback, description, technical_description)
VALUES ('ba_unit-has-several-mortgages-from-different-lenders', 'ba_unit-has-several-mortgages-from-different-lenders', 'sql', 
'The identified title should not have Mortgages from different lenders::::...', '', '');


INSERT INTO system.br(id, display_name, technical_type_code, feedback, description, technical_description)
VALUES ('ba_unit-has-mortgage-not-discharged', 'ba_unit-has-mortgage-not-discharged', 'sql', 
'All existing mortgages on the title must be cancelled ::::...', '', '{id}(application_id) is requested');

INSERT INTO system.br(id, display_name, technical_type_code, feedback, description, technical_description)
VALUES ('ba_unit-has-mortgage-registered', 'ba_unit-has-mortgage-registered', 'sql', 
'In order To start the selected service, the selected title should have a registered mortgage::::...', '', '{id}(service_id) is requested');

-----------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO system.br_definition(br_id, active_from, active_until, body)
    VALUES (
'ba_unit-has-several-mortgages-from-different-lenders', '2013-06-17', 'infinity', 
'SELECT count(distinct party_for_rrr.party_id) = 1 as vl
FROM 
  application.service sv, 
  transaction.transaction, 
  administrative.rrr pending_rrr, 
  administrative.rrr current_rrr, 
  administrative.party_for_rrr
WHERE 
  sv.id = transaction.from_service_id AND
  transaction.id = pending_rrr.transaction_id AND
  pending_rrr.ba_unit_id = current_rrr.ba_unit_id AND
  current_rrr.id = party_for_rrr.rrr_id AND
  sv.status_code = ''pending'' AND 
  sv.request_type_code = ''mortgage'' AND 
  current_rrr.type_code = ''mortgage'' AND 
  current_rrr.status_code IN (''current'',''pending'') AND 
  sv.id = #{id};');

 INSERT INTO system.br_definition( br_id, active_from, active_until, body)
 VALUES (
 'ba_unit-has-mortgage-not-discharged', '2013-06-17', 'infinity', 
 'SELECT  count(*) = 0 as vl 
FROM 
  application.service, 
  administrative.ba_unit, 
  administrative.rrr, 
  application.application_property
WHERE 
  ba_unit.id = rrr.ba_unit_id AND
  application_property.application_id = service.application_id AND
  application_property.ba_unit_id = ba_unit.id AND
  rrr.type_code = ''mortgage'' AND 
  rrr.status_code = ''current'' AND
  service.id = #{id};'); 
  
  INSERT INTO system.br_definition( br_id, active_from, active_until, body)
 VALUES (
 'ba_unit-has-mortgage-registered', '2013-06-17', 'infinity', 
 'SELECT 
  count(*) > 0 as vl
FROM 
  application.service sv, 
  application.application_property ap, 
  administrative.ba_unit ba, 
  administrative.rrr rr
WHERE 
  sv.application_id = ap.application_id AND
  ba.id = ap.ba_unit_id AND
  ba.id = rr.ba_unit_id AND
  rr.type_code = ''mortgage'' AND 
  rr.status_code = ''current'' AND 
  sv.id = #{id};');

-----------------------------------------------------------------------------------------------------------------------------------------------------

	INSERT INTO system.br_validation(
            id, br_id, target_code, target_application_moment, 
			target_service_moment, target_reg_moment, target_request_type_code, 
			target_rrr_type_code, severity_code, order_of_execution)
    VALUES (uuid_generate_v1(), 'ba_unit-has-several-mortgages-from-different-lenders', 'service', NULL, 
			'complete', NULL, 'mortgage', 
			NULL, 'critical', 150);
	
	
	INSERT INTO system.br_validation(
            id, br_id, target_code, target_application_moment, 
			target_service_moment, target_reg_moment, target_request_type_code, 
			target_rrr_type_code, severity_code, order_of_execution)
    VALUES (uuid_generate_v1(), 'ba_unit-has-mortgage-not-discharged', 'service', NULL, 
			'start', NULL, 'cancelProperty', 
			NULL, 'critical', 20);
			
	INSERT INTO system.br_validation(
            id, br_id, target_code, target_application_moment, 
			target_service_moment, target_reg_moment, target_request_type_code, 
			target_rrr_type_code, severity_code, order_of_execution)
    VALUES (uuid_generate_v1(), 'ba_unit-has-mortgage-registered', 'service', NULL, 
			'start', NULL, 'cancelMortBonds', 
			NULL, 'critical', 20);
						
-------------------------------------------------------------------------------------------------------------------------------------------------
INSERT INTO system.br(id, display_name, technical_type_code, feedback, description, technical_description)
VALUES ('service-new-lease-complete', 'service-new-lease-complete', 'sql', 
'Scanned lease document must be attached on the registration form', 'Run checks prior to the lease registration service completion', '');

insert into system.br_definition(br_id, active_from, active_until, body) 
values('service-new-lease-complete', now(), 'infinity', 
'select count(*)>0 as vl
from application.service s 
  inner join (transaction.transaction t 
    inner join (administrative.rrr r 
      inner join (administrative.source_describes_rrr sdr 
        inner join source.source sr on sdr.source_id = sr.id)
      on r.id = sdr.rrr_id) 
    on t.id = r.transaction_id)
  on s.id = t.from_service_id
where s.id = #{id} and sr.type_code = ''lease'' and sr.ext_archive_id is not null');

--INSERT INTO system.br_validation(br_id, target_code, target_service_moment, target_request_type_code, severity_code, order_of_execution)
--VALUES ('service-new-lease-complete', 'service', 'complete', 'newLease', 'critical', 1);

INSERT INTO system.br_validation(br_id, target_code, target_service_moment, target_request_type_code, severity_code, order_of_execution)
VALUES ('service-new-lease-complete', 'service', 'complete', 'registerLease', 'critical', 2);

-----------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO system.br(id, display_name, technical_type_code, feedback, description, technical_description)
VALUES ('mortgage-lender-is-varied', 'mortgage-lender-is-varied', 'sql', 
'mortgagee must be varied/changed', 'Run checks prior to the variation of mortgage service completion', '');

INSERT INTO system.br_definition(br_id, active_from, active_until, body) 
values('mortgage-lender-is-varied', now(), 'infinity', 
'WITH rrr_list AS
(SELECT 
  party_for_rrr.party_id 
FROM 
  application.service sv, 
  transaction.transaction tx, 
  administrative.rrr pending_rrr, 
  administrative.rrr, 
  administrative.party_for_rrr
WHERE 
  sv.id = tx.from_service_id AND
  tx.id = pending_rrr.transaction_id AND
  pending_rrr.ba_unit_id = rrr.ba_unit_id AND
  rrr.id = party_for_rrr.rrr_id AND
  sv.id = #{id} AND 
  rrr.type_code = ''mortgage'' AND 
  rrr.status_code = ''current''
UNION  
SELECT  
  party_for_rrr.party_id
FROM 
  application.service sv, 
  transaction.transaction tx, 
  administrative.rrr pending_rrr, 
  administrative.party_for_rrr
WHERE 
  sv.id = tx.from_service_id AND
  tx.id = pending_rrr.transaction_id AND
  pending_rrr.id = party_for_rrr.rrr_id AND
  sv.id = #{id})
  SELECT COUNT(DISTINCT party_id) > 1 AS vl
  from rrr_list');

INSERT INTO system.br_validation(br_id, target_code, target_service_moment, target_request_type_code, severity_code, order_of_execution)
VALUES ('mortgage-lender-is-varied', 'service', 'complete', 'varyMortgage', 'critical', 1);

-----------------------------------------------------------------------------------------------------------------------------------------------------