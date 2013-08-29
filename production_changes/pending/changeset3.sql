ALTER TABLE administrative.dispute ALTER COLUMN dispute_description SET DATA TYPE varchar(555);
ALTER TABLE administrative.dispute_historic ALTER COLUMN dispute_description SET DATA TYPE varchar(555);
INSERT INTO administrative.other_authorities(code, display_value, status, description) VALUES('laa', 'LAA', 'c',NULL);