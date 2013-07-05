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
echo Loading Reference Data... >> build.log 2>&1
%psql_path% --host=%host% --port=%port% --username=%username% --dbname=%dbname% --file=extension\lesotho_reference_data.sql >> build.log 2>&1
echo Loading Lesotho Business Rules... >> build.log 2>&1
%psql_path% --host=%host% --port=%port% --username=%username% --dbname=%dbname% --file=extension\lesotho_business_rules.sql >> build.log 2>&1
echo Loading documents required per service >> build.log 2>&1
%psql_path% --host=%host% --port=%port% --username=%username% --dbname=%dbname% --file=extension\InsertDocumentsPerService.sql >> build.log 2>&1

REM Loading Users and Roles
echo Loading Users and Roles... >> build.log 2>&1
%psql_path% --host=%host% --port=%port% --username=%username% --dbname=%dbname% --file=extension\lesotho_users_roles.sql >> build.log 2>&1
echo Loading Lodging Agents... >> build.log 2>&1
%psql_path% --host=%host% --port=%port% --username=%username% --dbname=%dbname% --file=extension\lesotho_agents.sql >> build.log 2>&1


REM  Loading laa spatial data section

echo Loading spatial data...
REM  echo Loading spatial data... >> build.log 2>&1
REM  %psql_path% --host=%host% --port=%port% --username=%username% --dbname=%dbname% --file=..\laa_data\interim_data.sql >> build.log 2>&1

echo Loading spatial config... >> build.log 2>&1
%psql_path% --host=%host% --port=%port% --username=%username% --dbname=%dbname% --file=extension\lesotho_spatial_config.sql >> build.log 2>&1

echo Loading Lesotho map layer... >> build.log 2>&1
%psql_path% --host=%host% --port=%port% --username=%username% --dbname=%dbname% --file=extension\config_map_layer_lesotho.sql >> build.log 2>&1

echo Loading Maseru Parcels ... >> build.log 2>&1
%psql_path% --host=%host% --port=%port% --username=%username% --dbname=%dbname% --file=migration\sola_populate_maseru_parcels.sql >> build.log 2>&1

echo Loading Lesotho Grids... >> build.log 2>&1
%psql_path% --host=%host% --port=%port% --username=%username% --dbname=%dbname% --file=migration\sola_populate_cadastral_grid.sql >> build.log 2>&1

echo Loading roads and zones data... >> build.log 2>&1
%psql_path% --host=%host% --port=%port% --username=%username% --dbname=%dbname% --file=migration\sola_populate_laa_shapefiles.sql >> build.log 2>&1

rem -- echo Parcel numbering trigger >> build.log 2>&1
rem -- %psql_path% --host=%host% --port=%port% --username=%username% --dbname=%dbname% --file=extension\system_query_localised_parcel_numbering.sql >> build.log 2>&1

echo Parcel numbering >> build.log 2>&1
%psql_path% --host=%host% --port=%port% --username=%username% --dbname=%dbname% --file=extension\trigger_new_cadastre_object.sql >> build.log 2>&1

echo Renaming Zones >> build.log 2>&1
%psql_path% --host=%host% --port=%port% --username=%username% --dbname=%dbname% --file=migration\update_spatial_unit_zones.sql >> build.log 2>&1

echo Updating Layer Precedence >> build.log 2>&1
%psql_path% --host=%host% --port=%port% --username=%username% --dbname=%dbname% --file=migration\system_config_layer_precedence.sql >> build.log 2>&1

REM end of loading laa spatial data section




REM loading lease data section

echo Loading lease and deeds documents
echo Loading lease and deeds documents >> build.log 2>&1
%psql_path% --host=%host% --port=%port% --username=%username% --dbname=%dbname% --file=..\laa_data\document.sql >> build.log 2>&1

REM echo Creating temporary schema and tables...
REM echo Creating temporary schema and tables... >> build.log 2>&1
REM %psql_path% --host=%host% --port=%port% --username=%username% --dbname=%dbname% --file=migration\interimLease\interim_lease.sql >> build.log 2>&1

REM echo Loading access Lease Data...
REM echo Loading access Lease Data... >> build.log 2>&1
REM %psql_path% --host=%host% --port=%port% --username=%username% --dbname=%dbname% --file=..\laa_data\lease.sql >> build.log 2>&1

REM echo Loading access Lease Transaction Data...
REM echo Loading access Lease Transaction Data... >> build.log 2>&1
REM %psql_path% --host=%host% --port=%port% --username=%username% --dbname=%dbname% --file=..\laa_data\lease_transaction.sql >> build.log 2>&1
REM %psql_path% --host=%host% --port=%port% --username=%username% --dbname=%dbname% --file=migration\registration_services.sql >> build.log 2>&1

REM echo Preprocessing of data...
REM echo Preprocessing of data.... >> build.log 2>&1
REM %psql_path% --host=%host% --port=%port% --username=%username% --dbname=%dbname% --file=migration\interimLease\interim_lease_data_fixes.sql >> build.log 2>&1

echo Loading parties...
echo Loading parties... >> build.log 2>&1
%psql_path% --host=%host% --port=%port% --username=%username% --dbname=%dbname% --file=migration\interimLease\interim_lease_parties.sql >> build.log 2>&1

echo Loading plots..
echo Loading plots.. >> build.log 2>&1
%psql_path% --host=%host% --port=%port% --username=%username% --dbname=%dbname% --file=migration\interimLease\interim_lease_plots.sql >> build.log 2>&1

echo Craeting cadastre_object views and user with read-only rights...
echo Craeting cadastre_object views and user with read-only rights... >> build.log 2>&1
%psql_path% --host=%host% --port=%port% --username=%username% --dbname=%dbname% --file=extension\cadastre_object_views.sql >> build.log 2>&1

echo Loading property...
echo Loading property... >> build.log 2>&1
%psql_path% --host=%host% --port=%port% --username=%username% --dbname=%dbname% --file=migration\interimLease\interim_lease_property.sql >> build.log 2>&1

echo Loading rrr...
echo Loading rrr... >> build.log 2>&1
%psql_path% --host=%host% --port=%port% --username=%username% --dbname=%dbname% --file=migration\interimLease\interim_lease_rrr.sql >> build.log 2>&1

echo Loading rrr share...
echo Loading rrr share... >> build.log 2>&1
%psql_path% --host=%host% --port=%port% --username=%username% --dbname=%dbname% --file=migration\interimLease\interim_lease_rrr_share.sql >> build.log 2>&1

echo loading party for rrr...
echo loading party for rrr... >> build.log 2>&1
%psql_path% --host=%host% --port=%port% --username=%username% --dbname=%dbname% --file=migration\interimLease\interim_lease_party_for_rrr.sql >> build.log 2>&1

echo loading transactions against a lease...
echo loading transactions against a lease... >> build.log 2>&1
%psql_path% --host=%host% --port=%port% --username=%username% --dbname=%dbname% --file=migration\interimLease\interim_lease_transaction_against_lease.sql >> build.log 2>&1


echo HOUSE KEEPING... >> build.log 2>&1
REM %psql_path% --host=%host% --port=%port% --username=%username% --dbname=%dbname% --file=house_keeper.sql >> build.log 2>&1


REM 
echo Finished at %time% - Check build.log for errors!
echo Finished at %time% >> build.log 2>&1
pause