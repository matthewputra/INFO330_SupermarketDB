-- Populate tblRating
BEGIN TRAN populateRating
    INSERT INTO tblRating(OverallRating, RatingName)
    VALUES (1, 'Unsatisfactory')
    INSERT INTO tblRating(OverallRating, RatingName)
    VALUES (2, 'Below Average')
    INSERT INTO tblRating(OverallRating, RatingName)
    VALUES (3, 'Average')
    INSERT INTO tblRating(OverallRating, RatingName)
    VALUES (4, 'Above Average')
    INSERT INTO tblRating(OverallRating, RatingName)
    VALUES (5, 'Satisfactory')
COMMIT TRAN populateRating