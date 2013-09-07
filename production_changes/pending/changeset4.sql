ALTER TABLE application.application
ADD column receipt_date date;

UPDATE cadastre.land_use_grade
   SET registration_fee='25'
 WHERE land_use_code ='recreational';

 UPDATE cadastre.land_use_grade
   SET registration_fee='25'
 WHERE land_use_code ='charitable';

 UPDATE cadastre.land_use_grade
   SET registration_fee='25'
 WHERE land_use_code ='educational';

 UPDATE cadastre.land_use_grade
   SET registration_fee='25'
 WHERE land_use_code ='religious';

 UPDATE cadastre.land_use_grade
   SET registration_fee='25'
 WHERE land_use_code ='hospital';

 UPDATE cadastre.land_use_grade
   SET registration_fee='25'
 WHERE land_use_code ='benovelent';
 
 UPDATE cadastre.land_use_grade
   SET registration_fee='25'
 WHERE land_use_code ='devotional';

