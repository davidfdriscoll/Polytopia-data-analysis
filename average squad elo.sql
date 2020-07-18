SELECT g.squad_id, avg(p.elo) as avg_squad_elo
  FROM gameside AS g
  JOIN squadmember AS s
    ON g.squad_id = s.squad_id
  JOIN player AS p
    ON s.player_id = p.id
 GROUP BY g.squad_id
LIMIT 20