-- Name: ALAY DILIPBHAI SHAH
-- USCID: 4038-9488-19

CREATE EXTENSION IF NOT EXISTS postgis;

-- Creating Table to Store Geospatial Data

DROP TABLE IF EXISTS Geospatial;
CREATE TABLE Geospatial(label VARCHAR(50) PRIMARY KEY, points geometry);

-- Inserting data into the table created above
INSERT INTO Geospatial (label, points) VALUES ('Home', st_geomfromtext('POINT(-118.280246 34.026349)', 4326));
INSERT INTO Geospatial (label, points) VALUES ('Shrine Hall', st_geomfromtext('POINT(-118.2816920 34.0238086)', 4326));
INSERT INTO Geospatial (label, points) VALUES ('Powell Hall', st_geomfromtext('POINT(-118.2888065 34.0191597)', 4326));
INSERT INTO Geospatial (label, points) VALUES ('Tommy Trojan', st_geomfromtext('POINT(-118.2854468 34.0205619)', 4326));
INSERT INTO Geospatial (label, points) VALUES ('Bridge Hall', st_geomfromtext('POINT(-118.2857381 34.0188316)', 4326));
INSERT INTO Geospatial (label, points) VALUES ('SGM 123', st_geomfromtext('POINT(-118.2891709 34.021160099)', 4326));
INSERT INTO Geospatial (label, points) VALUES ('Taper Hall', st_geomfromtext('POINT(-118.2845601 34.0222729)', 4326));
INSERT INTO Geospatial (label, points) VALUES ('Lyon Center', st_geomfromtext('POINT(-118.2884284 34.0244047)', 4326));
INSERT INTO Geospatial (label, points) VALUES ('Expo/Vermo', st_geomfromtext('POINT(-118.291428 34.018398)', 4326));
INSERT INTO Geospatial (label, points) VALUES ('Vermo/Jeff', st_geomfromtext('POINT(-118.291417 34.025389)', 4326));
INSERT INTO Geospatial (label, points) VALUES ('Jeff/Figuer', st_geomfromtext('POINT(-118.280224 34.021853)', 4326));
INSERT INTO Geospatial (label, points) VALUES ('Figuer/Expo', st_geomfromtext('POINT(-118.282419 34.018462)', 4326));

-- 1) Generating Convex Hull
SELECT st_astext(st_convexhull(st_collect(map.points))) AS convhull
FROM Geospatial as map;

-- OUTPUT:
-- "POLYGON((
-- -118.291428 34.018398,
-- -118.291417 34.025389,
-- -118.280246 34.026349,
-- -118.280224 34.021853,
-- -118.282419 34.018462,
-- -118.291428 34.018398))"


-- 2) Find 4 Nearest Neighbours from HOME
SELECT map2.label AS Nearest_Neighbours, st_astext(map2.points) AS Coordinates
FROM Geospatial AS map1, Geospatial AS map2
WHERE map1.label = 'Home' AND map1.label <> map2.label
ORDER BY st_distance(map1.points, map2.points)
LIMIT 4;

-- OUTPUT:

--      nearest_neighbours   coordinates
--        Shrine Hall	       POINT(-118.281692 34.0238086)
--        Jeff/Figuer	       POINT(-118.280224 34.021853)
--        Taper Hall	       POINT(-118.2845601 34.0222729)
--        Tommy Trojan	     POINT(-118.2854468 34.0205619)
