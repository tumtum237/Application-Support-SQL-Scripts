
----utiliser la fonction month ou year pour cibler le mois ou l'année en cours sur la date de ses résultat
select count(ReservationId), DriverId, sum(InvoicedKm) as 'montant total', avg(InvoicedKm) as 'montant moyen' from Reservation 
  where state < 5 and Month(CreationDate) = MONTH(getdate()) --- month(la colonne en type date) = month(getdate()) pour cibler tout le mois en cours, ça peut être year pour l'année en cours
group by DriverId
having count(ReservationId) > 5
