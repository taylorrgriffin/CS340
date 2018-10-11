-- ============== --
-- ENTITIY TABLES --
-- ============== --
CREATE TABLE `universe` (
  `universe_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `origin_year` int(11) NOT NULL,
  primary key (universe_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE `character` (
  `character_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `origin_universe` int(11) NOT NULL,
  `rank` int(11) NOT NULL,
  primary key (character_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE `stage` (
  `stage_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `origin_universe` int(11) DEFAULT NULL,
  primary key (stage_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE `player` (
  `player_id` int(11) NOT NULL AUTO_INCREMENT,
  `tag` varchar(255) NOT NULL,
  `player_rank` int(11) NOT NULL,
  `main` int(11) NOT NULL,
  primary key (player_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ================== --
-- ENTITY CONSTRAINTS --
-- ================== --
ALTER TABLE `character`
  ADD CONSTRAINT `character_ibfk_1` FOREIGN KEY (`origin_universe`) REFERENCES
  `universe` (`universe_id`) ON UPDATE CASCADE;
ALTER TABLE `stage`
  ADD CONSTRAINT `stage_ibfk_1` FOREIGN KEY (`origin_universe`) REFERENCES
  `universe` (`universe_id`) ON UPDATE CASCADE;
ALTER TABLE `player`
  ADD CONSTRAINT `player_ibfk_1` FOREIGN KEY (`main`) REFERENCES
  `character` (`character_id`) ON UPDATE CASCADE;

-- =================== --
-- RELATIONSHIP TABLES --
-- =================== --
-- Characters have negative matchups with other characters
CREATE TABLE `negative_matchups` (
  `cid1` int(11) NOT NULL DEFAULT '0',
  `cid2` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
-- Characters have even matchups with other Characters
CREATE TABLE `even_matchups` (
  `cid1` int(11) NOT NULL DEFAULT '0',
  `cid2` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
-- Characters have positive matchups with other Characters
CREATE TABLE `positive_matchups` (
  `cid1` int(11) NOT NULL DEFAULT '0',
  `cid2` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
-- Some Characters have related stages
CREATE TABLE `character_related_stages` (
  `cid` int(11) NOT NULL DEFAULT '0',
  `sid` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ================= --
-- RELATIONSHIP KEYS --
-- ================= --
ALTER TABLE `negative_matchups`
  ADD PRIMARY KEY (`cid1`,`cid2`);
ALTER TABLE `even_matchups`
  ADD PRIMARY KEY (`cid1`,`cid2`);
ALTER TABLE `positive_matchups`
  ADD PRIMARY KEY (`cid1`,`cid2`);
ALTER TABLE `character_related_stages`
  ADD PRIMARY KEY (`cid`,`sid`);

-- ======================== --
-- RELATIONSHIP CONSTRAINTS --
-- ======================== --
ALTER TABLE `negative_matchups`
  ADD CONSTRAINT `negative_matchups_ibfk_1` FOREIGN KEY (`cid1`)
REFERENCES `character` (`character_id`),
  ADD CONSTRAINT `negative_matchups_ibfk_2` FOREIGN KEY (`cid2`)
REFERENCES `character` (`character_id`);
ALTER TABLE `even_matchups`
  ADD CONSTRAINT `even_matchups_ibfk_1` FOREIGN KEY (`cid1`)
REFERENCES `character` (`character_id`),
  ADD CONSTRAINT `even_matchups_ibfk_2` FOREIGN KEY (`cid2`)
REFERENCES `character` (`character_id`);
ALTER TABLE `positive_matchups`
  ADD CONSTRAINT `positive_matchups_ibfk_1` FOREIGN KEY (`cid1`)
REFERENCES `character` (`character_id`),
  ADD CONSTRAINT `positive_matchups_ibfk_2` FOREIGN KEY (`cid2`)
REFERENCES `character` (`character_id`);
ALTER TABLE `character_related_stages`
  ADD CONSTRAINT `character_related_stages_ibfk_1` FOREIGN KEY (`cid`)
REFERENCES `character` (`character_id`),
  ADD CONSTRAINT `character_related_stages_ibfk_2` FOREIGN KEY (`sid`)
REFERENCES `stage` (`stage_id`);

-- ========================== --
-- DUMP DATA IN ENTITY TABLES --
-- ========================== --
INSERT INTO `universe` (
  `name`,
  `origin_year`) VALUES
  ("Mario", 1981),
  ("F-Zero", 1990),
  ("Star Fox", 1993),
  ("The Legend of Zelda", 1986),
  ("Ice Climber", 1985),
  ("Pokemon", 1996),
  ("Kirby", 1992),
  ("Fire Emblem", 1990),
  ("Game & Watch", 1980),
  ("EarthBound", 1989),
  ("Metroid", 1986);
INSERT INTO `character` (
  `name`,
  `origin_universe`,
  `rank`) VALUES
  ("Fox", 3, 1),
  ("Falco", 3, 2),
  ("Marth", 8, 3),
  ("Sheik", 4, 4),
  ("Jigglypuff", 6, 5),
  ("Peach", 1, 6),
  ("Ice Climbers", 5, 7),
  ("Captain Falcon",2, 8),
  ("Pikachu", 6, 9),
  ("Samus", 11, 10),
  ("Dr. Mario", 1, 11),
  ("Yoshi", 1, 12),
  ("Luigi", 1, 13),
  ("Gannondorf", 4, 14),
  ("Mario", 1, 15),
  ("Young Link", 4, 16),
  ("Donkey Kong", 1, 17),
  ("Link", 4, 18),
  ("Mr. Game & Watch", 9, 19),
  ("Roy", 8, 20),
  ("Mewtwo", 6, 21),
  ("Zelda", 4, 22),
  ("Ness", 10, 23),
  ("Pichu", 6, 24),
  ("Bowser", 1, 25),
  ("Kirby", 7, 26);
INSERT INTO `stage` (
  `name`,
  `origin_universe`) VALUES
  ("Battlefield", NULL),
  ("Dream Land N64", 7),
  ("Final Destination", NULL),
  ("Fountain of Dreams", 7),
  ("Pokemon Stadium", 6),
  ("Yoshi's Story", 1);
INSERT INTO `player` (
  `tag`,
  `player_rank`,
  `main`) VALUES
  ("Hungrybox", 1, 5),
  ("Armada", 2, 6),
  ("Mango", 3, 2),
  ("Mew2King", 4, 4),
  ("Plup", 5, 4),
  ("Leffen", 6, 1),
  ("Axe", 7, 9),
  ("Wizzrobe", 8, 8),
  ("SFAT", 9, 1),
  ("S2J", 10, 8);

-- ================================ --
-- DUMP DATA IN RELATIONSHIP TABLES --
-- ================================ --
INSERT INTO `character_related_stages` (
  `cid`,
  `sid`) VALUES
  (25, 1),
  (25, 3),
  (4, 4),
  (8, 4),
  (20, 4),
  (5, 5),
  (10, 5),
  (11, 5),
  (12, 5),
  (14, 5),
  (16, 5),
  (24, 5);
INSERT INTO `negative_matchups` (
  `cid1`,
  `cid2`) VALUES
  (2, 3),(2, 4),
  (3, 26),(3, 4),(3, 6),
  (4, 26),
  (5, 26),(5, 2),(5, 3),(5, 4),(5, 7),
  (6, 26),(6, 2),(6, 9),
  (7, 26),(7, 1),(7, 3),(7, 4),
  (8, 26),(8, 1),(8, 2),(8, 3),(8, 4),(8, 5),(8, 6),(8, 10),(8, 12),(8, 14),
  (9, 2),(9, 3),(9, 4),(9, 7),(9, 13),(9, 16),(9,17),
  (10, 26),(10, 1),(10, 2),(10, 3),(10, 5),(10, 7),(10, 13),
  (11, 26),(11, 1),(11, 2),(11, 3),(11, 4),(11, 5),(11, 6),(11, 7),(11, 8),(11, 9),(11, 10),(11, 12),(11, 13),(11, 14),(11, 15),(11, 16),(11, 17),(11, 21),
  (12, 26),(12, 1),(12, 2),(12, 3),(12, 4),(12, 5),(12, 7),(12, 9),(12, 13),(12, 16),
  (13, 26),(13, 1),(13, 3),(13, 4),(13, 7),
  (14, 26),(14, 1),(14, 2),(14, 3),(14, 4),(14, 5),(14, 6),(14, 7),(14, 9),(14, 13),
  (15, 26),(15, 1),(15, 2),(15, 3),(15, 4),(15, 5),(15, 6),(15, 7),(15, 8),(15, 9),(15, 10),(15, 12),(15, 13),(15, 14),(15, 16),
  (16, 26),(16, 1),(16, 2),(16, 3),(16, 4),(16, 5),(16, 6),(16, 7),(16, 13),(16, 20),
  (17, 26),(17, 1),(17, 2),(17, 3),(17, 4),(17, 5),(17, 7),(17, 10),(17, 12),(17, 13),(17, 14),(17, 15),
  (18, 26),(18, 1),(18, 2),(18, 3),(18, 4),(18, 5),(18, 6),(18, 7),(18, 8),(18, 9),(18, 10),(18, 12),(18, 13),(18, 14),(18, 15),(18, 16),(18, 17),(18, 21),
  (19, 26),(19, 1),(19, 2),(19, 3),(19, 4),(19, 5),(19, 6),(19, 7),(19, 8),(19, 9),(19, 10),(19, 12),(19, 13),(19, 14),(19, 15),(19, 16),(19, 17),(19, 20),(19, 21),(19, 25),
  (20, 26),(20, 1),(20, 2),(20, 3),(20, 4),(20, 5),(20, 6),(20, 7),(20, 8),(20, 9),(20, 10),(20, 12),(20, 13),(20, 14),(20, 15),(20, 17),(20, 18),
  (21, 26),(21, 1),(21, 2),(21, 3),(21, 4),(21, 5),(21, 6),(21, 7),(21, 8),(21, 12),(21, 13),(21, 15),(21, 16),(21, 17),(21, 20),
  (22, 26),(22, 1),(22, 2),(22, 3),(22, 4),(22, 5),(22, 6),(22, 7),(22, 8),(22, 9),(22, 10),(22, 12),(22, 13),(22, 14),(22, 15),(22, 16),(22, 17),(22, 18),(22, 19),(22, 20),(22, 21),
  (23, 26),(23, 1),(23, 2),(23, 3),(23, 4),(23, 5),(23, 6),(23, 7),(23, 8),(23, 9),(23, 10),(23, 12),(23, 13),(23, 14),(23, 15),(23, 16),(23, 17),(23, 18),(23, 19),(23, 20),(23, 21),(23, 22),
  (24, 26),(24, 1),(24, 2),(24, 3),(24, 4),(24, 5),(24, 6),(24, 7),(24, 8),(24, 9),(24, 10),(24, 12),(24, 13),(24, 14),(24, 15),(24, 16),(24, 17),(24, 18),(24, 19),(24, 20),(24, 21),(24, 22),(24, 25),
  (25, 26),(25, 1),(25, 2),(25, 3),(25, 4),(25, 5),(25, 6),(25, 7),(25, 8),(25, 9),(25, 10),(25, 11),(25, 12),(25, 13),(25, 14),(25, 15),(25, 16),(25, 18),(25, 20),(25, 21),(25, 22);
INSERT INTO `even_matchups` (
  `cid1`,
  `cid2`) VALUES
  (26, 1),(26, 2),(26, 9),
  (1, 26),(1, 2),(1, 3),(1, 4),(1, 5),(1, 6),(1, 9),
  (2, 26),(2, 1),(2, 7),(2, 13),
  (3, 1),
  (4, 1),(4, 6),(4, 10),
  (5, 1),(5, 9),(5, 13),
  (6, 1),(6, 4),(6, 7),(6, 10),(6, 12),(6, 17),
  (7, 2),(7, 6),(7, 8),
  (8, 7),(8, 9),(8, 13),(8, 16),(8, 17),
  (9, 26),(9, 1),(9, 5),(9, 8),(9, 10),(9, 21),
  (10, 4),(10, 6),(10, 9),(10, 12),(10, 14),(10, 16),(10, 21),
  (11, 18),(11, 19),(11, 20),(11, 22),(11, 23),(11, 24),
  (12, 6),(12, 10),(12, 14),
  (13, 2),(13, 5),(13, 8),
  (14, 10),(14, 12),(14, 16),(14, 21),
  (16, 8),(16, 10),(16, 14),(16, 17),
  (17, 6),(17, 8),(17, 16),(17, 25),
  (18, 11),(18, 19),
  (19, 11),(19, 18),
  (20, 11),
  (21, 9),(21, 10),(21, 14),
  (22, 11),
  (23, 24),(23, 25),
  (24, 11),(24, 23),
  (25, 17),(25, 23);
INSERT INTO `positive_matchups` (
  `cid1`,
  `cid2`) VALUES
  (26, 3),(26, 4),(26, 5),(26, 6),(26, 7),(26, 8),(26, 10),(26, 11),(26, 12),(26, 13),(26, 14),(26, 15),(26, 16),(26, 17),(26, 18),(26, 19),(26, 20),(26, 21),(26, 22),(26, 23),(26, 24),(26, 25),
  (1, 7),(1, 8),(1, 10),(1, 11),(1, 12),(1, 13),(1, 14),(1, 15),(1, 16),(1, 17),(1, 18),(1, 19),(1, 20),(1, 21),(1, 22),(1, 23),(1, 24),(1, 25),
  (2, 5),(2, 6),(2, 8),(2, 9),(2, 10),(2, 11),(2, 12),(2, 14),(2, 15),(2, 16),(2, 17),(2, 18),(2, 19),(2, 20),(2, 21),(2, 22),(2, 23),(2, 24),(2, 25),
  (3, 2),(3, 5),(3, 7),(3, 8),(3, 9),(3, 10),(3, 11),(3, 12),(3, 13),(3, 14),(3, 15),(3, 16),(3, 17),(3, 18),(3, 19),(3, 20),(3, 21),(3, 22),(3, 23),(3, 24),(3, 25),
  (4, 2),(4, 3),(4, 5),(4, 7),(4, 8),(4, 9),(4, 11),(4, 12),(4, 13),(4, 14),(4, 15),(4, 16),(4, 17),(4, 18),(4, 19),(4, 20),(4, 21),(4, 22),(4, 23),(4, 24),(4, 25),
  (5, 6),(5, 8),(5, 10),(5, 11),(5, 12),(5, 14),(5, 15),(5, 16),(5, 17),(5, 18),(5, 19),(5, 20),(5, 21),(5, 22),(5, 23),(5, 24),(5, 25),
  (6, 3),(6, 8),(6, 11),(6, 14),(6, 15),(6, 16),(6, 18),(6, 19),(6, 20),(6, 21),(6, 22),(6, 23),(6, 24),(6, 25),
  (7, 5),(7, 9),(7, 10),(7, 11),(7, 12),(7, 13),(7, 14),(7, 15),(7, 16),(7, 17),(7, 18),(7, 19),(7, 20),(7, 21),(7, 22),(7, 23),(7, 24),(7, 25),
  (8, 11),(8, 15),(8, 18),(8, 19),(8, 20),(8, 21),(8, 22),(8, 23),(8, 24),(8, 25),
  (9, 6),(9, 12),(9, 14),(9, 15),(9, 18),(9, 19),(9, 20),(9, 22),(9, 23),(9, 24),(9, 25),
  (10, 8),(10, 11),(10, 15),(10, 17),(10, 18),(10, 19),(10, 20),(10, 22),(10, 23),(10, 24),(10, 25),
  (11, 25),
  (12, 8),(12, 11),(12, 15),(12, 17),(12, 18),(12, 19),(12, 20),(12, 21),(12, 22),(12, 23),(12, 24),(12, 25),
  (13, 6),(13, 9),(13, 10),(13, 11),(13, 12),(13, 14),(13, 15),(13, 16),(13, 17),(13, 18),(13, 19),(13, 20),(13, 21),(13, 22),(13, 23),(13, 24),(13, 25),
  (14, 8),(14, 11),(14, 15),(14, 17),(14, 18),(14, 19),(14, 20),(14, 22),(14, 23),(14, 24),(14, 25),
  (15, 11),(15, 17),(15, 18),(15, 19),(15, 20),(15, 21),(15, 22),(15, 23),(15, 24),(15, 25),
  (16, 9),(16, 11),(16, 12),(16, 15),(16, 18),(16, 19),(16, 21),(16, 22),(16, 23),(16, 24),(16, 25),
  (17, 9),(17, 11),(17, 18),(17, 19),(17, 20),(17, 21),(17, 22),(17, 23),(17, 24),
  (18, 20),(18, 22),(18, 23),(18, 24),(18, 25),
  (19, 22),(19, 23),(19, 24),
  (20, 16),(20, 19),(20, 21),(20, 22),(20, 23),(20, 24),(20, 25),
  (21, 11),(21, 18),(21, 19),(21, 22),(21, 23),(21, 24),(21, 25),
  (22, 23),(22, 24),(22, 25),
  (25, 19),(25, 24);
