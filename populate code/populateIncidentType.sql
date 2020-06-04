-- Populate tblIncidentType
BEGIN TRAN populateIncidentType
    INSERT INTO tblIncidentType(IncidentTypeName)
    VALUES ('Damaged')
    INSERT INTO tblIncidentType(IncidentTypeName)
    VALUES ('Lost')
    INSERT INTO tblIncidentType(IncidentTypeName)
    VALUES ('Stolen')
    INSERT INTO tblIncidentType(IncidentTypeName)
    VALUES ('No incident')
    INSERT INTO tblIncidentType(IncidentTypeName)
    VALUES ('Broken')
COMMIT TRAN populateIncidentType



