SELECT count(*) * 100 / (select count(*) from game where winner_id is not null and guild_id = 447883341463814144) 
  FROM gameside
  JOIN game
    ON gameside.game_id = game.id
 WHERE gameside.id = game.winner_id
   AND position = 1
   AND game.guild_id = 447883341463814144 