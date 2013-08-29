ALTER TABLE administrative.dispute ALTER COLUMN dispute_description SET DATA TYPE varchar(555);
ALTER TABLE administrative.dispute_historic ALTER COLUMN dispute_description SET DATA TYPE varchar(555);
INSERT INTO administrative.other_authorities(code, display_value, status, description) VALUES('laa', 'LAA', 'c',NULL);

UPDATE cadastre.land_use_grade
   SET ground_rent_rate='0.12'
 WHERE land_use_code = 'residential' and land_grade_code = 'grade6';
 
INSERT INTO cadastre.land_use_grade(
            land_use_code, land_grade_code, admin_fee, ground_rent_rate, 
            duty_on_ground_rent, registration_fee)
    VALUES ('recreational', 'grade3', '100', '200', 
            '0', '0');

INSERT INTO cadastre.land_use_grade(
            land_use_code, land_grade_code, admin_fee, ground_rent_rate, 
            duty_on_ground_rent, registration_fee)
    VALUES ('recreational', 'grade4', '100', '200', 
            '0', '0');
			
INSERT INTO cadastre.land_use_grade(
            land_use_code, land_grade_code, admin_fee, ground_rent_rate, 
            duty_on_ground_rent, registration_fee)
    VALUES ('recreational', 'grade5', '100', '200', 
            '0', '0');

INSERT INTO cadastre.land_use_grade(
            land_use_code, land_grade_code, admin_fee, ground_rent_rate, 
            duty_on_ground_rent, registration_fee)
    VALUES ('recreational', 'grade6', '100', '200', 
            '0', '0');

INSERT INTO cadastre.land_use_grade(
            land_use_code, land_grade_code, admin_fee, ground_rent_rate, 
            duty_on_ground_rent, registration_fee)
    VALUES ('charitable', 'grade2', '100', '200', 
            '0', '0');

INSERT INTO cadastre.land_use_grade(
            land_use_code, land_grade_code, admin_fee, ground_rent_rate, 
            duty_on_ground_rent, registration_fee)
    VALUES ('charitable', 'grade3', '100', '200', 
            '0', '0');

INSERT INTO cadastre.land_use_grade(
            land_use_code, land_grade_code, admin_fee, ground_rent_rate, 
            duty_on_ground_rent, registration_fee)
    VALUES ('charitable', 'grade4', '100', '200', 
            '0', '0');

INSERT INTO cadastre.land_use_grade(
            land_use_code, land_grade_code, admin_fee, ground_rent_rate, 
            duty_on_ground_rent, registration_fee)
    VALUES ('charitable', 'grade5', '100', '200', 
            '0', '0');

INSERT INTO cadastre.land_use_grade(
            land_use_code, land_grade_code, admin_fee, ground_rent_rate, 
            duty_on_ground_rent, registration_fee)
    VALUES ('charitable', 'grade6', '100', '200', 
            '0', '0');

INSERT INTO cadastre.land_use_grade(
            land_use_code, land_grade_code, admin_fee, ground_rent_rate, 
            duty_on_ground_rent, registration_fee)
    VALUES ('hospital', 'grade2', '100', '200', 
            '0', '0');

INSERT INTO cadastre.land_use_grade(
            land_use_code, land_grade_code, admin_fee, ground_rent_rate, 
            duty_on_ground_rent, registration_fee)
    VALUES ('hospital', 'grade3', '100', '200', 
            '0', '0');

INSERT INTO cadastre.land_use_grade(
            land_use_code, land_grade_code, admin_fee, ground_rent_rate, 
            duty_on_ground_rent, registration_fee)
    VALUES ('hospital', 'grade4', '100', '200', 
            '0', '0');


INSERT INTO cadastre.land_use_grade(
            land_use_code, land_grade_code, admin_fee, ground_rent_rate, 
            duty_on_ground_rent, registration_fee)
    VALUES ('hospital', 'grade5', '100', '200', 
            '0', '0');

INSERT INTO cadastre.land_use_grade(
            land_use_code, land_grade_code, admin_fee, ground_rent_rate, 
            duty_on_ground_rent, registration_fee)
    VALUES ('hospital', 'grade6', '100', '200', 
            '0', '0');

INSERT INTO cadastre.land_use_grade(
            land_use_code, land_grade_code, admin_fee, ground_rent_rate, 
            duty_on_ground_rent, registration_fee)
    VALUES ('educational', 'grade2', '100', '200', 
            '0', '0');

INSERT INTO cadastre.land_use_grade(
            land_use_code, land_grade_code, admin_fee, ground_rent_rate, 
            duty_on_ground_rent, registration_fee)
    VALUES ('educational', 'grade3', '100', '200', 
            '0', '0');

