UPDATE system.config_map_layer
SET style = 'grid.xml'
WHERE name = 'grid';

UPDATE system.config_map_layer
SET item_order = 100
WHERE name = 'grid';

UPDATE system.config_map_layer
SET item_order = 2
WHERE name = 'zones'