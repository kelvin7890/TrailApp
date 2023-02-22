CREATE VIEW TrailView AS
SELECT Trail.Id, Trail.Name, Trail.Description, Trail.ImageUrl, Trail.CreatedBy, Trail.CreatedAt, 
       Location.Latitude, Location.Longitude, Location.Ordinal
FROM Trail
JOIN Location ON Trail.Id = Location.TrailId
JOIN [User] ON Trail.CreatedBy = [User].Id
