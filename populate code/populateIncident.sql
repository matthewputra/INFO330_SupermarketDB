-- Populate tblIncident
BEGIN TRAN populateIncident
    INSERT INTO tblIncident(IncidentTypeID, IncidentName, LocationID, StartDate, EndDate)
    VALUES (1, 'A little bit damaged', 1, '2019-05-05', '2019-05-07')
    INSERT INTO tblIncident(IncidentTypeID, IncidentName, LocationID, StartDate, EndDate)
    VALUES (1, 'A lot of damage', 5, '2019-07-10', '2019-07-15')
    INSERT INTO tblIncident(IncidentTypeID, IncidentName, LocationID, StartDate, EndDate)
    VALUES (2, 'Lost in shipment', 1, '2019-12-05', '2019-12-17')
    INSERT INTO tblIncident(IncidentTypeID, IncidentName, LocationID, StartDate, EndDate)
    VALUES (4, 'No incident', 1, '2020-05-05', '2020-05-05')
    INSERT INTO tblIncident(IncidentTypeID, IncidentName, LocationID, StartDate, EndDate)
    VALUES (5, 'Broken in shipment', 1, '2019-10-07', '2019-10-17')
COMMIT TRAN populateIncident
