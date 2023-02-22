CREATE PROCEDURE [dbo].[UpdateTrail]
	@Id int,
	@Name varchar(50),
	@Description varchar(500),
	@Distance float,
	@Duration time,
	@DifficultyLevel varchar(20),
	@OwnerId int
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE Trails
	SET Name = @Name,
		Description = @Description,
		Distance = @Distance,
		Duration = @Duration,
		DifficultyLevel = @DifficultyLevel,
		OwnerId = @OwnerId
	WHERE Id = @Id
END
