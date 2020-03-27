SELECT  Killmails.killmail_time, Solarsystems.system_name AS solar_system, Characters.name AS victim_name, Corporations.name AS victims_corporation, Corporations.corporation_id AS victims_corporation_id, 
Alliances.name AS victims_alliance, Items.type_name AS victim_ship_name, Killmails.victim_damage_taken,
attackers.final_blow AS final_blow, attackers.attacker_name, attackers.attacker_ship_name AS attacker_ship, attackers.damage_done AS damage_done, attackers.attackers_corporation, attackers.attackers_alliance
FROM Killmails
LEFT JOIN ( SELECT Killmail_attackers.final_blow AS final_blow, Killmail_attackers.damage_done AS damage_done, Killmail_attackers.killmail_id AS killmail_id, 
            Characters.name AS attacker_name, Corporations.name AS attackers_corporation, Corporations.corporation_id AS attacker_corporation_id, Alliances.name AS attackers_alliance,
            Items.type_name AS attacker_ship_name
            FROM Killmail_attackers
            LEFT JOIN Characters
            ON Killmail_attackers.attacker_id = Characters.character_id
            LEFT JOIN Corporations
            ON Killmail_attackers.corporation_id = Corporations.corporation_id
            LEFT JOIN Alliances
            ON Killmail_attackers.alliance_id = Alliances.alliance_id
            LEFT JOIN Items
            ON Killmail_attackers.ship_type_id = Items.item_type_id
            WHERE Killmail_attackers.final_blow IS TRUE ) AS attackers
ON Killmails.killmail_id = attackers.killmail_id
LEFT JOIN Characters
ON Killmails.victim_id = Characters.character_id
LEFT JOIN Corporations 
ON Killmails.victim_corporation_id = Corporations.corporation_id
LEFT JOIN Alliances
ON Corporations.alliance_id = Alliances.alliance_id
LEFT JOIN Solarsystems
ON Killmails.solar_system_id = Solarsystems.solar_system_id
LEFT JOIN Items
ON Killmails.victim_ship_id = Items.item_type_id
