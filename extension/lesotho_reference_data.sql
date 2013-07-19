-- Show the application as on hold when it is in the requistioned state. 
UPDATE application.application_status_type
SET display_value = 'On hold'
WHERE code = 'requisitioned';