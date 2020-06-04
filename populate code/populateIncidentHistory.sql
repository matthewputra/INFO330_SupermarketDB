-- Populate tblIncidentHistory
BEGIN TRAN populateIncidentHistory
    INSERT INTO tblIncidentHistory(OrderStatusID, IncidentID, IncidentHistoryDescription)
    VALUES (351, 1, 'Resolved')
    INSERT INTO tblIncidentHistory(OrderStatusID, IncidentID, IncidentHistoryDescription)
    VALUES (360, 2, 'Refunded customer with cash')
    INSERT INTO tblIncidentHistory(OrderStatusID, IncidentID, IncidentHistoryDescription)
    VALUES (451, 5, 'Refunded customer with voucher')
    INSERT INTO tblIncidentHistory(OrderStatusID, IncidentID, IncidentHistoryDescription)
    VALUES (381, 2, 'Found missing parts back')
    INSERT INTO tblIncidentHistory(OrderStatusID, IncidentID, IncidentHistoryDescription)
    VALUES (491, 1, 'Resolved')
COMMIT TRAN populateIncidentHistory