delete from application.service;
delete from application.request_type as rt where rt.code = 'regSurrenderLease';
update application.request_type  set display_value = 'Surrender of a lease' where code = 'cancelProperty';
update application.request_type  set status = 'c' where code = 'varyLease';
update application.request_type  set display_value = 'Termination of a lease' ,status = 'c' where code = 'removeRight';