-- Before running this script, select the pool 'SQLPOOL1' in Connect to drop down list.

IF NOT EXISTS (SELECT * FROM sys.objects O JOIN sys.schemas S ON O.schema_id = S.schema_id WHERE O.NAME = 'NYCTaxiTripSmall' AND O.TYPE = 'U' AND S.NAME = 'dbo')
CREATE TABLE dbo.NYCTaxiTripSmall
    (
     [DateID] int,
     [MedallionID] int,
     [HackneyLicenseID] int,
     [PickupTimeID] int,
     [DropoffTimeID] int,
     [PickupGeographyID] int,
     [DropoffGeographyID] int,
     [PickupLatitude] float,
     [PickupLongitude] float,
     [PickupLatLong] nvarchar(4000),
     [DropoffLatitude] float,
     [DropoffLongitude] float,
     [DropoffLatLong] nvarchar(4000),
     [PassengerCount] int,
     [TripDurationSeconds] int,
     [TripDistanceMiles] float,
     [PaymentType] nvarchar(4000),
     [FareAmount] numeric(19,4),
     [SurchargeAmount] numeric(19,4),
     [TaxAmount] numeric(19,4),
     [TipAmount] numeric(19,4),
     [TollsAmount] numeric(19,4),
     [TotalAmount] numeric(19,4)
    )
WITH
    (
    DISTRIBUTION = ROUND_ROBIN,
     CLUSTERED COLUMNSTORE INDEX
     -- HEAP
    )
GO

COPY INTO dbo.NYCTaxiTripSmall
(DateID 1, MedallionID 2, HackneyLicenseID 3, PickupTimeID 4, DropoffTimeID 5,
PickupGeographyID 6, DropoffGeographyID 7, PickupLatitude 8, PickupLongitude 9, 
PickupLatLong 10, DropoffLatitude 11, DropoffLongitude 12, DropoffLatLong 13, 
PassengerCount 14, TripDurationSeconds 15, TripDistanceMiles 16, PaymentType 17, 
FareAmount 18, SurchargeAmount 19, TaxAmount 20, TipAmount 21, TollsAmount 22, 
TotalAmount 23)
FROM 'https://datalakedemoaletu.dfs.core.windows.net/filesysdemoaletu/NYCTripSmall.parquet'
WITH
(
    FILE_TYPE = 'PARQUET'
    ,MAXERRORS = 0
    ,IDENTITY_INSERT = 'OFF'
)
