SELECT player.name, player_count.player_count FROM
(SELECT player_id, count(player_id) as player_count from lineup 
 where player_id in (select id from player where guild_id = 447883341463814144) 
  group by player_id) player_count
  JOIN player on player_count.player_id = player.id
  ORDER BY player_count.player_count desc