INSERT INTO cadastre.land_use_grade(
            land_use_code, land_grade_code, admin_fee, ground_rent_rate, 
            duty_on_ground_rent, registration_fee)
    VALUES ('educational', 'grade4', '100', '200', 
            '0', '0');

INSERT INTO cadastre.land_use_grade(
            land_use_code, land_grade_code, admin_fee, ground_rent_rate, 
            duty_on_ground_rent, registration_fee)
    VALUES ('educational', 'grade5', '100', '200', 
            '0', '0');

INSERT INTO cadastre.land_use_grade(
            land_use_code, land_grade_code, admin_fee, ground_rent_rate, 
            duty_on_ground_rent, registration_fee)
    VALUES ('educational', 'grade6', '100', '200', 
            '0', '0');

INSERT INTO cadastre.land_use_grade(
          land_use_code, land_grade_code, admin_fee, ground_rent_rate, 
            duty_on_ground_rent, registration_fee)
    VALUES ('religious', 'grade2', '100', '200', 
            '0', '0');

INSERT INTO cadastre.land_use_grade(
          land_use_code, land_grade_code, admin_fee, ground_rent_rate, 
            duty_on_ground_rent, registration_fee)
    VALUES ('religious', 'grade3', '100', '200', 
            '0', '0');

INSERT INTO cadastre.land_use_grade(
          land_use_code, land_grade_code, admin_fee, ground_rent_rate, 
            duty_on_ground_rent, registration_fee)
    VALUES ('religious', 'grade4', '100', '200', 
            '0', '0');

INSERT INTO cadastre.land_use_grade(
          land_use_code, land_grade_code, admin_fee, ground_rent_rate, 
            duty_on_ground_rent, registration_fee)
    VALUES ('religious', 'grade5', '100', '200', 
            '0', '0');

INSERT INTO cadastre.land_use_grade(
          land_use_code, land_grade_code, admin_fee, ground_rent_rate, 
            duty_on_ground_rent, registration_fee)
    VALUES ('religious', 'grade6', '100', '200', 
            '0', '0');	

INSERT INTO cadastre.land_use_grade(
          land_use_code, land_grade_code, admin_fee, ground_rent_rate, 
            duty_on_ground_rent, registration_fee)
    VALUES ('devotional', 'grade1', '100', '200', 
            '0', '0');
			
INSERT INTO cadastre.land_use_grade(
          land_use_code, land_grade_code, admin_fee, ground_rent_rate, 
            duty_on_ground_rent, registration_fee)
    VALUES ('devotional', 'grade2', '100', '200', 
            '0', '0');

INSERT INTO cadastre.land_use_grade(
          land_use_code, land_grade_code, admin_fee, ground_rent_rate, 
            duty_on_ground_rent, registration_fee)
    VALUES ('devotional', 'grade3', '100', '200', 
            '0', '0');

INSERT INTO cadastre.land_use_grade(
          land_use_code, land_grade_code, admin_fee, ground_rent_rate, 
            duty_on_ground_rent, registration_fee)
    VALUES ('devotional', 'grade4', '100', '200', 
            '0', '0');

INSERT INTO cadastre.land_use_grade(
          land_use_code, land_grade_code, admin_fee, ground_rent_rate, 
            duty_on_ground_rent, registration_fee)
    VALUES ('devotional', 'grade5', '100', '200', 
            '0', '0');

INSERT INTO cadastre.land_use_grade(
          land_use_code, land_grade_code, admin_fee, ground_rent_rate, 
            duty_on_ground_rent, registration_fee)
    VALUES ('devotional', 'grade6', '100', '200', 
            '0', '0');

INSERT INTO cadastre.land_use_grade(
          land_use_code, land_grade_code, admin_fee, ground_rent_rate, 
            duty_on_ground_rent, registration_fee)
    VALUES ('benovelent', 'grade1', '100', '200', 
            '0', '0');
			
INSERT INTO cadastre.land_use_grade(
          land_use_code, land_grade_code, admin_fee, ground_rent_rate, 
            duty_on_ground_rent, registration_fee)
    VALUES ('benovelent', 'grade2', '100', '200', 
            '0', '0');

INSERT INTO cadastre.land_use_grade(
          land_use_code, land_grade_code, admin_fee, ground_rent_rate, 
            duty_on_ground_rent, registration_fee)
    VALUES ('benovelent', 'grade3', '100', '200', 
            '0', '0');

INSERT INTO cadastre.land_use_grade(
          land_use_code, land_grade_code, admin_fee, ground_rent_rate, 
            duty_on_ground_rent, registration_fee)
    VALUES ('benovelent', 'grade4', '100', '200', 
            '0', '0');

INSERT INTO cadastre.land_use_grade(
          land_use_code, land_grade_code, admin_fee, ground_rent_rate, 
            duty_on_ground_rent, registration_fee)
    VALUES ('benovelent', 'grade5', '100', '200', 
            '0', '0');

