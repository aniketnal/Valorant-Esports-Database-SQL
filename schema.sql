-- In this SQL file, write (and comment!) the schema of your database, including the CREATE TABLE, CREATE INDEX, CREATE VIEW, etc. statements that compose it

-- Stores information about each tournament
CREATE TABLE "Tournaments" (
    "tournament_id" INTEGER PRIMARY KEY,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "start_date" DATE,
    "end_date" DATE,
    "location" TEXT,
    "organizer" TEXT,
    "status" TEXT CHECK ("status" IN ('ongoing', 'upcoming', 'completed')),
    "winner_team" TEXT CHECK ("status" = 'completed' AND "winner_team" IS NOT NULL OR "status" <> 'completed' AND "winner_team" IS NULL)
);

-- Contains details about participating teams
CREATE TABLE "Teams" (
    "team_id" INTEGER PRIMARY KEY,
    "name" TEXT NOT NULL,
    "captain" TEXT,
    "contact_info" TEXT,
    "logo_url" TEXT
);

-- Holds data about individual players
CREATE TABLE "Players" (
    "player_id" INTEGER PRIMARY KEY,
    "username" TEXT,
    "email" TEXT,
    "team_id" INTEGER,
    FOREIGN KEY ("team_id") REFERENCES "Teams"("team_id")
);

-- Represents each ma+tch within a tournament
CREATE TABLE "Matches" (
    "match_id" INTEGER PRIMARY KEY,
    "tournament_id" INTEGER,
    "team1_id" INTEGER,
    "team2_id" INTEGER,
    "date_time" DATETIME,
    "winner_team_id" INTEGER,
    "status" TEXT CHECK ("status" IN ('scheduled', 'completed')),
    FOREIGN KEY ("tournament_id") REFERENCES "Tournaments"("tournament_id"),
    FOREIGN KEY ("team1_id") REFERENCES "Teams"("team_id"),
    FOREIGN KEY ("team2_id") REFERENCES "Teams"("team_id"),
    FOREIGN KEY ("winner_team_id") REFERENCES "Teams"("team_id")
);

-- Records the scores for each match, linking to the match and the team.
CREATE TABLE "Scores" (
    "score_id" INTEGER PRIMARY KEY,
    "match_id" INTEGER,
    "team_id" INTEGER,
    "score" INTEGER,
    FOREIGN KEY ("match_id") REFERENCES "Matches"("match_id"),
    FOREIGN KEY ("team_id") REFERENCES "Teams"("team_id")
);

-- Stores information about the prizes available for each tournament
CREATE TABLE "Prizes" (
    "prize_id" INTEGER PRIMARY KEY,
    "tournament_id" INTEGER,
    "description" TEXT,
    "value" INTEGER,
    FOREIGN KEY ("tournament_id") REFERENCES "Tournaments"("tournament_id")
);


-- Stores the Upcoming Tournaments
CREATE VIEW "upcoming_tournaments" AS
SELECT "tournament_id", "name", "description", "start_date", "end_date", "location", "organizer"
FROM "Tournaments"
WHERE "status" = 'upcoming';

-- -- Stores the Ongoing Tournaments
CREATE VIEW "ongoing_tournaments" AS
SELECT "tournament_id", "name", "description", "start_date", "end_date", "location", "organizer"
FROM "Tournaments"
WHERE "status" = 'ongoing';


---- Stores the Completed Tournaments
CREATE VIEW "completed_tournaments" AS
SELECT "tournament_id", "name", "description", "start_date", "end_date", "location", "organizer", "winner_team"
FROM "Tournaments"
WHERE "status" = 'completed';


-- Stores Line Up
CREATE VIEW "lineups" AS
SELECT "name" AS "team_name", "username" AS "player_name"
FROM "Teams"
JOIN "Players" ON "Teams"."team_id" = "Players"."team_id";


CREATE INDEX "score_index"
ON "Scores" ("score");

CREATE INDEX "match_winner_index"
ON "Matches" ("winner_team_id");

CREATE INDEX "tournament_index"
ON "Tournaments" ("name", "organizer", "status");


-- Inserting sample data for Tournaments
INSERT INTO "Tournaments" ("name", "description", "start_date", "end_date", "location", "organizer", "status", "winner_team")
VALUES
    ('Valorant Masters', 'International Valorant tournament', '2024-06-15', '2024-06-20', 'Online', 'Valorant Esports Association', 'completed', 'Team A'),
    ('Valorant Open Cup', 'Open Valorant tournament', '2024-09-20', '2024-09-25', 'Convention Center', 'Valorant Club', 'upcoming', NULL),
    ('Valorant Pro Series', 'Professional Valorant competition', '2024-10-20', '2024-11-10', 'Stadium', 'Pro Esports League', 'ongoing', NULL),
    ('Valorant Championship Series', 'Regional Valorant championship', '2024-07-01', '2024-07-10', 'Stadium', 'Local Valorant League', 'completed', 'Team B'),
    ('Valorant Invitational', 'Invitational Valorant tournament', '2024-08-05', '2024-08-07', 'Online', 'Esports Organization', 'completed', 'Team C'),
    ('Valorant City Clash', 'City-based Valorant league', '2024-10-01', '2024-10-15', 'Various Venues', 'City Esports Association', 'upcoming', NULL),
    ('Valorant University Cup', 'Inter-university Valorant competition', '2024-11-10', '2024-11-15', 'University Campus', 'Student Esports Federation', 'upcoming', NULL),
    ('Valorant Winter Cup', 'Winter-themed Valorant tournament', '2024-12-01', '2024-12-10', 'Ice Arena', 'Winter Sports League', 'upcoming', NULL),
    ('Valorant Summer Showdown', 'Summer themed Valorant event', '2024-07-25', '2024-07-30', 'Beach Resort', 'Summer Esports', 'completed', 'Team A');


