-- Populate tblGender
BEGIN TRAN populateGender
    INSERT INTO tblGender(GenderName)
    VALUES ('male')
    INSERT INTO tblGender(GenderName)
    VALUES ('female')
    INSERT INTO tblGender(GenderName)
    VALUES ('transgender')
    INSERT INTO tblGender(GenderName)
    VALUES ('non-binary')
    INSERT INTO tblGender(GenderName)
    VALUES ('gender fluid')
    INSERT INTO tblGender(GenderName)
    VALUES ('gender neutral')
COMMIT TRAN populateGender