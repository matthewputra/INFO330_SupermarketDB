-- Populate tblOrderType
BEGIN TRAN populateOrderType
    INSERT INTO tblOrderType(OrderTypeName)
    VALUES ('in-store')
    INSERT INTO tblOrderType(OrderTypeName)
    VALUES ('online')
COMMIT TRAN populateOrderType
