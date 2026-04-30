/*
Extraire les données de réservation dans le cadre d’une demande
d’export personnalisé client.

Le script regroupe les informations récupérées dans 4 table :

réservation
conducteur
véhicule
station

*/

SELECT
res.ReservationId,

-- Informations conducteur
dri.LastName,
dri.FirstName,

-- Informations véhicule
vhl.Name AS VehicleName,
vhl.LicencePlate,

-- Station de rattachement
sta.Name AS StationName,

-- Dates de réservation
res.ReservationStartDate,
res.ReservationEndDate,
res.UsageStartDate,
res.UsageEndDate,

-- Kilométrage
res.StartVehicleKm AS KmStart,
res.EndVehicleKm AS KmEnd,
res.InvoicedKm AS KmDriven,

-- Carburant
res.StartFuelLevel AS FuelLevelStart,
res.EndFuelLevel AS FuelLevelEnd,

-- Indicateur de gratuité
CASE 
    WHEN res.IsFree = 0 THEN 'non'
    ELSE 'oui'
END AS IsFreeReservation

FROM Reservation res

LEFT JOIN Driver dri
ON dri.DriverId = res.DriverId

LEFT JOIN Vehicle vhl
ON vhl.VehicleId = res.VehicleId

LEFT JOIN Station sta
ON sta.StationId = res.StationId

/*
Filtres :

Période de réservation
Contrat spécifique

*/

WHERE res.ReservationStartDate >= '2024-07-01'
AND res.ReservationEndDate <= '2024-09-15'
AND res.ContractId = 49791;