INSERT INTO cadastre.land_use_grade(
          land_use_code, land_grade_code, admin_fee, ground_rent_rate, 
            duty_on_ground_rent, registration_fee)
    VALUES ('benovelent', 'grade6', '100', '200', 
            '0', '0');	
			
INSERT INTO cadastre.land_use_grade(
          land_use_code, land_grade_code, admin_fee, ground_rent_rate, 
            duty_on_ground_rent, registration_fee)
    VALUES ('commercial', 'grade5', '100', '0.24', 
            '10', '100');
			
INSERT INTO cadastre.land_use_grade(
          land_use_code, land_grade_code, admin_fee, ground_rent_rate, 
            duty_on_ground_rent, registration_fee)
    VALUES ('commercial', 'grade6', '100', '0.24', 
            '10', '100');

INSERT INTO cadastre.land_use_grade(
          land_use_code, land_grade_code, admin_fee, ground_rent_rate, 
            duty_on_ground_rent, registration_fee)
    VALUES ('hotel', 'grade4', '100', '0.23', 
            '0', '100');
            
INSERT INTO cadastre.land_use_grade(
          land_use_code, land_grade_code, admin_fee, ground_rent_rate, 
            duty_on_ground_rent, registration_fee)
    VALUES ('hotel', 'grade5', '100', '0.23', 
            '0', '100');

INSERT INTO cadastre.land_use_grade(
          land_use_code, land_grade_code, admin_fee, ground_rent_rate, 
            duty_on_ground_rent, registration_fee)
    VALUES ('hotel', 'grade6', '100', '0.23', 
            '0', '100');

INSERT INTO cadastre.land_use_grade(
          land_use_code, land_grade_code, admin_fee, ground_rent_rate, 
            duty_on_ground_rent, registration_fee)
    VALUES ('industrial', 'grade4', '100', '0.23', 
            '0', '100');
            
INSERT INTO cadastre.land_use_grade(
          land_use_code, land_grade_code, admin_fee, ground_rent_rate, 
            duty_on_ground_rent, registration_fee)
    VALUES ('industrial', 'grade5', '100', '0.23', 
            '0', '100');

INSERT INTO cadastre.land_use_grade(
          land_use_code, land_grade_code, admin_fee, ground_rent_rate, 
            duty_on_ground_rent, registration_fee)
    VALUES ('industrial', 'grade6', '100', '0.23', 
            '0', '100');

INSERT INTO cadastre.land_use_grade(
          land_use_code, land_grade_code, admin_fee, ground_rent_rate, 
            duty_on_ground_rent, registration_fee)
    VALUES ('petroleum', 'grade4', '100', '0.23', 
            '0', '100');
            
INSERT INTO cadastre.land_use_grade(
          land_use_code, land_grade_code, admin_fee, ground_rent_rate, 
            duty_on_ground_rent, registration_fee)
    VALUES ('petroleum', 'grade5', '100', '0.23', 
            '0', '100');

INSERT INTO cadastre.land_use_grade(
          land_use_code, land_grade_code, admin_fee, ground_rent_rate, 
            duty_on_ground_rent, registration_fee)
    VALUES ('petroleum', 'grade6', '100', '0.23', 
            '0', '100');

INSERT INTO cadastre.land_use_grade(
          land_use_code, land_grade_code, admin_fee, ground_rent_rate, 
            duty_on_ground_rent, registration_fee)
    VALUES ('retail', 'grade4', '100', '0.23', 
            '0', '100');
            
INSERT INTO cadastre.land_use_grade(
          land_use_code, land_grade_code, admin_fee, ground_rent_rate, 
            duty_on_ground_rent, registration_fee)
    VALUES ('retail', 'grade5', '100', '0.23', 
            '0', '100');

INSERT INTO cadastre.land_use_grade(
          land_use_code, land_grade_code, admin_fee, ground_rent_rate, 
            duty_on_ground_rent, registration_fee)
    VALUES ('retail', 'grade6', '100', '0.23', 
            '0', '100');

INSERT INTO cadastre.land_use_grade(
          land_use_code, land_grade_code, admin_fee, ground_rent_rate, 
            duty_on_ground_rent, registration_fee)
    VALUES ('warehouse', 'grade4', '100', '0.23', 
            '0', '100');
            
INSERT INTO cadastre.land_use_grade(
          land_use_code, land_grade_code, admin_fee, ground_rent_rate, 
            duty_on_ground_rent, registration_fee)
    VALUES ('warehouse', 'grade5', '100', '0.23', 
            '0', '100');

INSERT INTO cadastre.land_use_grade(
          land_use_code, land_grade_code, admin_fee, ground_rent_rate, 
            duty_on_ground_rent, registration_fee)
    VALUES ('warehouse', 'grade6', '100', '0.23', 
            '0', '100');			