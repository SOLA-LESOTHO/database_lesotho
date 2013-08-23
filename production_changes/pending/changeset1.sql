-- Production SQL Script 23-Aug-2013
UPDATE application.request_type SET nr_days_to_complete = 21 WHERE nr_days_to_complete <> 5;

