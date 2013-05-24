--Load rrr share

INSERT INTO administrative.rrr_share(
id,
rrr_id,  
nominator, 
denominator,  
rowversion, 
change_action,
change_user)
SELECT
p.id, --exact match with party id
r.id, 
1,
1,
1,
'i',
'test-id'
FROM lesotho_etl.entity_plots e
inner join party.party p
on e.id = p.id
inner join administrative.ba_unit b --link plot number with property 
on e.plot_number = b.name
inner join administrative.rrr r -- link property with rrr
on r.ba_unit_id = b.id
where e.transaction_type = 'lease';


with shares as
(
select count(rrr_id) as denominator, rrr_id from administrative.rrr_share as rrr_id
group by rrr_id
having count(rrr_id) > 1
)
insert into lesotho_etl.myshare
select s.rrr_id, s.denominator
from shares s;

SELECT lesotho_etl.update_shares();