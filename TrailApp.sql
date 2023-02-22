CREATE PROCEDURE [dbo].[InsertTrail]
	@Name varchar(50),
	@Description varchar(500),
	@Distance float,
	@Duration time,
	@DifficultyLevel varchar(20),
	@OwnerId int
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO Trails (Name, Description, Distance, Duration, DifficultyLevel, OwnerId)
	VALUES (@Name, @Description, @Distance, @Duration, @DifficultyLevel, @OwnerId)

	SELECT SCOPE_IDENTITY() AS Id
END
