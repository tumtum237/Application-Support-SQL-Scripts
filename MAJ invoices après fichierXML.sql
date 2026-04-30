/* Ce script permet de marquer comme payées les factures incluses
dans un fichier de prélèvement SEPA XML déjà transmis à la banque

Pour chaque facture concernée :

Création d’un enregistrement de paiement
Mise à jour du statut de la facture => soldée

Paramètres

*/

DECLARE @ProviderId INT = XXX; -- ID de l'opérateur
DECLARE @InvoicingPeriodId INT = XXX; -- ID de la période de facturation

/*
Création des paiements

On insère un paiement pour chaque facture :

de type SEPA (PaymentType = 4)
avec un montant restant à payer > 0

Le montant du paiement correspond au solde restant :
(InvoicedAmount - PaidAmount)
*/

INSERT INTO Payment (
PaymentType,
InvoiceId,
Amount,
CreationDate,
ExportedToAccountingSystem,
ImportedFromAccountingSystem,
ProviderId,
Status,
FromDeposit
)
SELECT
4, -- Paiement SEPA
InvoiceId,
(InvoicedAmount - PaidAmount),
GETDATE(),
0,
0,
@ProviderId,
1, -- Paiement validé
0
FROM Invoice
WHERE ProviderId = @ProviderId
AND InvoicingPeriodId = @InvoicingPeriodId
AND PaymentType = 4
AND InvoicedAmount > 0
AND (InvoicedAmount - PaidAmount) > 0;

/*


On met à jour les factures concernées :

le montant payé est ajusté
le statut passe à "payée"

*/

UPDATE Invoice
SET
PaidAmount = InvoicedAmount,
PaymentStatus = 1 -- Facture soldée
WHERE InvoiceId IN (
SELECT InvoiceId
FROM Invoice
WHERE ProviderId = @ProviderId
AND InvoicingPeriodId = @InvoicingPeriodId
AND PaymentType = 4
);
