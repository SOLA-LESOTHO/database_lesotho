SELECT party_id FROM party.party_role
WHERE type_code = 'certifiedSurveyor';

-- INSERT SURVEYORS --
DELETE FROM party.party_role
WHERE type_code = 'certifiedSurveyor';
--

INSERT INTO party.party (id, type_code, name, last_name)
VALUES(uuid_generate_v1(), 'naturalPerson', 'N.V.', 'KUENANE');

INSERT INTO party.party_role (party_id, type_code)
VALUES(	(SELECT id FROM party.party WHERE name = 'N.V.' AND last_name = 'KUENANE' LIMIT 1), 'certifiedSurveyor');
--
INSERT INTO party.party (id, type_code, name, last_name)
VALUES(uuid_generate_v1(), 'naturalPerson', 'L.F.', 'LESENYEHO');

INSERT INTO party.party_role (party_id, type_code)
VALUES( (SELECT id FROM party.party WHERE name = 'L.F.' AND last_name = 'LESENYEHO' LIMIT 1), 'certifiedSurveyor');
--
INSERT INTO party.party (id, type_code, name, last_name)
VALUES(uuid_generate_v1(), 'naturalPerson', 'T.', 'MALEKA');

INSERT INTO party.party_role (party_id, type_code)
VALUES(	(SELECT id FROM party.party WHERE name = 'T.' AND last_name = 'MALEKA' LIMIT 1), 'certifiedSurveyor');
--
INSERT INTO party.party (id, type_code, name, last_name)
VALUES(uuid_generate_v1(), 'naturalPerson', 'M.T.', 'NTSIHLELE');

INSERT INTO party.party_role (party_id, type_code)
VALUES( (SELECT id FROM party.party WHERE name = 'M.T.' AND last_name = 'NTSIHLELE' LIMIT 1), 'certifiedSurveyor');
--
INSERT INTO party.party (id, type_code, name, last_name)
VALUES(uuid_generate_v1(), 'naturalPerson', 'S.', 'PUTSOA');

INSERT INTO party.party_role (party_id, type_code)
VALUES( (SELECT id FROM party.party WHERE name = 'S.' AND last_name = 'PUTSOA' LIMIT 1), 'certifiedSurveyor');
--

INSERT INTO party.party (id, type_code, name, last_name) 
VALUES(uuid_generate_v1(), 'naturalPerson', 'L.F.', 'SENATSI');

INSERT INTO party.party_role (party_id, type_code)
VALUES( (SELECT id FROM party.party WHERE name = 'L.F.' AND last_name = 'SENATSI' LIMIT 1), 'certifiedSurveyor');
--

INSERT INTO party.party (id, type_code, name, last_name)
VALUES(uuid_generate_v1(), 'naturalPerson', 'S.', 'MOSISILI');

INSERT INTO party.party_role  (party_id, type_code)
VALUES( (SELECT id FROM party.party WHERE name = 'S.' AND last_name = 'MOSISILI' LIMIT 1), 'certifiedSurveyor');
--

INSERT INTO party.party (id, type_code, name, last_name)
VALUES(uuid_generate_v1(), 'naturalPerson', 'A.', 'MOSAASE');

INSERT INTO party.party_role (party_id, type_code)
VALUES( (SELECT id FROM party.party WHERE name = 'A.' AND last_name = 'MOSAASE' LIMIT 1), 'certifiedSurveyor');
--

INSERT INTO party.party (id, type_code, name, last_name)
VALUES(uuid_generate_v1(), 'naturalPerson', 'R.S.', 'MALATALIANA');

INSERT INTO party.party_role (party_id, type_code)
VALUES( (SELECT id FROM party.party WHERE name = 'R.S.' AND last_name = 'MALATALIANA' LIMIT 1), 'certifiedSurveyor');
--

INSERT INTO party.party (id, type_code, name, last_name)
VALUES(uuid_generate_v1(), 'naturalPerson', 'T.', 'MATSOSO');

INSERT INTO party.party_role (party_id, type_code)
VALUES( (SELECT id FROM party.party WHERE name = 'T.' AND last_name = 'MATSOSO' LIMIT 1), 'certifiedSurveyor');
--

INSERT INTO party.party (id, type_code, name, last_name)
VALUES(uuid_generate_v1(), 'naturalPerson', 'I.O.', 'EDEM');

INSERT INTO party.party_role (party_id, type_code)
VALUES( (SELECT id FROM party.party WHERE name = 'I.O.' AND last_name = 'EDEM' LIMIT 1), 'certifiedSurveyor');
--

INSERT INTO party.party (id, type_code, name, last_name)
VALUES(uuid_generate_v1(), 'naturalPerson', 'SENTLE', 'MOJELA');

INSERT INTO party.party_role (party_id, type_code)
VALUES( (SELECT id FROM party.party WHERE name = 'SENTLE' AND last_name = 'MOJELA' LIMIT 1), 'certifiedSurveyor');
--