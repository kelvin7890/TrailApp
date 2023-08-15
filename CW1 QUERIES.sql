create database CW2;

-- --------------CREATING TABLES -----------------------------
CREATE TABLE Trails (
    TrailId INT PRIMARY KEY,
    TrailName VARCHAR(100),
    [Description] TEXT,
	TrailActivity	varchar(100),
	waypoints varchar(100),
    [Length] DECIMAL(5, 2),
    LocationID INT,
    OwnershipID INT,
	ParkID int
);
DRop table Trail;

CREATE TABLE TrailLocation (
    LocationID INT PRIMARY KEY,
    Latitude FLOAT,
    Longitude FLOAT ,
    OrderInTrail INT,
	[location] VARCHAR(100)
);
DRop table TrailLocation;
CREATE TABLE City (
    CityID  INT PRIMARY KEY,
    LocationID INT,
    city VARCHAR(100)
);
drop table City;


   CREATE TABLE Park (
    ParkID INT PRIMARY KEY,
    park VARCHAR(100),
    CityID INT,
    CONSTRAINT FK_Park_City FOREIGN KEY (CityID) REFERENCES City(CityID)
);
   
drop table Park
CREATE TABLE TrailOwnership (
    OwnershipID INT PRIMARY KEY,
    Trailownership VARCHAR(100)	
);



-- ---------------------------------------INSERTING TABLES------------------------------------------------------
INSERT INTO Trails(TrailID, TrailName,[Description],TrailActivity,waypoints, [Length] ,LocationID ,OwnershipID, ParkID )
VALUES(101,'Angels Landing','Hiking Route in Zion National Park',	'Hiking','spring',7.1, 201, 301, 401),
(102,'Devils Bridge','Hiking Route in Coconino National Forest','Hiking','mountain', 6.3,202,302,402),
(103,'Emerald Lake','Snowshoeing in Rocky Mountain Park','Snowshoeing',	'road',	5.1,203, 301, 403),
(104, 'Grand Canyon Rim','Scenic Trail along Grand Canyon Rim','Hiking','Forest', 20.4, 204, 301,404),
(105,'Forest Loop Tranquil', 'Hike through Pine Forest','Hiking',	'Valley',8.2, 205, 301, 405),
(106, 'Waterfall Trail', 'Trail Leading to a Beautiful Waterfall','Hiking', 'Valley', 3.5, 206, 301, 406);

INSERT INTO TrailLocation (LocationID, Latitude, Longitude, OrderInTrail, [location])
VALUES
    (201, 40.760780, -73.976340, 1, 'Central Park'),
    (202, 34.052235, -118.243683, 2, 'Los Angeles'),
    (203, 51.507350, -0.127758, 3, 'London'),
    (204, 48.856613, 2.352222, 4, 'Paris'),
    (205, 41.878113, -87.629799, 5, 'Chicago'),
    (206, 37.774929, -122.419418, 6, 'San Francisco');

INSERT INTO City (CityID,city,LocationID)values
(501, 'Utah', 201),
(502, 'Arizona', 202),
(503, 'Colorado', 203),
(504, 'Texas', 204),
(505, 'California', 205),
(506, 'Oregon', 206);

INSERT INTO Park (ParkID, park, CityID)values
(401,'Zion', 501),
(402,'Rocky mountain', 502),
(403, 'NA', 503),
(404,'Mount Rainier', 504),	
(405,'Yosemite', 505),
(406,'Shenan', 506);


INSERT INTO TrailOwnership( OwnershipID, Trailownership)values
(301,	'National Park Service'),
(302, 'U.S. Forest Service'),
(303, 'National Park ');

select* from Trail;

-------------------------CREATING VIEWS----------------------------

CREATE VIEW TrailInfo AS
SELECT 
    T.TrailID,
    T.TrailName,
    T.[Description],
    T.TrailActivity,
    T.waypoints,
    T.[Length],
    L.[location] AS TrailLocation,
    P.park AS ParkName,
    O.Trailownership AS [Ownership]
