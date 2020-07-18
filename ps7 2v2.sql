WITH average_ps7_team_elo AS (
SELECT p.team_id, avg(p.elo) as team_average FROM player as p
 WHERE p.id in
		(SELECT DISTINCT player_id from lineup where game_id in
			(SELECT id FROM game WHERE LOWER(name) LIKE 'ps7%' OR LOWER(notes) LIKE '%ps7%')
		)
   AND (p.team_id between 13 and 22 or p.team_id = 220)
GROUP BY p.team_id
),
average_squad_elo AS (
SELECT g.squad_id, avg(p.elo) as squad_average
  FROM gameside AS g
  JOIN squadmember AS s
    ON g.squad_id = s.squad_id
  JOIN player AS p
    ON s.player_id = p.id
 GROUP BY g.squad_id
)
SELECT gs1.game_id, 
        gs1.sidename AS team, 
		gs2.sidename AS opposing_team, 
		round(sa.squad_average-ta.team_average,0) as squad_minus_team,
		round(ta.team_average,0) as team_average,
		round(sa.squad_average,0) as squad_average
  From gameside as gs1
  JOIN gameside AS gs2 ON gs1.game_id = gs2.game_id
  JOIN average_ps7_team_elo AS ta ON gs2.team_id = ta.team_id
  JOIN average_squad_elo AS sa ON gs2.squad_id = sa.squad_id
 WHERE gs1.game_id IN
(SELECT id FROM game WHERE LOWER(name) LIKE 'ps7%' OR LOWER(notes) LIKE '%ps7%')
   AND gs1.size = 2
   AND gs1.id != gs2.id
  ORDER BY gs1.sidename, gs2.sidename