-- Inserting sample data for Teams
INSERT INTO "Teams" ("name", "captain", "contact_info", "logo_url")
VALUES
  ('Team A', 'CaptainA', 'teamA@example.com', 'https://teamA_logo.com'),
  ('Team B', 'CaptainB', 'teamB@example.com', 'https://teamB_logo.com'),
  ('Team C', 'CaptainC', 'teamC@example.com', 'https://teamC_logo.com'),
  ('Team D', 'CaptainD', 'teamD@example.com', 'https://teamD_logo.com'),
  ('Team E', 'CaptainE', 'teamE@example.com', 'https://teamE_logo.com');

-- Inserting sample data for Players
INSERT INTO "Players" ("username", "email", "team_id")
VALUES
  ('Player1A', 'player1A@example.com', 1),
  ('Player2A', 'player2A@example.com', 1),
  ('Player3A', 'player3A@example.com', 1),
  ('Player4A', 'player4A@example.com', 1),
  ('Player5A', 'player5A@example.com', 1),
  ('Player1B', 'player1B@example.com', 2),
  ('Player2B', 'player2B@example.com', 2),
  ('Player3B', 'player3B@example.com', 2),
  ('Player4B', 'player4B@example.com', 2),
  ('Player1C', 'player1C@example.com', 3),
  ('Player2C', 'player2C@example.com', 3),
  ('Player3C', 'player3C@example.com', 3),
  ('Player4C', 'player4C@example.com', 3),
  ('Player5C', 'player5C@example.com', 3),
  ('Player1D', 'player1D@example.com', 4),
  ('Player2D', 'player2D@example.com', 4),
  ('Player3D', 'player3D@example.com', 4),
  ('Player4D', 'player4D@example.com', 4),
  ('Player1E', 'player1E@example.com', 5),
  ('Player2E', 'player2E@example.com', 5),
  ('Player3E', 'player3E@example.com', 5),
  ('Player4E', 'player4E@example.com', 5);


-- Inserting sample data for Matches
INSERT INTO "Matches" ("tournament_id", "team1_id", "team2_id", "date_time", "winner_team_id", "status")
VALUES
  (1, 1, 2, '2024-06-20 10:00:00', NULL, 'scheduled'),
  (1, 3, 4, '2024-06-21 11:00:00', NULL, 'scheduled'),
  (2, 1, 3, '2024-07-12 13:00:00', 1, 'completed'),
  (2, 2, 4, '2024-07-15 14:00:00', 4, 'completed'),
  (3, 4, 5, '2024-08-05 12:00:00', NULL, 'scheduled'),
  (4, 5, 1, '2024-08-05 12:00:00', 1, 'completed'),
  (4, 2, 3, '2024-08-05 12:00:00', 2, 'completed');

-- Inserting sample data for Scores
INSERT INTO "Scores" ("match_id", "team_id", "score")
VALUES
  (3, 1, 13),
  (3, 3, 9),
  (4, 2, 12),
  (4, 4, 13),
  (6, 5, 7),
  (6, 1, 13),
  (7, 2, 15),
  (7, 3, 14);

-- Inserting sample data for Prizes
INSERT INTO "Prizes" ("tournament_id", "description", "value")
VALUES
  (1, '1st Place Prize', 10000),
  (1, '2nd Place Prize', 5000),
  (2, 'Champion Prize', 15000),
  (2, 'Runner-up Prize', 7500),
  (3, 'Pro Series Winner', 8000),
  (3, 'Pro Series Runner-up', 4000),
  (4, 'Championship Series Winner', 55000),
  (4, 'Championship Series Runner-up', 28000),
  (5, 'Valorant Invitational Winner', 72000),
  (5, 'Valorant Invitational Runner-up', 37000),
  (6, 'City Clash Winner', 84000),
  (6, 'City Clash Runner-up', 18000),
  (7, 'University Cu Winner', 50000),
  (7, 'University Cup Runner-up', 64000),
  (8, 'Winter Cup Cup Winner', 92000),
  (8, 'Winter Cup Runner-up', 14000),
  (9, 'Summer Showdown Winner', 79000),
  (9, 'Summer Showdown Runner-up', 43000);


