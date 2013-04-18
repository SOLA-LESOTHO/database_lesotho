--create layer for lesotho orthophoto (Maseru)
-- Data for Name: config_map_layer; Type: TABLE DATA; Schema: system; Owner: postgres

delete from system.config_map_layer where name='ls_orthophoto';

INSERT INTO system.config_map_layer VALUES ('ls_orthophoto', 'LS Orthophoto', 'wms', TRUE, TRUE, 1, NULL, 'http://localhost:14922/geoserver/sola/wms', 'sola:ls_orthophoto', '1.1.1', 'image/tiff', NULL, NULL, NULL, NULL, NULL, NULL, FALSE);

