--assurance avec correspondance
select cig.*, insu1.Name, insu1.providerid,  insu2.ProviderId  from CrossInsuranceGrid cig
inner join Insurance insu1 on insu1.InsuranceId = cig.InsuranceId 
inner join Insurance insu2 on insu2.InsuranceId = cig.DestinationInsuranceId
order by insu1.ProviderId , insu1.Name,  insu2.ProviderId 

--assurance sans correspondance
select insu.* from Insurance insu
left join CrossInsuranceGrid cig on cig.InsuranceId = insu.InsuranceId 
where cig.CrossInsuranceGridId is null

--Assurance Avec Rachat partiel de franchise (Jeune Conducteur)	22	=>Assurance Avec Rachat partiel de franchise (0.56)
--Assurance Avec Rachat partiel de franchise (Pro)	22 => Assurance Avec Rachat partiel de franchise (0.28)
--Malus Sinistre	18 => Malus Sinistre (0.28)
--Assurance Pro avec rachat partiel de franchise	19 => Assurance Avec Rachat partiel de franchise (0.28)

DECLARE @MyCursor CURSOR;
DECLARE @MyCursor2 CURSOR;

DECLARE @ProviderId integer 
DECLARE @InsuranceId integer 
DECLARE @InsuranceName nvarchar(128)

BEGIN

	SET @MyCursor = CURSOR FOR
	SELECT ProviderId FROM Provider 
    OPEN @MyCursor 
    FETCH NEXT FROM @MyCursor 
    INTO @ProviderId

    WHILE @@FETCH_STATUS = 0
    BEGIN

	BEGIN

			SET @MyCursor2 = CURSOR FOR
			SELECT InsuranceId, Name  FROM Insurance where ProviderId = @ProviderId  
			OPEN @MyCursor2 
			FETCH NEXT FROM @MyCursor2
			INTO @InsuranceId, @InsuranceName

			WHILE @@FETCH_STATUS = 0
			BEGIN

				insert into CrossInsuranceGrid (InsuranceId, DestinationInsuranceId)
				select @InsuranceId, insuranceId from Insurance 
				where ProviderId != @ProviderId 
				and Name = @InsuranceName

			  FETCH NEXT FROM @MyCursor2 
			  INTO @InsuranceId, @InsuranceName
			END; 

			CLOSE @MyCursor2 ;
			DEALLOCATE @MyCursor2;
		END;

      FETCH NEXT FROM @MyCursor 
      INTO @ProviderId
    END; 

    CLOSE @MyCursor ;
    DEALLOCATE @MyCursor;
END;