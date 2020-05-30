-- Populate tblPosition
BEGIN TRAN populatePosition
    INSERT INTO tblPosition(PositionName)
    VALUES ('Intern')
    INSERT INTO tblPosition(PositionName)
    VALUES ('Associate')
    INSERT INTO tblPosition(PositionName)
    VALUES ('Junior')
    INSERT INTO tblPosition(PositionName)
    VALUES ('Senior')
    INSERT INTO tblPosition(PositionName)
    VALUES ('Vice President')
    INSERT INTO tblPosition(PositionName)
    VALUES ('President')
COMMIT TRAN populatePosition