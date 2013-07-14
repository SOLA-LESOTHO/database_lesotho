
insert into system.br(id, technical_type_code, feedback, technical_description) 
values('target-parcels-present', 'sql', 'Target parcel(s) must be selected::::Esistono particelle originarie selezionate',
 '#{id}(transaction_id) is requested');

insert into system.br_definition(br_id, active_from, active_until, body) 
values('target-parcels-present', now(), 'infinity', 
 'select count (*) > 0 as vl from cadastre.cadastre_object_target where transaction_id= #{id}');

insert into system.br_validation(br_id, severity_code, target_reg_moment, target_code, order_of_execution) 
values('target-parcels-present', 'warning', 'pending', 'cadastre_object', 450);

insert into system.br_validation(br_id, severity_code, target_reg_moment, target_code, order_of_execution) 
values('target-parcels-present', 'warning', 'current', 'cadastre_object', 440);

----------------------------------------------------------------------------------------------------

insert into system.br(id, technical_type_code, feedback, technical_description) 
values('target-parcels-check-nopending', 'sql', 'There should be no pending changes for any of target parcels::::Vi sono modifiche pendenti che bloccano la unione delle Particelle',
 '#{id}(cadastre.cadastre_object.id) is requested');

insert into system.br_definition(br_id, active_from, active_until, body) 
values('target-parcels-check-nopending', now(), 'infinity', 
 'select (select count(*)=0 
  from cadastre.cadastre_object_target target_also inner join transaction.transaction t 
    on target_also.transaction_id = t.id and t.status_code not in (''approved'')
  where co_target.transaction_id != target_also.transaction_id
    and co_target.cadastre_object_id= target_also.cadastre_object_id) as vl
from cadastre.cadastre_object_target co_target
where co_target.transaction_id = #{id}
 ');

insert into system.br_validation(br_id, severity_code, target_reg_moment, target_code, order_of_execution) 
values('target-parcels-check-nopending', 'critical', 'pending', 'cadastre_object', 310);

insert into system.br_validation(br_id, severity_code, target_reg_moment, target_code, order_of_execution) 
values('target-parcels-check-nopending', 'critical', 'current', 'cadastre_object', 300);

----------------------------------------------------------------------------------------------------

insert into system.br(id, technical_type_code, feedback, technical_description) 
values('cadastre-redefinition-union-old-new-the-same', 'sql', 
    'The union of the new polygons must be the same as the union of the old polygons::::La unione dei nuovi poligoni deve esser la stessa di quella dei vecchi poligoni',
 '#{id} is the parameter asked. It is the transaction id.');

