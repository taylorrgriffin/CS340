-- ========== --
-- CHARACTERS --
-- ========== --
-- pull all characters
SELECT c.character_id AS cid, c.name AS n, c.rank AS r, c.origin_universe, universe.name AS u FROM `character` AS c INNER JOIN `universe` ON universe.universe_id = c.origin_universe
-- add new character
INSERT INTO `character` (name, rank, origin_universe) VALUES ([charName], [charRank], [charOR])
-- delete character
DELETE FROM `character` WHERE character_id = [charID]
-- Filter characters by origin universe
SELECT c.character_id AS cid, c.name AS n, c.rank AS r, c.origin_universe FROM `character` AS c WHERE origin_universe = [charOR]
-- pull negative matchups
SELECT c1.name as n1, c1.character_id as id1, c2.name as n2, c2.character_id as id2 FROM `negative_matchups` AS nm INNER JOIN `character` AS c1 ON c1.character_id = nm.cid1 INNER JOIN `character` AS c2 ON c2.character_id = nm.cid2
-- pull even matchups
SELECT c1.name as n1, c1.character_id as id1, c2.name as n2, c2.character_id as id2 FROM `even_matchups` AS em INNER JOIN `character` AS c1 ON c1.character_id = em.cid1 INNER JOIN `character` AS c2 ON c2.character_id = em.cid2
-- pull positive matchups
SELECT c1.name as n1, c1.character_id as id1, c2.name as n2, c2.character_id as id2 FROM `positive_matchups` AS pm INNER JOIN `character` AS c1 ON c1.character_id = pm.cid1 INNER JOIN `character` AS c2 ON c2.character_id = pm.cid2

-- ====== --
-- STAGES --
-- ====== --
-- pull all stages
SELECT stags.stage_id as sid, stags.name as sname, uni.name as uname FROM `stage` AS stags LEFT JOIN `universe` AS uni ON stags.origin_universe = uni.universe_id
-- add new stage
INSERT INTO `stage` (name, origin_universe) VALUES ([stagName],[stagOR])
-- delete stage
DELETE FROM `stage` WHERE stage_id = [stagID]
-- update stage
UPDATE `stage` SET name=[newName], origin_universe=[newOR] WHERE stage_id=[stagID]

-- ========= --
-- UNIVERSES --
-- ========= --
-- pull all universes
SELECT universe_id as uid, name as uname, origin_year as u_or FROM `universe`
-- add new univese
INSERT INTO `universe` (name, origin_year) VALUES ([uniName], [uniOY])
-- delete universe
DELETE FROM `universe` WHERE universe_id = [uniID]

-- ======= --
-- PLAYERS --
-- ======= --
-- pull all players
SELECT player_id, tag, player_rank, main FROM `player` AS plays
-- add new player
INSERT INTO `player` (tag, rank, main) VALUES ([playTag], [playRank], [playMain])
-- delete player
DELETE FROM `player` WHERE player_id = [playId]
-- change specified player's main
UPDATE `player` SET main=[newMain] WHERE player_id = [playId]
