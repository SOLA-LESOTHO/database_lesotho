@echo off

set psql_path=%~dp0
set psql_path="%psql_path%psql\psql.exe"
set host=localhost
set port=5432
set dbname=sola

set username=postgres
REM set password=?
set archive_password=?

set createDB=NO

set testDataPath=test-data\lesotho\


set /p host= Host name [%host%] :

set /p port= Port [%port%] :

set /p dbname= Database name [%dbname%] :

set /p username= Username [%username%] :

REM The Database password should be set using PgAdmin III. When connecting to the database, 
REM choose the Store Password option. This will avoid a password prompt for every SQL file 
REM that is loaded. 
REM set /p password= DB Password [%password%] :

REM set /p archive_password= Test Data Archive Password [%archive_password%] :

echo
echo
echo Starting Build at %time%
echo Starting Build at %time% >> build.log 2>&1

echo Creating database...
echo Creating database... >> build.log 2>&1
%psql_path% --host=%host% --port=%port% --username=%username% --dbname=%dbname% --file=sola.sql > build.log 2>&1
%psql_path% --host=%host% --port=%port% --username=%username% --dbname=%dbname% --file=test_data.sql >> build.log 2>&1

echo Loading business rules...
echo Loading SOLA business rules... >> build.log 2>&1
%psql_path% --host=%host% --port=%port% --username=%username% --dbname=%dbname% --file=business_rules.sql >> build.log 2>&1
%psql_path% --host=%host% --port=%port% --username=%username% --dbname=%dbname% --file=br_generators.sql >> build.log 2>&1
%psql_path% --host=%host% --port=%port% --username=%username% --dbname=%dbname% --file=br_target_application.sql >> build.log 2>&1
%psql_path% --host=%host% --port=%port% --username=%username% --dbname=%dbname% --file=br_target_service.sql >> build.log 2>&1
%psql_path% --host=%host% --port=%port% --username=%username% --dbname=%dbname% --file=br_target_ba_unit.sql >> build.log 2>&1
%psql_path% --host=%host% --port=%port% --username=%username% --dbname=%dbname% --file=br_target_cadastre_object.sql >> build.log 2>&1
%psql_path% --host=%host% --port=%port% --username=%username% --dbname=%dbname% --file=br_target_rrr.sql >> build.log 2>&1
%psql_path% --host=%host% --port=%port% --username=%username% --dbname=%dbname% --file=br_target_source.sql >> build.log 2>&1
%psql_path% --host=%host% --port=%port% --username=%username% --dbname=%dbname% --file=br_target_bulkoperation.sql >> build.log 2>&1

echo Loading Lesotho Extensions...
echo Loading Lesotho Extensions... >> build.log 2>&1
echo Loading Lesotho Business Rules... >> build.log 2>&1
%psql_path% --host=%host% --port=%port% --username=%username% --dbname=%dbname% --file=extension\lesotho_business_rules.sql >> build.log 2>&1

echo Loading Reference Data... >> build.log 2>&1
%psql_path% --host=%host% --port=%port% --username=%username% --dbname=%dbname% --file=extension\lesotho_reference_data.sql >> build.log 2>&1

echo Loading Users and Roles... >> build.log 2>&1
%psql_path% --host=%host% --port=%port% --username=%username% --dbname=%dbname% --file=extension\lesotho_users_roles.sql >> build.log 2>&1


REM  Loading laa spatial data section

echo Loading spatial data...
REM  echo Loading spatial data... >> build.log 2>&1
REM  %psql_path% --host=%host% --port=%port% --username=%username% --dbname=%dbname% --file=..\laa_data\interim_data.sql >> build.log 2>&1

echo Loading spatial config... >> build.log 2>&1
%psql_path% --host=%host% --port=%port% --username=%username% --dbname=%dbname% --file=extension\lesotho_spatial_config.sql >> build.log 2>&1

echo Loading Maseru Parcels ... >> build.log 2>&1
%psql_path% --host=%host% --port=%port% --username=%username% --dbname=%dbname% --file=migration\sola_populate_maseru_parcels.sql >> build.log 2>&1

echo Loading Lesotho Grids... >> build.log 2>&1
%psql_path% --host=%host% --port=%port% --username=%username% --dbname=%dbname% --file=migration\sola_populate_cadastral_grid.sql >> build.log 2>&1

echo Loading roads and zones data... >> build.log 2>&1
%psql_path% --host=%host% --port=%port% --username=%username% --dbname=%dbname% --file=migration\sola_populate_laa_shapefiles.sql >> build.log 2>&1

echo Parcel numbering >> build.log 2>&1
%psql_path% --host=%host% --port=%port% --username=%username% --dbname=%dbname% --file=extension\trigger_new_cadastre_object.sql >> build.log 2>&1

echo Renaming Zones >> build.log 2>&1
%psql_path% --host=%host% --port=%port% --username=%username% --dbname=%dbname% --file=migration\update_spatial_unit_zones.sql >> build.log 2>&1

echo Updating Ground Rent Zones >> build.log 2>&1
%psql_path% --host=%host% --port=%port% --username=%username% --dbname=%dbname% --file=extension\ground_rent_zones.sql >> build.log 2>&1

echo Updating Road Classes >> build.log 2>&1
%psql_path% --host=%host% --port=%port% --username=%username% --dbname=%dbname% --file=extension\road_class.sql >> build.log 2>&1

echo end of loading laa spatial data section

echo migrating lease data

echo loading property....
echo loading property >> build.log 2>&1
%psql_path% --host=%host% --port=%port% --username=%username% --dbname=%dbname% --file=migration\interimLease\1interim_lease_migration_property.sql >> build.log 2>&1

echo loading transfer....
echo loading transfer >> build.log 2>&1
%psql_path% --host=%host% --port=%port% --username=%username% --dbname=%dbname% --file=migration\interimLease\2interim_lease_migration_transfer.sql >> build.log 2>&1

echo loading mortgages.....
echo loading mortgages >> build.log 2>&1
%psql_path% --host=%host% --port=%port% --username=%username% --dbname=%dbname% --file=migration\interimLease\3interim_lease_migration_mortgage.sql >> build.log 2>&1

echo loading lease variation.....
echo loading variations >> build.log 2>&1
%psql_path% --host=%host% --port=%port% --username=%username% --dbname=%dbname% --file=migration\interimLease\4interim_lease_migration_variation.sql >> build.log 2>&1

echo loading subleases.....
echo loading subleases >> build.log 2>&1
%psql_path% --host=%host% --port=%port% --username=%username% --dbname=%dbname% --file=migration\interimLease\5interim_lease_migration_sublease.sql >> build.log 2>&1

echo loading surrender.....
echo loading surrendered titles >> build.log 2>&1
%psql_path% --host=%host% --port=%port% --username=%username% --dbname=%dbname% --file=migration\interimLease\6interim_lease_migration_surrender.sql >> build.log 2>&1

echo Finished at %time% - Check build.log for errors!
echo Finished at %time% >> build.log 2>&1
pause
