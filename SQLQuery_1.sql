-- create the Users table
CREATE TABLE Users (
    UserId INT PRIMARY KEY IDENTITY,
    Username NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) NOT NULL,
    PasswordHash NVARCHAR(100) NOT NULL,
    Role NVARCHAR(100) NOT NULL
);

-- create the Trails table
CREATE TABLE Trails (
    TrailId INT PRIMARY KEY IDENTITY,
    Name NVARCHAR(100) NOT NULL,
    Description NVARCHAR(500) NOT NULL,
    DifficultyLevel INT NOT NULL,
    DistanceInMiles FLOAT NOT NULL,
    CreatorId INT NOT NULL,
    FOREIGN KEY (CreatorId) REFERENCES Users(UserId)
);

-- create the Locations table
CREATE TABLE Locations (
    LocationId INT PRIMARY KEY IDENTITY,
    TrailId INT NOT NULL,
    Latitude FLOAT NOT NULL,
    Longitude FLOAT NOT NULL,
    OrderInTrail INT NOT NULL,
    FOREIGN KEY (TrailId) REFERENCES Trails(TrailId)
);

-- create the TrailBadges table
CREATE TABLE TrailBadges (
    TrailId INT NOT NULL,
    BadgeId INT NOT NULL,
    PRIMARY KEY (TrailId, BadgeId),
    FOREIGN KEY (TrailId) REFERENCES Trails(TrailId),
    FOREIGN KEY (BadgeId) REFERENCES Badges(BadgeId)
);

-- create the Badges table
CREATE TABLE Badges (
    BadgeId INT PRIMARY KEY IDENTITY,
    Name NVARCHAR(100) NOT NULL,
    Description NVARCHAR(500) NOT NULL,
    ImageUrl NVARCHAR(500) NOT NULL
);

-- create the UserBadges table
CREATE TABLE UserBadges (
    UserId INT NOT NULL,
    BadgeId INT NOT NULL,
    DateEarned DATETIME NOT NULL,
    PRIMARY KEY (UserId, BadgeId),
    FOREIGN KEY (UserId) REFERENCES Users(UserId),
    FOREIGN KEY (BadgeId) REFERENCES Badges(BadgeId)
);

-- create the Comments table
CREATE TABLE Comments (
    CommentId INT PRIMARY KEY IDENTITY,
    UserId INT NOT NULL,
    TrailId INT NOT NULL,
    CommentText NVARCHAR(500) NOT NULL,
    CreationTime DATETIME NOT NULL,
    FOREIGN KEY (UserId) REFERENCES Users(UserId),
    FOREIGN KEY (TrailId) REFERENCES Trails(TrailId)
);

-- create the ArchivedComments table
CREATE TABLE ArchivedComments (
    CommentId INT NOT NULL,
    ArchivedBy INT NOT NULL,
    ArchiveTime DATETIME NOT NULL,
    PRIMARY KEY (CommentId),
    FOREIGN KEY (CommentId) REFERENCES Comments(CommentId),
    FOREIGN KEY (ArchivedBy) REFERENCES Users(UserId)
);
