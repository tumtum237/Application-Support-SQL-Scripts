  -----group by et having-----
  select count(reservationid) as 'total',ContractId from Reservation
  where VehicleProviderId = 7
  group by ContractId
  having count(reservationid) >= 7


  select sum (invoicedkm), max(invoicedkm), min(invoicedkm), count(reservationid), contractid from reservation 
  where VehicleProviderId = 7
  group by contractid --VehicleId 
  having min(invoicedkm) <= 0

  -----le with ----
with contratTotalResaplusde7 as (
	select count(reservationid) as 'totalResa',contractid from reservation 
	where VehicleProviderId = 7
	group by ContractId
	having count(reservationid) >= 7
)
select r.ReservationId,r.InvoicedKm,r.ReservationStartDate from reservation r
left join contratTotalResaplusde7 cta on cta.ContractId = r.ContractId
where cta.ContractId >= 10000 and cta.totalResa < 10 


----le not exists------
SELECT r.ReservationId
FROM Reservation r
WHERE NOT EXISTS (
    SELECT 1
    FROM ReservationEvent e
    WHERE e.ReservationId = r.ReservationId
);
