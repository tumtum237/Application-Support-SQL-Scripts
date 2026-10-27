-- Récupérer les clients inscrits au cours des 4 derniers mois
-- dont le contrat possède au moins 10 réservations :
--   - effectuées auprès du fournisseur de véhicules 1
--   - créées il y a au moins 1000 jours
-- Calculer également le total des kilomètres facturés par contrat.

WITH filtreContrat AS (
    SELECT
        COUNT(ReservationId) AS 'no total resa',       -- Nombre de réservations par contrat
        ContractId,                                    -- Identifiant du contrat
        SUM(InvoicedKm) AS 'km total par contrat'       -- Total des kilomètres facturés

    FROM Reservation
    WHERE VehicleProviderId = 1                        -- Réservations du fournisseur 1 uniquement
      AND CreationDate <= DATEADD(DAY, -1000, GETDATE()) -- Réservations créées il y a au moins 1000 jours

    GROUP BY ContractId                                -- Regroupement des réservations par contrat
    HAVING COUNT(ReservationId) >= 10                  -- Contrats ayant au moins 10 réservations correspondantes
)

SELECT
    c.FullName,                                        -- Nom complet du client
    c.CustomerId,                                      -- Identifiant du client
    c.SubscriptionDate                                  -- Date d'inscription du client

FROM Customer c
JOIN filtreContrat fc
    ON fc.ContractId = c.ContractId                    -- Association du client à son contrat

WHERE c.SubscriptionDate >= DATEADD(MONTH, -4, GETDATE()) -- Clients inscrits au cours des 4 derniers mois
