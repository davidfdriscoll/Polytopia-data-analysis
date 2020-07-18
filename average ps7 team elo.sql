SELECT t.name, round(avg(p.elo),0) as elo_average FROM player as p
  JOIN team AS t on p.team_id = t.id
 WHERE p.id in
		(SELECT DISTINCT player_id from lineup where game_id in
			(SELECT id FROM game WHERE LOWER(name) LIKE 'ps7%' OR LOWER(notes) LIKE '%ps7%')
		)
   AND (p.team_id between 13 and 22 or p.team_id = 220)
GROUP BY p.team_id, t.name
ORDER BY elo_average DESC