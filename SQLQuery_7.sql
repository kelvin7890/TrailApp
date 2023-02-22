CREATE TRIGGER tr_UpdateTrailDistance
ON LocationPoints
AFTER INSERT, DELETE
AS
BEGIN
    -- Update distance for each trail affected by the trigger
    UPDATE Trail
    SET Distance = (
        SELECT SUM(DistanceBetween)
        FROM (
            SELECT LP1.Latitude, LP1.Longitude, LP2.Latitude, LP2.Longitude, 
                dbo.CalculateDistance(LP1.Latitude, LP1.Longitude, LP2.Latitude, LP2.Longitude) AS DistanceBetween
            FROM LocationPoints LP1
            JOIN LocationPoints LP2
            ON LP1.TrailID = LP2.TrailID
            AND LP1.LocationOrder = LP2.LocationOrder - 1
        ) AS DistanceTable
        WHERE DistanceTable.TrailID = Trail.TrailID
    )
    WHERE Trail.TrailID IN (
        SELECT DISTINCT TrailID
        FROM inserted
    ) OR Trail.TrailID IN (
        SELECT DISTINCT TrailID
        FROM deleted
    )
END
