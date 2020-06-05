USE INFO330_PROJ_A13
CREATE PROCEDURE uspInsertIncident
@Type VARCHAR(30),
@Incident VARCHAR(30),
@Location VARCHAR(30),
@SDate DATE,
@EDate DATE
AS
    DECLARE @ITID INT, @LID INT
    SET @ITID = (SELECT IncidentTypeID FROM tblIncidentType WHERE IncidentTypeName = @Type)
    SET @LID = (SELECT LocationID FROM tblLocation WHERE LocationName = @Location)
    BEGIN TRAN insertIncident
        INSERT INTO tblIncident(IncidentTypeID, IncidentName, LocationID, StartDate, EndDate)
        VALUES (@ITID, @Incident, @LID, @SDate, @EDate)
    COMMIT TRAN insertIncident
GO