insert into system.br_definition(br_id, active_from, active_until, body) 
values('cadastre-redefinition-union-old-new-the-same', now(), 'infinity', 
'select st_equals(geom_to_snap,target_geom) as vl from cadastre.snap_geometry_to_geometry((select st_union(co.geom_polygon) from cadastre.cadastre_object co 
 where id in (select cadastre_object_id from cadastre.cadastre_object_target co_t where transaction_id = #{id})), 
(select st_union(co_t.geom_polygon) from cadastre.cadastre_object_target co_t where transaction_id = #{id}), 
 system.get_setting(''map-tolerance'')::double precision, true)');

INSERT INTO system.br_validation(br_id, target_code, target_reg_moment, target_request_type_code, severity_code, order_of_execution)
VALUES ('cadastre-redefinition-union-old-new-the-same', 'cadastre_object', 'current', 'redefineCadastre', 'warning', 400);

INSERT INTO system.br_validation(br_id, target_code, target_reg_moment, target_request_type_code, severity_code, order_of_execution)
VALUES ('cadastre-redefinition-union-old-new-the-same', 'cadastre_object', 'pending', 'redefineCadastre', 'warning', 420);

----------------------------------------------------------------------------------------------------

insert into system.br(id, technical_type_code, feedback, technical_description) 
values('cadastre-redefinition-target-geometries-dont-overlap', 'sql', 
    'New polygons do not overlap with each other.::::I nuovi poligoni non devono sovrapporsi',
 '#{id} is the parameter asked. It is the transaction id.');

insert into system.br_definition(br_id, active_from, active_until, body) 
values('cadastre-redefinition-target-geometries-dont-overlap', now(), 'infinity', 
'select coalesce(st_area(st_union(co.geom_polygon)) = sum(st_area(co.geom_polygon)), true) as vl
from cadastre.cadastre_object_target co where transaction_id = #{id}');

INSERT INTO system.br_validation(br_id, target_code, target_reg_moment, target_request_type_code, severity_code, order_of_execution)
VALUES ('cadastre-redefinition-target-geometries-dont-overlap', 'cadastre_object', 'current', 'redefineCadastre', 'critical', 120);

INSERT INTO system.br_validation(br_id, target_code, target_reg_moment, target_request_type_code, severity_code, order_of_execution)
VALUES ('cadastre-redefinition-target-geometries-dont-overlap', 'cadastre_object', 'pending', 'redefineCadastre', 'warning', 430);

----------------------------------------------------------------------------------------------------

insert into system.br(id, technical_type_code, feedback, technical_description) 
values('survey-points-present', 'sql', 'There are at least 3 survey points present::::Devono esservi almeno 3 punti di controllo',
 '#{id}(transaction_id) is requested. Check there are survey points attached with the cadastre change.
 At least 3 points has to be attached to complete a polygon.');

insert into system.br_definition(br_id, active_from, active_until, body) 
values('survey-points-present', now(), 'infinity', 
 'select count (*) > 2  as vl from cadastre.survey_point where transaction_id= #{id}');

insert into system.br_validation(br_id, severity_code, target_reg_moment, target_code, target_request_type_code, order_of_execution) 
values('survey-points-present', 'warning', 'pending', 'cadastre_object', 'cadastreChange', 380);

insert into system.br_validation(br_id, severity_code, target_reg_moment, target_code, target_request_type_code, order_of_execution) 
values('survey-points-present', 'critical', 'current', 'cadastre_object', 'cadastreChange', 70);

----------------------------------------------------------------------------------------------------

insert into system.br(id, technical_type_code, feedback, technical_description) 
values('target-parcels-check-isapolygon', 'sql', 'The union of the target parcels must be a polygon::::La unione di Particelle deve essere un poligono unico',
 '#{id}(cadastre.cadastre_object.transaction_id) is requested');

insert into system.br_definition(br_id, active_from, active_until, body) 
values('target-parcels-check-isapolygon', now(), 'infinity', 
'select St_GeometryType(ST_Union(co.geom_polygon)) = ''ST_Polygon'' as vl
 from cadastre.cadastre_object co 
  inner join cadastre.cadastre_object_target co_target
   on co.id = co_target.cadastre_object_id
    where co_target.transaction_id = #{id}');
    
insert into system.br_validation(br_id, severity_code, target_reg_moment, target_code, target_request_type_code, order_of_execution) 
values('target-parcels-check-isapolygon', 'critical', 'pending', 'cadastre_object', 'cadastreChange', 90);

insert into system.br_validation(br_id, severity_code, target_reg_moment, target_code, target_request_type_code, order_of_execution) 
values('target-parcels-check-isapolygon', 'critical', 'current', 'cadastre_object', 'cadastreChange', 80);

----------------------------------------------------------------------------------------------------

insert into system.br(id, technical_type_code, feedback, technical_description) 
values('new-cadastre-objects-present', 'sql', 'New cadastral objects must be defined::::Vi sono nuovi oggetti catastali definiti',
 '#{id}(transaction_id) is requested');

insert into system.br_definition(br_id, active_from, active_until, body) 
values('new-cadastre-objects-present', now(), 'infinity', 
 'select count (*) > 0 as vl from cadastre.cadastre_object where transaction_id= #{id}');

insert into system.br_validation(br_id, severity_code, target_reg_moment, target_code, target_request_type_code, order_of_execution) 
values('new-cadastre-objects-present', 'warning', 'pending', 'cadastre_object', 'cadastreChange', 370);

insert into system.br_validation(br_id, severity_code, target_reg_moment, target_code, target_request_type_code, order_of_execution) 
values('new-cadastre-objects-present', 'critical', 'current', 'cadastre_object', 'cadastreChange', 50);

----------------------------------------------------------------------------------------------------

insert into system.br(id, technical_type_code, feedback, technical_description) 
values('new-cadastre-objects-do-not-overlap', 'sql', 'The new parcel polygons must not overlap::::I nuovi oggetti catastali non devono sovrapporsi',
 '#{id}(transaction_id) is requested. Check the union of new co has the same area as the sum of all areas of new co-s, which means the new co-s don''t overlap');

 -- AM Only check parcels and ignore subplots as these do overlap parcels. 
INSERT INTO system.br_definition(br_id, active_from, active_until, body) 
VALUES('new-cadastre-objects-do-not-overlap', now(), 'infinity', 
 'WITH tolerance AS (SELECT CAST(ABS(LOG((CAST (vl AS NUMERIC)^2))) AS INT) AS area FROM system.setting where name = ''map-tolerance'' LIMIT 1)

SELECT COALESCE(ROUND(CAST (ST_AREA(ST_UNION(co.geom_polygon))AS NUMERIC), (SELECT area FROM tolerance)) = 
		ROUND(CAST(SUM(ST_AREA(co.geom_polygon))AS NUMERIC), (SELECT area FROM tolerance)), 
		TRUE) AS vl
FROM cadastre.cadastre_object co 
WHERE transaction_id = #{id} 
AND   co.type_code = ''parcel''');

insert into system.br_validation(br_id, severity_code, target_reg_moment, target_code, target_request_type_code, order_of_execution) 
values('new-cadastre-objects-do-not-overlap', 'critical', 'pending', 'cadastre_object', 'cadastreChange', 60);

insert into system.br_validation(br_id, severity_code, target_reg_moment, target_code, target_request_type_code, order_of_execution) 
values('new-cadastre-objects-do-not-overlap', 'medium', 'current', 'cadastre_object', 'cadastreChange', 480);

----------------------------------------------------------------------------------------------------

insert into system.br(id, technical_type_code, feedback, technical_description) 
values('area-check-percentage-newofficialarea-calculatednewarea', 'sql', 'The difference between the new official parcel area and the new calculated area should be less than 1%::::Il valore della nuova area ufficiale -  quello CALCOLATO della nuova area / 
il valore della nuova area ufficiale in percentuale non dovrebbe essere superiore all 1%',
 '#{id}(cadastre.cadastre_object.id) is requested. 
 Check new official area - calculated new area / new official area in percentage (Give in WARNING description, percentage & parcel if percentage > 1%)');

-- AM Only check parcels and ignore subplots as these do overlap parcels.
insert into system.br_definition(br_id, active_from, active_until, body) 
values('area-check-percentage-newofficialarea-calculatednewarea', now(), 'infinity', 
'select count(*) = 0 as vl
from cadastre.cadastre_object co 
  left join cadastre.spatial_value_area sa_calc on (co.id= sa_calc.spatial_unit_id and sa_calc.type_code =''calculatedArea'')
  left join cadastre.spatial_value_area sa_official on (co.id= sa_official.spatial_unit_id and sa_official.type_code =''officialArea'')
where co.transaction_id = #{id} and co.type_code = ''parcel'' and
(abs(coalesce(sa_official.size, 0) - coalesce(sa_calc.size, 0)) 
/ 
(case when sa_official.size is null or sa_official.size = 0 then 1 else sa_official.size end)) > 0.01');

INSERT INTO system.br_validation(br_id, target_code, target_reg_moment, target_request_type_code, severity_code, order_of_execution)
VALUES ('area-check-percentage-newofficialarea-calculatednewarea', 'cadastre_object', 'current', 'cadastreChange', 'warning', 610);

INSERT INTO system.br_validation(br_id, target_code, target_reg_moment, target_request_type_code, severity_code, order_of_execution)
VALUES ('area-check-percentage-newofficialarea-calculatednewarea', 'cadastre_object', 'pending', 'cadastreChange', 'warning', 620);


----------------------------------------------------------------------------------------------------

insert into system.br(id, technical_type_code, feedback, technical_description) 
values('cadastre-object-check-name', 'sql', 'The parcel (cadastre object) should have a valid form of description (appellation)::::Identificativo per la particella (oggetto catastale) invalido',
 '#{id}(cadastre.cadastre_object.id) is requested');

insert into system.br_definition(br_id, active_from, active_until, body) 
values('cadastre-object-check-name', now(), 'infinity', 
'Select cadastre.cadastre_object_name_is_valid(name_firstpart, name_lastpart) as vl 
FROM cadastre.cadastre_object
WHERE transaction_id = #{id}
order by 1
limit 1');

INSERT INTO system.br_validation(br_id, target_code, target_reg_moment, target_request_type_code, severity_code, order_of_execution)
VALUES ('cadastre-object-check-name', 'cadastre_object', 'current', 'cadastreChange', 'medium', 600);

INSERT INTO system.br_validation(br_id, target_code, target_reg_moment, target_request_type_code, severity_code, order_of_execution)
VALUES ('cadastre-object-check-name', 'cadastre_object', 'pending', 'cadastreChange', 'medium', 660);

----------------------------------------------------------------------------------------------------

insert into system.br(id, technical_type_code, feedback) 
values('area-check-percentage-newareas-oldareas', 'sql', 'The difference between the total of the new parcels official areas and the total of the old parcels official areas should not be greater than 0.1%::::Il valore delle nuove aree ufficiali -  quello delle vecchie / 
il valore delle vecchie aree ufficiali in percentuale non dovrebbe essere superiore allo 0.1%');

insert into system.br_definition(br_id, active_from, active_until, body) 
values('area-check-percentage-newareas-oldareas', now(), 'infinity', 
'select abs((select cast(sum(a.size)as float)
	from cadastre.spatial_value_area a
	where a.type_code = ''officialArea''
        and a.spatial_unit_id in (
	   select co_new.id
		from cadastre.cadastre_object co_new 
		where co_new.transaction_id = #{id}
		and co_new.type_code = ''parcel''))
 -
   (select cast(sum(a.size)as float)
	from cadastre.spatial_value_area a
	where a.type_code = ''officialArea''
	and a.spatial_unit_id in ( 
	      select co_target.cadastre_object_id
		from cadastre.cadastre_object_target co_target
		    where co_target.transaction_id = #{id})) 
 ) /(select cast(sum(a.size)as float)
	from cadastre.spatial_value_area a
	where a.type_code = ''officialArea''
	and a.spatial_unit_id in ( 
	      select co_target.cadastre_object_id
		from cadastre.cadastre_object_target co_target
		    where co_target.transaction_id = #{id})) 
 < 0.001 as vl');

INSERT INTO system.br_validation(br_id, target_code, target_reg_moment, target_request_type_code, severity_code, order_of_execution)
VALUES ('area-check-percentage-newareas-oldareas', 'cadastre_object', 'pending', 'cadastreChange', 'warning', 640);

INSERT INTO system.br_validation(br_id, target_code, target_reg_moment, target_request_type_code, severity_code, order_of_execution)
VALUES ('area-check-percentage-newareas-oldareas', 'cadastre_object', 'current', 'cadastreChange', 'warning', 630);

----------------------------------------------------------------------------------------------------

INSERT INTO system.br (id, display_name, technical_type_code, feedback, description, technical_description) 
VALUES ('newly-created-cadastre-object-should-not-overlap-existing',
	'newly-created-cadastre-object-should-not-overlap-existing', 
	'sql', 
	'Newly created cadastre object should not overlap with any existing parcels::::...', 
	NULL, 
	'Checks that no parcels overlap');

-- AM limit check to parcels only to avoid false positive failures for subplots
INSERT INTO system.br_definition (br_id, active_from, active_until, body) 
VALUES ('newly-created-cadastre-object-should-not-overlap-existing', '2013-05-30', 'infinity', 
'SELECT CASE
	WHEN
		(SELECT st_overlaps(co.geom_polygon, co2.geom_polygon)
		AS vl
		FROM cadastre.cadastre_object co, cadastre.cadastre_object co2
		WHERE co.transaction_id = #{id}
		AND co.type_code = ''parcel''
		AND co2.id NOT IN (SELECT cadastre_object_id FROM cadastre.cadastre_object_target)
		AND co2.type_code = ''parcel''
		AND st_overlaps(co.geom_polygon, co2.geom_polygon) LIMIT 1) THEN FALSE
	ELSE TRUE
END
AS vl');


INSERT INTO system.br_validation (br_id, target_code, target_application_moment, target_service_moment, target_reg_moment, target_request_type_code, target_rrr_type_code, severity_code, order_of_execution) 
VALUES ('newly-created-cadastre-object-should-not-overlap-existing', 
	'cadastre_object', 
	NULL, 
	NULL, 
	'current', 
	'cadastreChange', 
	NULL, 
	'critical', 
	500);

INSERT INTO system.br_validation (br_id, target_code, target_application_moment, target_service_moment, target_reg_moment, target_request_type_code, target_rrr_type_code, severity_code, order_of_execution) 
VALUES ('newly-created-cadastre-object-should-not-overlap-existing', 
	'cadastre_object', 
	NULL, 
	NULL, 
	'pending', 
	'cadastreChange', 
	NULL, 
	'critical', 
	60);
	
----------------------------------------------------------------------------------------------------

INSERT INTO system.br (id, display_name, technical_type_code, feedback, description, technical_description) 
VALUES ('redefined-cadastre-objects-do-not-overlap-existing-parcels',
	'redefined-cadastre-objects-do-not-overlap-existing-parcels', 
	'sql', 
	'Redefined cadastre object should not overlap with any existing parcels::::...', 
	NULL, 
	'Checks that no parcels overlap');

INSERT INTO system.br_definition (br_id, active_from, active_until, body) 
VALUES ('redefined-cadastre-objects-do-not-overlap-existing-parcels', '2013-05-30', 'infinity', 'SELECT CASE
	WHEN EXISTS 
		(SELECT co2.id
		FROM cadastre.cadastre_object_target cot, cadastre.cadastre_object co2
		WHERE cot.transaction_id = #{id}
		AND co2.status_code != ''historic''
		AND co2.id NOT IN (SELECT cot2.cadastre_object_id FROM cadastre.cadastre_object_target cot2
                           WHERE cot.transaction_id = cot.transaction_id)
		AND st_overlaps(cot.geom_polygon, co2.geom_polygon)) THEN FALSE
	ELSE TRUE
END
AS vl;');


INSERT INTO system.br_validation (br_id, target_code, target_application_moment, target_service_moment, target_reg_moment, target_request_type_code, target_rrr_type_code, severity_code, order_of_execution) 
VALUES ('redefined-cadastre-objects-do-not-overlap-existing-parcels', 
	'cadastre_object', 
	NULL, 
	NULL, 
	'current', 
	'redefineCadastre', 
	NULL, 
	'critical', 
	500);

INSERT INTO system.br_validation (br_id, target_code, target_application_moment, target_service_moment, target_reg_moment, target_request_type_code, target_rrr_type_code, severity_code, order_of_execution) 
VALUES ('redefined-cadastre-objects-do-not-overlap-existing-parcels', 
	'cadastre_object', 
	NULL, 
	NULL, 
	'pending', 
	'redefineCadastre', 
	NULL, 
	'critical', 
	60);

----------------------------------------------------------------------------------------------------

update system.br set display_name = id where display_name !=id;


----------------------------------------------------------------------------------------------------
-- New business rule for Lesotho to check a subplot is wholly within the area of its parent parcel
insert into system.br(id, technical_type_code, feedback, technical_description) 
values('subplot-not-contained-by-lease-plot', 'sql', 'The subplot extends beyond the boundary of the lease plot.',
 '#{id}(transaction id) is requested');

insert into system.br_definition(br_id, active_from, active_until, body) 
values('subplot-not-contained-by-lease-plot', now(), 'infinity', 
'SELECT CASE WHEN EXISTS ( 
    SELECT co.name_lastpart
    FROM   cadastre.cadastre_object co,
	       cadastre.cadastre_object co2
    WHERE  co.transaction_id = #{id}
    AND    co.type_code = ''subplot''
	AND    co2.type_code = ''parcel''
	AND    co2.name_firstpart || ''-'' || co2.name_lastpart = co.name_firstpart
	AND NOT st_contains(st_buffer(co2.geom_polygon,system.get_setting(''map-tolerance'')::double precision), co.geom_polygon))
	THEN FALSE ELSE TRUE END as vl');

INSERT INTO system.br_validation(br_id, target_code, target_reg_moment, target_request_type_code, severity_code, order_of_execution)
VALUES ('subplot-not-contained-by-lease-plot', 'cadastre_object', 'current', 'cadastreChange', 'medium', 680);

INSERT INTO system.br_validation(br_id, target_code, target_reg_moment, target_request_type_code, severity_code, order_of_execution)
VALUES ('subplot-not-contained-by-lease-plot', 'cadastre_object', 'pending', 'cadastreChange', 'medium', 690);

----------------------------------------------------------------------------------------------------
-- New business rule for Lesotho to check a subplots do not overlap
insert into system.br(id, technical_type_code, feedback, technical_description) 
values('new-subplots-do-not-overlap', 'sql', 'New subplots overlap each other',
 '#{id}(transaction id) is requested');

insert into system.br_definition(br_id, active_from, active_until, body) 
values('new-subplots-do-not-overlap', now(), 'infinity', 
 'WITH tolerance AS (SELECT CAST(ABS(LOG((CAST (vl AS NUMERIC)^2))) AS INT) AS area FROM system.setting where name = ''map-tolerance'' LIMIT 1)

SELECT COALESCE(ROUND(CAST (ST_AREA(ST_UNION(co.geom_polygon))AS NUMERIC), (SELECT area FROM tolerance)) = 
		ROUND(CAST(SUM(ST_AREA(co.geom_polygon))AS NUMERIC), (SELECT area FROM tolerance)), 
		TRUE) AS vl
FROM cadastre.cadastre_object co 
WHERE transaction_id = #{id} 
AND   co.type_code = ''subplot''');

INSERT INTO system.br_validation(br_id, target_code, target_reg_moment, target_request_type_code, severity_code, order_of_execution)
VALUES ('new-subplots-do-not-overlap', 'cadastre_object', 'current', 'cadastreChange', 'medium', 700);

INSERT INTO system.br_validation(br_id, target_code, target_reg_moment, target_request_type_code, severity_code, order_of_execution)
VALUES ('new-subplots-do-not-overlap', 'cadastre_object', 'pending', 'cadastreChange', 'medium', 710);

----------------------------------------------------------------------------------------------------
-- New business rule for Lesotho to check a subplots do not overlap
insert into system.br(id, technical_type_code, feedback, technical_description) 
values('subplots-overlap-existing-subplots', 'sql', 'New subplots overlap existing subplots',
 '#{id}(transaction id) is requested');

insert into system.br_definition(br_id, active_from, active_until, body) 
values('subplots-overlap-existing-subplots', now(), 'infinity', 
 'SELECT CASE
	WHEN
		(SELECT st_overlaps(co.geom_polygon, co2.geom_polygon)
		AS vl
		FROM cadastre.cadastre_object co, cadastre.cadastre_object co2
		WHERE co.transaction_id = #{id}
		AND co.type_code = ''subplot''
		AND COALESCE(co2.transaction_id, ''0'') != co.transaction_id
		AND co2.type_code = ''subplot''
		AND st_overlaps(co.geom_polygon, co2.geom_polygon) LIMIT 1) THEN FALSE
	ELSE TRUE
END
AS vl');

INSERT INTO system.br_validation(br_id, target_code, target_reg_moment, target_request_type_code, severity_code, order_of_execution)
VALUES ('subplots-overlap-existing-subplots', 'cadastre_object', 'current', 'cadastreChange', 'medium', 720);

INSERT INTO system.br_validation(br_id, target_code, target_reg_moment, target_request_type_code, severity_code, order_of_execution)
VALUES ('subplots-overlap-existing-subplots', 'cadastre_object', 'pending', 'cadastreChange', 'medium', 730);

----------------------------------------------------------------------------------------------------
-- Warn the user that the target parcel will be made historic when the application is approved
insert into system.br(id, technical_type_code, feedback, technical_description) 
values('warn-target-parcel-selected', 'sql', 'There are no new parcels to replace the target parcel. The target parcel will be made historic when the application is approved',
 '#{id}(transaction id) is requested');

insert into system.br_definition(br_id, active_from, active_until, body) 
values('warn-target-parcel-selected', now(), 'infinity', 
 'SELECT FALSE AS vl
  WHERE (SELECT count(*) FROM cadastre.cadastre_object_target WHERE transaction_id = #{id}) > 0
  AND   (SELECT count(*) FROM cadastre.cadastre_object 
         WHERE transaction_id = #{id}
		 AND   type_code = ''parcel'') = 0');

INSERT INTO system.br_validation(br_id, target_code, target_reg_moment, target_request_type_code, severity_code, order_of_execution)
VALUES ('warn-target-parcel-selected', 'cadastre_object', 'current', 'cadastreChange', 'medium', 740);

INSERT INTO system.br_validation(br_id, target_code, target_reg_moment, target_request_type_code, severity_code, order_of_execution)
VALUES ('warn-target-parcel-selected', 'cadastre_object', 'pending', 'cadastreChange', 'medium', 750);