ALTER TABLE application.application
ADD column receipt_date date;

ALTER TABLE application.application_historic
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
 
insert into cadastre.land_use_grade(land_use_code, land_grade_code, admin_fee, ground_rent_rate, duty_on_ground_rent, registration_fee) values('institutional', 'grade1', 100, 200, 0, 25);
insert into cadastre.land_use_grade(land_use_code, land_grade_code, admin_fee, ground_rent_rate, duty_on_ground_rent, registration_fee) values('institutional', 'grade2', 100, 200, 0, 25);
insert into cadastre.land_use_grade(land_use_code, land_grade_code, admin_fee, ground_rent_rate, duty_on_ground_rent, registration_fee) values('institutional', 'grade3', 100, 200, 0, 25);
insert into cadastre.land_use_grade(land_use_code, land_grade_code, admin_fee, ground_rent_rate, duty_on_ground_rent, registration_fee) values('institutional', 'grade4', 100, 200, 0, 25);
insert into cadastre.land_use_grade(land_use_code, land_grade_code, admin_fee, ground_rent_rate, duty_on_ground_rent, registration_fee) values('institutional', 'grade5', 100, 200, 0, 25);
insert into cadastre.land_use_grade(land_use_code, land_grade_code, admin_fee, ground_rent_rate, duty_on_ground_rent, registration_fee) values('institutional', 'grade6', 100, 200, 0, 25);