FROM 
    Trails T
JOIN 
    TrailLocation L ON T.LocationID = L.LocationID
JOIN 
    Park P ON T.ParkID = P.ParkID
JOIN 
    TrailOwnership O ON T.OwnershipID = O.OwnershipID;

	SELECT* FROM TrailInfo;

	-----------------------STORE PROCEDURE---------------------------------
CREATE PROCEDURE UpdateTrailInfo(
    @TrailID INT,
    @TrailName VARCHAR(100),
    @Description TEXT,
    @TrailActivity VARCHAR(100),
    @waypoints VARCHAR(100),
    @Length DECIMAL(5, 2),
    @LocationID INT,
    @OwnershipID INT,
    @ParkID INT
)
AS
BEGIN
    UPDATE Trails
    SET
        TrailName = @TrailName,
        [Description] = @Description,
        TrailActivity = @TrailActivity,
        waypoints = @waypoints,
        [Length] = @Length,
        LocationID = @LocationID,
        OwnershipID = @OwnershipID,
        ParkID = @ParkID
    WHERE
        TrailID = @TrailID;
END;



------UPDATING STORE PROCEDURE-----------------------------
EXEC UpdateTrailInfo
    @TrailID = 101,
    @TrailName = 'Devils river',
    @Description = 'A new hiking trail',
    @TrailActivity = 'Hiking',
    @waypoints = 'mountain',
    @Length = 10.5,
    @LocationID = 201,
    @OwnershipID = 301,
    @ParkID = 401;



	CREATE PROCEDURE InsertTrail(
    @TrailID INT,
    @TrailName VARCHAR(100),
    @Description TEXT,
    @TrailActivity VARCHAR(100),
    @waypoints VARCHAR(100),
    @Length DECIMAL(5, 2),
    @LocationID INT,
    @OwnershipID INT,
    @ParkID INT
)
AS
BEGIN
    INSERT INTO Trails (TrailID, TrailName, [Description], TrailActivity, waypoints, [Length], LocationID, OwnershipID, ParkID)
    VALUES (@TrailID, @TrailName, @Description, @TrailActivity, @waypoints, @Length, @LocationID, @OwnershipID, @ParkID);
END;

-----------inserting ----------------------
EXEC InsertTrail
    @TrailID = 107,
    @TrailName = 'New Trail',
    @Description = 'A new hiking trail',
    @TrailActivity = 'Hiking',
    @waypoints = 'summer',
    @Length = 4.2,
    @LocationID = 201,
    @OwnershipID = 301,
    @ParkID = 401;




	CREATE PROCEDURE DeleteTrail(
    @TrailID INT
)
AS
BEGIN
    DELETE FROM Trails
    WHERE TrailID = @TrailID;
END;


---------Delete-----------
EXEC DeleteTrail
    @TrailID = 107;


	----------------------------TRIGGERS------------------------------
CREATE TRIGGER Trail_Insert
ON Trails
AFTER INSERT
AS
BEGIN
    UPDATE TrailLocation
    SET LocationID = i.LocationID
    FROM TrailLocation tl
    INNER JOIN inserted i ON tl.LocationID = i.LocationID;
END;

---Creating a Trigger for Updating Trail Information:-----
CREATE TRIGGER Trail_Update
ON Trails
AFTER UPDATE
AS
BEGIN
    UPDATE TrailLocation
    SET LocationID = i.LocationID
    FROM TrailLocation tl
    INNER JOIN inserted i ON tl.LocationID = i.LocationID;
END;

-----Creating a Trigger for Deleting Trail Information:-----------
CREATE TRIGGER Trail_Delete
ON Trails
AFTER DELETE
AS
BEGIN
    DELETE FROM TrailLocation
    WHERE LocationID IN (SELECT LocationID FROM deleted);
END;


