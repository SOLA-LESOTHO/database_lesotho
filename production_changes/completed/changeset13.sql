-- Function: application.get_work_statistics(date, date)

-- DROP FUNCTION application.get_work_statistics(date, date);

CREATE OR REPLACE FUNCTION application.get_work_statistics(IN from_date date, IN to_date date)
  RETURNS TABLE(req_type character varying, req_cat character varying, group_idx integer, lodged integer, cancelled integer, completed integer) AS
$BODY$
DECLARE 
   tmp_date DATE; 
BEGIN

   IF to_date IS NULL OR from_date IS NULL THEN
      RETURN;
   END IF; 

   -- Swap the dates so the to date is after the from date
   IF to_date < from_date THEN 
      tmp_date := from_date; 
      from_date := to_date; 
      to_date := tmp_date; 
   END IF; 

   -- Go through to the start of the next day. 
   to_date := to_date + 1; 

   RETURN query 
   
	--Identifies all services lodged during the reporting period.
WITH service_lodged AS 
(SELECT ser.id, ser.application_id, ser.request_type_code
         FROM   application.service ser
         WHERE  ser.change_time BETWEEN from_date AND to_date
		 AND    ser.rowversion = 1
		 UNION
         SELECT ser_hist.id, ser_hist.application_id, ser_hist.request_type_code
         FROM   application.service_historic ser_hist
         WHERE  ser_hist.change_time BETWEEN from_date AND to_date
		 AND    ser_hist.rowversion = 1),

-- Identifies all services cancelled during the reporting period. 	  
	  service_cancelled AS 
        (SELECT ser.id, ser.application_id, ser.request_type_code
         FROM   application.service ser
         WHERE  ser.change_time BETWEEN from_date AND to_date
		 AND    ser.status_code = 'cancelled'
     -- Verify that the service actually changed status 
         AND  NOT EXISTS (SELECT ser_hist.status_code 
                          FROM application.service_historic ser_hist
                          WHERE ser_hist.id = ser.id
                          AND  (ser.rowversion - 1) = ser_hist.rowversion
                          AND  ser.status_code = ser_hist.status_code )
	 -- Check the history data for cancelled services as applications returned
	 -- from requisition can cause the cancelled service record to be updated. 
		UNION
		SELECT ser.id, ser.application_id, ser.request_type_code
         FROM   application.service_historic ser
         WHERE  ser.change_time BETWEEN from_date AND to_date
		 AND    ser.status_code = 'cancelled'
     -- Verify that the service actually changed status. 
         AND  NOT EXISTS (SELECT ser_hist.status_code 
                          FROM application.service_historic ser_hist
                          WHERE ser_hist.id = ser.id
                          AND  (ser.rowversion - 1) = ser_hist.rowversion
                          AND  ser.status_code = ser_hist.status_code )),

-- Identifies all services completed during the reporting period. 
        service_completed AS
		(SELECT ser.id, ser.application_id, ser.request_type_code
         FROM   application.service ser
         WHERE  ser.change_time BETWEEN from_date AND to_date
		 AND    ser.status_code = 'completed')	

SELECT get_translation(req.display_value, null) AS req_type,
	  CASE req.request_category_code 
	     WHEN 'registrationServices' THEN get_translation(cat.display_value, null)
	     WHEN 'leaseServices' THEN get_translation(cat.display_value, null)
	     WHEN 'surveyServices' THEN get_translation(cat.display_value, null)
	     WHEN 'legalServices' THEN get_translation(cat.display_value, null)
	     ELSE 'InformationServices'  END AS req_cat,
	     
	  CASE req.request_category_code 
	     WHEN 'registrationServices' THEN 1
             WHEN 'leaseServices' THEN 2
             WHEN 'surveyServices' THEN 3
             WHEN 'legalServices' THEN 4
	     ELSE 5 END AS group_idx,
		 
	  -- Count of the lodged services associated with
	  -- lodged applications at the start of the reporting period
         (SELECT COUNT(s.id) FROM service_lodged s
	      where request_type_code = req.code)::INT AS lodged,
		  
	  -- Count of the cancelled services associated with
	  -- lodged applications at the start of the reporting period
         (SELECT COUNT(s.id) FROM service_cancelled s
	      where request_type_code = req.code)::INT AS cancelled,

	  -- Count of the completed services associated with
	  -- lodged applications at the start of the reporting period
         (SELECT COUNT(s.id) FROM service_completed s
	      where request_type_code = req.code)::INT AS completed
		  
	 						
   FROM  application.request_type req, 
	 application.request_category_type cat
   WHERE req.status = 'c'
   AND   cat.code = req.request_category_code					 
   ORDER BY group_idx, req_type;
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;


