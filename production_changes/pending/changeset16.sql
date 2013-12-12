UPDATE application.request_category_type
   SET description='Information Department'
 WHERE code = 'informationServices';

UPDATE application.request_category_type
   SET description='Leasing Department'
 WHERE code = 'leaseServices';

UPDATE application.request_category_type
   SET description='Survey & Mapping Department'
 WHERE code = 'surveyServices';

UPDATE application.request_category_type
   SET description='Dispute & legal Department'
 WHERE code = 'legalServices';

UPDATE application.request_category_type
   SET description='Registration Department'
 WHERE code = 'registrationServices';
