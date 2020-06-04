-- Populate tblReview
BEGIN TRAN populateReview
    INSERT INTO tblReview(RatingID, OrderStatusID, ReviewDescription, ReviewDate)
    VALUES (5, 351, 'Very good product', '2019-11-07')
    INSERT INTO tblReview(RatingID, OrderStatusID, ReviewDescription, ReviewDate)
    VALUES (1, 360, 'Very bad product', '2020-02-21')
    INSERT INTO tblReview(RatingID, OrderStatusID, ReviewDescription, ReviewDate)
    VALUES (3, 420, 'This product came late to me', '2020-01-11')
    INSERT INTO tblReview(RatingID, OrderStatusID, ReviewDescription, ReviewDate)
    VALUES (2, 460, 'Not so bad product', '2019-05-21')
    INSERT INTO tblReview(RatingID, OrderStatusID, ReviewDescription, ReviewDate)
    VALUES (5, 364, 'I like this product', '2019-12-21')
COMMIT TRAN populateReview