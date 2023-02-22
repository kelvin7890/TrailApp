CREATE PROCEDURE [dbo].[DeleteTrail]
	@Id int
AS
BEGIN
	SET NOCOUNT ON;

	DELETE FROM Trails
	WHERE Id = @Id
END
