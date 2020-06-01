-- Populate tblStatus
BEGIN TRAN populateStatus
    INSERT INTO tblStatus(StatusName)
    VALUES ('shipped')
    INSERT INTO tblStatus(StatusName)
    VALUES ('delivered')
    INSERT INTO tblStatus(StatusName)
    VALUES ('ordered')
    INSERT INTO tblStatus(StatusName)
    VALUES ('complete')
COMMIT TRAN populateStatus
