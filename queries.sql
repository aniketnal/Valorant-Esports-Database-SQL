-- In this SQL file, write (and comment!) the typical SQL queries users will run on your database
-- To look into each table of database here are some basic queries.
SELECT * FROM "Tournaments";
SELECT * FROM "Teams";
SELECT * FROM "Players";
SELECT * FROM "Matches";
SELECT * FROM "Scores";
SELECT * FROM "Prizes";

-- With the help of view the user can look up for tournaments more seamlessly like a filter to their search

-- To see the upcoming tournaments
SELECT * FROM "upcoming_tournaments";

-- To see the ongoing tournaments
SELECT * FROM "ongoing_tournaments";

-- To see the completed tournaments
SELECT * FROM "completed_tournaments";

-- Get the average score for each team
SELECT "Teams"."name" AS "Team Name", AVG("Scores"."score") AS "Average Score"
FROM "Teams"
JOIN "Scores" ON "Teams"."team_id" = "Scores"."team_id"
GROUP BY "Teams"."name";

-- Get the tournaments organized by a specific organizer
SELECT * FROM "Tournaments"
WHERE "organizer" = 'Valorant Esports Association';

-- Looking for a specific team's lineup
SELECT "player_name" FROM "lineups" WHERE "team_name" = 'Team A';

--  Update the contact information of a player
UPDATE "Players"
SET "email" = 'newemail@example.com'
WHERE "player_id" = 5; -- Assuming you want to update the email of player with ID 5

-- Update the status of a specific tournament
UPDATE "Tournaments"
SET "status" = 'completed', "winner_team" = 'Team E'
WHERE "tournament_id" = 2; -- Assuming you want to update the status of tournament with ID 2

-- Insert a new tournament
INSERT INTO "Tournaments" ("name", "description", "start_date", "end_date", "location", "organizer", "status", "winner_team")
VALUES ('Masters Madrid', 'Global Tournament', '2024-12-20', '2024-12-25', 'Madrid, Spain', 'Riot Games', 'upcoming', NULL);

-- Insert a new team
INSERT INTO "Teams" ("name", "captain", "contact_info", "logo_url")
VALUES ('Team F', 'CaptainF', 'teamF@example.com', 'https://teamF_logo.com');

-- Removing team for getting banned in the tournament
DELETE FROM "Teams"
WHERE "team_id" = 3; -- Assuming you want to delete team with ID 3







