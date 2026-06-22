
---filtrer les comptes qui ont enregistré leur numéro moibile dans le colonne "numéro fixe"

select*from Communication c
left join customer cus on cus.customerid = c.customerid
left join Contract con on con.ContractId = cus.ContractId
left join Driver d on d.DriverId = cus.driverid
where cus.ProviderId = 18 and con.Type = 1
and (c.HomePhoneNumber like '+33[67]%' 
or c.HomePhoneNumber like '0[67]%')
and (c.MobilePhoneNumber is null or c.MobilePhoneNumber = '')


---Une fois trouvé, ouvrir une transaction pour lancer l'update => passer ces numéro de la colonne fixe à la colonne mobile

begin transaction

update c set c.MobilePhoneNumber = c.HomePhoneNumber
from Communication c
left join customer cus on cus.customerid = c.customerid
left join Contract con on con.ContractId = cus.ContractId
left join Driver d on d.DriverId = cus.driverid
where cus.ProviderId = 5
and con.Type = 1
and (c.HomePhoneNumber like '+33[67]%'  
or c.HomePhoneNumber like '0[67]%')
and (c.MobilePhoneNumber is null or c.MobilePhoneNumber = '')


commit

rollback
